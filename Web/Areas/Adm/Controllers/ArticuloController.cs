using Camarco.Model;
using Camarco.Tools;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Caching;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class ArticuloController : BaseController
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
			if (base.HttpContext.Cache["BE_Articulos_Count"] == null)
			{
				base.HttpContext.Cache.Add("BE_Articulos_Count", ArticuloManager.CountAll(), null, Cache.NoAbsoluteExpiration, Cache.NoSlidingExpiration, CacheItemPriority.Normal, null);
			}
			base.ViewData["Paginator_Total"] = (int)base.HttpContext.Cache["BE_Articulos_Count"];
			base.ViewData["Items"] = ArticuloManager.List(page.Value, perpage.Value);
			return base.View();
		}

		public ActionResult ListFiltered(int page, int perpage, string nombre, int seccion)
		{
			base.ViewData["Filter_Nombre"] = nombre;
			base.ViewData["Filter_Seccion"] = seccion;
			base.ViewData["Paginator_Page"] = page;
			base.ViewData["Paginator_PerPage"] = perpage;
			base.ViewData["Paginator_Total"] = ArticuloManager.CountFiltered(nombre, seccion);
			base.ViewData["Items"] = ArticuloManager.ListFiltered(page, perpage, nombre, seccion);
			return base.View();
		}

		[HttpPost]
		public ActionResult Delete(int id)
		{
			ActionResult result;
			try
			{
                Log("Inicia Eliminacion");
				new Articulo(id).Remove();
			}
			catch (Exception ex)
			{
                Log("Error Eliminacion " + ex);
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			if (base.HttpContext.Cache["BE_Articulos_Count"] == null)
			{
				base.HttpContext.Cache.Remove("BE_Articulos_Count");
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		public ActionResult Nuevo()
		{
			return base.View("Articulo", new Articulo());
		}

		public ActionResult Editar(int id)
		{
			Articulo d = new Articulo(id);
			d.Resource.LoadSecciones();
			d.LoadArchivos();
			d.LoadImagenes();
			return base.View("Articulo", d);
		}

		[HttpPost]
		public ActionResult ArchivoDelete(int id)
		{
			ActionResult result;
			try
			{
				new ArticuloArchivo(id).Remove();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		[HttpPost]
		public ActionResult ImagenDelete(int id)
		{
			ActionResult result;
			try
			{
				new ArticuloImagen(id).Remove();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		[HttpPost, ValidateInput(false)]
		public ActionResult Save(string data)
		{
			JObject o = JObject.Parse(data);
			Articulo s = null;
			ActionResult result;
			try
			{
                Log("Inicia Save");
				if ((int)o["id"] == 0)
				{
					s = new Articulo();
				}
				else
				{
					s = new Articulo((int)o["id"]);
				}
				s.Resource.Nombre = (string)o["titulo"];
				s.Resource.Type = ResourceType.ARTICULO;
				s.Titulo = (string)o["titulo"];
				s.Subtitulo = (string)o["subtitulo"];
				s.DescripcionCorta = (string)o["descripcion"];
				s.DescripcionLarga = (string)o["descripcionlarga"];
				s.VideoURL = (string)o["video"];
				s.Destacado = (bool)o["destacado"];
                s.Evento = (bool)o["evento"];
				s.FechaHora = (string)o["fechaHora"];
				s.FechaPublicacion = Convert.ToDateTime((string)o["fechaPub"]);
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["seccionesasociadas"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject cat = (JObject)enumerator.Current;
						s.Resource.Secciones.Add(new Seccion((int)cat["id"]));
					}
				}
				s.Resource.Tags = (string)o["tags"];
				s.Resource.Save();
				s.ResourceID = s.Resource.ResourceID;
				s.Save();
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["images"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject d = (JObject)enumerator.Current;
						if ((int)d["id"] == 0)
						{
							string filename = Path.GetFileName((string)d["img"]);
							Camarco.Model.File a = new Camarco.Model.File();
							a.Filename = filename;
							a.Extension = Path.GetExtension((string)d["img"]).Replace(".", "");
							a.Kb = FileManager.GetKBytes(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", filename);
							a.Filebinary = FileManager.ReadBinaryFile(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", filename);
							a.Save();
							string filenamethumb = filename.Replace(Path.GetExtension((string)d["img"]), "") + "b" + Path.GetExtension((string)d["img"]);
							FileManager.CropImageMantainForThumb(142, 52, base.Server.MapPath("~/Uploads/" + (string)o["token"] + "\\" + filename), base.Server.MapPath("~/Uploads/" + (string)o["token"] + "\\" + filenamethumb));
							Camarco.Model.File b = new Camarco.Model.File();
							b.Filename = filenamethumb;
							b.Extension = a.Extension;
							b.Kb = FileManager.GetKBytes(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", filenamethumb);
							b.Filebinary = FileManager.ReadBinaryFile(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", filenamethumb);
							b.Save();
							new ArticuloImagen
							{
								FileID = a.FileID,
								FileThumbID = b.FileID,
								Orden = (byte)((int)d["orden"]),
								ArticuloID = s.ArticuloID
							}.Save();
						}
						else
						{
							new ArticuloImagen((int)d["id"])
							{
								Orden = (byte)((int)d["orden"])
							}.Save();
						}
					}
				}
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["archivos"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject d = (JObject)enumerator.Current;
						if ((int)d["id"] == 0)
						{
							Camarco.Model.File a = new Camarco.Model.File();
							a.Filename = Path.GetFileName((string)d["file"]);
							a.Extension = Path.GetExtension((string)d["file"]).Replace(".", "");
							a.Kb = FileManager.GetKBytes(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", Path.GetFileName((string)d["file"]));
							a.Filebinary = FileManager.ReadBinaryFile(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", Path.GetFileName((string)d["file"]));
							a.Save();
							new ArticuloArchivo
							{
								FileID = a.FileID,
								Titulo = (string)d["titulo"],
								ArticuloID = s.ArticuloID
							}.Save();
						}
					}
				}
			}
			catch (Exception ex)
			{
                Log("Error Save: " + ex.ToString());
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


        public static void Log(string logMessage)
        {
            using (StreamWriter sw = new StreamWriter("C:\\LogsWeb\\LogSitio - " + DateTime.Now.ToString("dd-MM-yyyy") + ".txt", true))
            {
                sw.Write("\r\nLog Entry : ");
                sw.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString());
                sw.WriteLine("{0}", logMessage);
                sw.WriteLine("-------------------------------");
            }
        }
	}
}
