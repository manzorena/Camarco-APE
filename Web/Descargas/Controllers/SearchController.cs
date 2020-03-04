using Camarco.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Camarco.Web.Controllers
{
	public class SearchController : BaseFrontController
	{
		public ActionResult BibliotecaFilterDocumentos(int seccionid, int categoria, int subcategoria, string tag)
		{
			return base.View(DocumentoManager.ListFilteredByUser(seccionid, categoria, subcategoria, tag));
		}

		public ActionResult AgendaFilterArticulos(int seccionid, string tag)
		{
			return base.View(ArticuloManager.ListFilteredByUser(seccionid, tag));
		}

		public ActionResult GlobalSearch(string query, int page)
		{
			List<Resource> results = ResourceManager.GlobalSearch(query, page);
			base.ViewData["query"] = query;
			ActionResult result;
			if (results.Count == 0)
			{
				result = base.View("SinResultados");
			}
			else
			{
				base.ViewData["page"] = page + 1;
				base.ViewData["Resources"] = results;
				base.ViewData["Total"] = ResourceManager.GlobalSearchCount(query);
				base.ViewData["last"] = (Math.Ceiling((double)((int)base.ViewData["Total"]) / 10.0) >= (double)page);
				result = base.View();
			}
			return result;
		}

		public ActionResult GlobalSearchParcial(string query, int page, int seccion)
		{
			base.ViewData["seccion"] = seccion;
			base.ViewData["Resources"] = ResourceManager.GlobalSearch(query, page);
			return base.View();
		}

		public ActionResult CapacitacionParcial(int page, int seccion)
		{
			return base.View(ResourceManager.Capacitacion_List(seccion, page));
		}

		public ActionResult CapacitacionSearch(string query, int noticias, int cursos)
		{
			List<Curso> results = Cursos.GetProximosFiltered(query);
			base.ViewData["query"] = query;
			base.ViewData["checknoticias"] = ((noticias == 1) ? "checked=\"checked\"" : "");
			base.ViewData["checkcursos"] = ((cursos == 1) ? "checked=\"checked\"" : "");
			List<Resource> Otros = new List<Resource>();
			if (cursos == 1)
			{
				foreach (Curso c in Cursos.GetPasadosFiltered(query))
				{
					Otros.Add(c.Resource);
				}
			}
			if (noticias == 1)
			{
				int SeccionCapacitacionID = Secciones.ListByTemplate(4)[0].SeccionID;
				foreach (Documento d in DocumentoManager.ListFilteredByUser(SeccionCapacitacionID, -1, -1, ""))
				{
					d.LoadResource();
					Otros.Add(d.Resource);
				}
			}
			ActionResult result;
			if (results.Count == 0 && noticias == 1 && cursos == 1 && Otros.Count == 0)
			{
				result = base.View("CapacitacionSinResultados");
			}
			else if (results.Count == 0 && noticias == 0 && cursos == 0)
			{
				result = base.View("CapacitacionSinResultadosCasoC");
			}
			else if (results.Count == 0 && noticias == 1 && cursos == 0 && Otros.Count == 0)
			{
				result = base.View("CapacitacionSinResultadosCasoB");
			}
			else if (results.Count == 0 && noticias == 0 && cursos == 1 && Otros.Count == 0)
			{
				result = base.View("CapacitacionSinResultadosCasoA");
			}
			else
			{
				base.ViewData["Cursos"] = results;
				base.ViewData["Otros"] = Otros;
				result = base.View();
			}
			return result;
		}

		[HttpPost, OutputCache(Duration = 300, VaryByParam = "data")]
		public ActionResult EspacioPyme(string data)
		{
			JObject o = JObject.Parse(data);
			int[] s = new int[20];
			int i = 0;
			using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["secciones"])).GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					JValue secc = (JValue)enumerator.Current;
					s[i++] = (int)secc;
				}
			}
			ActionResult result;
			switch ((int)o["tipo"])
			{
			case 1:
				result = base.Content(Camarco.Model.EspacioPyme.SerializeResult(Camarco.Model.EspacioPyme.GetMasLeidos(s)), "application/json");
				break;
			case 2:
				result = base.Content(Camarco.Model.EspacioPyme.SerializeResult(Camarco.Model.EspacioPyme.GetMasDescargados(s)), "application/json");
				break;
			default:
				result = base.Content(Camarco.Model.EspacioPyme.SerializeResult(Camarco.Model.EspacioPyme.GetCursos()), "application/json");
				break;
			}
			return result;
		}
	}
}
