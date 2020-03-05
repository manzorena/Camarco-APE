using Camarco.Model;
using Camarco.Tools;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Caching;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class DocumentoController : BaseController
	{
		public ActionResult List(int? page, int? perpage)
		{
			if (!page.HasValue)
			{
				page = new int?(1);
				perpage = new int?(20);
			}
			base.ViewData["Paginator_Page"] = page;
			base.ViewData["Paginator_PerPage"] = perpage;
			if (base.HttpContext.Cache["BE_Documentos_Count"] == null)
			{
				base.HttpContext.Cache.Add("BE_Documentos_Count", DocumentoManager.CountAll(), null, Cache.NoAbsoluteExpiration, Cache.NoSlidingExpiration, CacheItemPriority.Normal, null);
			}
			base.ViewData["Paginator_Total"] = (int)base.HttpContext.Cache["BE_Documentos_Count"];
			base.ViewData["Items"] = DocumentoManager.List(page.Value, perpage.Value);
			return base.View();
		}

		public ActionResult ListFiltered(int page, int perpage, string filtro, string nombre, int seccion, int categoria)
		{
			base.ViewData["FiltroAplicado"] = filtro;
			base.ViewData["Filter_Nombre"] = nombre;
			base.ViewData["Filter_Seccion"] = seccion;
			base.ViewData["Filter_Categoria"] = categoria;
			base.ViewData["Paginator_Page"] = page;
			base.ViewData["Paginator_PerPage"] = perpage;
			base.ViewData["Paginator_Total"] = DocumentoManager.CountFiltered(nombre, seccion, categoria);
			base.ViewData["Items"] = DocumentoManager.ListFiltered(page, perpage, nombre, seccion, categoria);
			return base.View();
		}

		[HttpPost]
		public ActionResult Delete(int id)
		{
			ActionResult result;
			try
			{
				new Documento(id).Remove();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			if (base.HttpContext.Cache["BE_Documentos_Count"] == null)
			{
				base.HttpContext.Cache.Remove("BE_Documentos_Count");
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		public ActionResult Nuevo()
		{
			Documento d = new Documento();
			d.LoadResource();
			return base.View("Documento", d);
		}

		public ActionResult Editar(int id)
		{
			Documento d = new Documento(id);
			d.LoadResource();
			d.Resource.LoadSecciones();
			d.LoadCategorias();
			base.ViewData["fecha"] = d.FechaModificacion;
			return base.View("Documento", d);
		}

		[HttpPost, ValidateInput(false)]
		public ActionResult SaveCategoria(string data)
		{
			JObject o = JObject.Parse(data);
			DocumentoCategoria s = new DocumentoCategoria();
			ActionResult result;
			try
			{
				s.Nombre = (string)o["nombre"];
				if ((string)o["parent"] == "0")
				{
					s.Parent = null;
				}
				else
				{
					s.Parent = new DocumentoCategoria(int.Parse((string)o["parent"]));
				}
				s.Save();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\", \"id\":\"" + s.DocumentoCategoriaID.ToString() + "\"}", "application/json");
			return result;
		}

		[HttpPost, ValidateInput(false)]
		public ActionResult Save(string data)
		{
			JObject o = JObject.Parse(data);
			Documento s = null;
			ActionResult result;
			try
			{
				if ((int)o["id"] == 0)
				{
					s = new Documento();
				}
				else
				{
					s = new Documento((int)o["id"]);
				}
				s.LoadResource();
				s.Resource.Nombre = (string)o["titulo"];
				s.Resource.Type = ResourceType.DOCUMENTO;
				s.Titulo = (string)o["titulo"];
				s.Descripcion = (string)o["descripcion"];
				s.Publico = !(bool)o["privado"];
				s.FechaModificacion = Convert.ToDateTime((string)o["fechaModif"]);
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["clasificacion"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject cat = (JObject)enumerator.Current;
						s.Categorias.Add(new DocumentoCategoria((int)cat["id"]));
					}
				}
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["seccionesasociadas"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject cat = (JObject)enumerator.Current;
						s.Resource.Secciones.Add(new Seccion((int)cat["id"]));
						if (HttpRuntime.Cache.Get("Tematicas" + (int)cat["id"]) != null)
						{
							HttpRuntime.Cache.Remove("Tematicas" + (int)cat["id"]);
						}
					}
				}
				if ((string)o["contenido"] == "0")
				{
					string url = ((string)o["url"]).ToLower();
					if (!url.Contains("http") && !url.Contains("https"))
					{
						url = "http://" + url;
					}
					s.Resource.URL = url;
				}
				else if ((string)o["filename"] != "")
				{
					Camarco.Model.File a = new Camarco.Model.File();
					a.Filename = Path.GetFileName((string)o["filename"]);
					a.Extension = Path.GetExtension((string)o["filename"]).Replace(".", "");
					a.Kb = FileManager.GetKBytes(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", Path.GetFileName((string)o["filename"]));
					a.Filebinary = FileManager.ReadBinaryFile(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", Path.GetFileName((string)o["filename"]));
					a.Save();
					s.FileID = a.FileID;
					if (s.Publico)
					{
						s.Resource.URL = "/File/GetPublicFile?id=" + a.FileID;
					}
					else
					{
						s.Resource.URL = "/File/GetPrivateFile?id=" + a.FileID;
					}
				}
				s.Resource.Tags = (string)o["tags"];
				s.Resource.Save();
				s.ResourceID = s.Resource.ResourceID;
				s.Save();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			if (base.HttpContext.Cache["BE_Documentos_Count"] == null)
			{
				base.HttpContext.Cache.Remove("BE_Documentos_Count");
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}
	}
}
