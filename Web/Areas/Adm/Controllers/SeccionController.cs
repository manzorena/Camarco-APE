using Camarco.Model;
using Camarco.Tools;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class SeccionController : BaseController
	{
		public ActionResult List()
		{
			return base.View(Secciones.ListAll());
		}

		public ActionResult Nueva()
		{
			return base.View("Seccion", new Seccion());
		}

		public ActionResult NuevaPagina()
		{
			return base.View("Pagina", new Seccion());
		}

		public ActionResult Editar(int id)
		{
			Seccion s = new Seccion(id);
			s.LoadDestacados();
			s.LoadArchivos();
			return base.View("Seccion", s);
		}

		public ActionResult EditarPagina(int id)
		{
			Seccion s = new Seccion(id);
			s.LoadDestacados();
			s.LoadArchivos();
			return base.View("Pagina", s);
		}

		[HttpPost]
		public ActionResult Delete(int id)
		{
			ActionResult result;
			try
			{
				new Seccion(id).Remove();
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
		public ActionResult Reordenar(string data)
		{
			JObject o = JObject.Parse(data);
			ActionResult result;
			try
			{
				Seccion s = new Seccion((int)o["id"]);
				s.Reordenar((int)o["orden"]);
				if (HttpRuntime.Cache.Get("Menu") != null)
				{
					HttpRuntime.Cache.Remove("Menu");
				}
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
			ActionResult result;
			try
			{
				Seccion s = null;
				if ((int)o["id"] > 0)
				{
					s = new Seccion((int)o["id"]);
				}
				else
				{
					s = new Seccion();
				}
				s.Resource.Nombre = (string)o["nombre"];
				s.Resource.Type = ResourceType.SECCION;
				s.Resource.Tags = "";
				s.Resource.Save();
				s.ResourceID = s.Resource.ResourceID;
				s.Nombre = (string)o["nombre"];
				s.Descripcion = (string)o["descripcion"];
				s.TituloPagina = (string)o["titulopagina"];
				s.Template = int.Parse((string)o["template"]);
				s.Video = (string)o["video"];
				s.EspacioPyme = (bool)o["pyme"];
				if (s.Template == 5)
				{
					s.Texto = (string)o["texto"];
				}
				s.MenuPrincipal = (bool)o["principal"];
				s.Color = (string)o["color"];
				if ((bool)o["sub"])
				{
					s.Parent = new Seccion((int)o["subparent"]);
				}
				else
				{
					s.Parent = null;
				}
				s.Save();
				if (HttpRuntime.Cache.Get("Menu") != null)
				{
					HttpRuntime.Cache.Remove("Menu");
				}
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["images"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject d = (JObject)enumerator.Current;
						if ((int)d["id"] == 0)
						{
							Camarco.Model.File a = new Camarco.Model.File();
							a.Filename = Path.GetFileName((string)d["img"]);
							a.Extension = Path.GetExtension((string)d["img"]).Replace(".", "");
							a.Kb = FileManager.GetKBytes(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", a.Filename);
							a.Filebinary = FileManager.ReadBinaryFile(base.Server.MapPath("~/Uploads/" + (string)o["token"]) + "\\", a.Filename);
							a.Save();
							new SeccionDestacado
							{
								FileID = a.FileID,
								Titulo = (string)d["titulo"],
								Descripcion = (string)d["descripcion"],
								Orden = (byte)((int)d["orden"]),
								SeccionID = s.SeccionID
							}.Save();
						}
						else
						{
							new SeccionDestacado((int)d["id"])
							{
								Titulo = (string)d["titulo"],
								Descripcion = (string)d["descripcion"],
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
							new SeccionArchivo
							{
								Titulo = (string)d["titulo"],
								FileID = a.FileID,
								SeccionID = s.SeccionID
							}.Save();
						}
					}
				}
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
		public ActionResult ArchivoDelete(int id)
		{
			ActionResult result;
			try
			{
				new SeccionArchivo(id).Remove();
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
		public ActionResult DestacadoDelete(int id)
		{
			ActionResult result;
			try
			{
				new SeccionDestacado(id).Remove();
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
		public ActionResult AccesoDirectoDelete(int id)
		{
			ActionResult result;
			try
			{
				new AccesoDirecto(id).Remove();
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
		public ActionResult AccesoDirectoSave(string data)
		{
			JObject o = JObject.Parse(data);
			ActionResult result;
			try
			{
				int SeccionID = (int)o["id"];
				using (IEnumerator<JToken> enumerator = ((IEnumerable<JToken>)((JArray)o["menues"])).GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						JObject i = (JObject)enumerator.Current;
						AccesoDirecto ad;
						if ((int)i["id"] > 0)
						{
							ad = new AccesoDirecto((int)i["id"]);
						}
						else
						{
							ad = new AccesoDirecto();
						}
						ad.SeccionID = SeccionID;
						ad.Titulo = (string)i["titulo"];
						ad.Orden = (byte)((int)i["orden"]);
						ad.Save();
						using (IEnumerator<JToken> enumerator2 = ((IEnumerable<JToken>)((JArray)i["links"])).GetEnumerator())
						{
							while (enumerator2.MoveNext())
							{
								JObject j = (JObject)enumerator2.Current;
								if ((int)j["id"] == 0)
								{
									new AccesoDirectoLink
									{
										SeccionMenuID = ad.Id,
										Titulo = (string)j["titulo"],
										Link = (string)j["link"],
										ResourceID = (int)j["resourceid"]
									}.Save();
								}
							}
						}
					}
				}
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
		public ActionResult AccesoDirectoLinkDelete(int id)
		{
			ActionResult result;
			try
			{
				new AccesoDirectoLink(id).Remove();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		public ActionResult AccesoDirecto(int id)
		{
			base.ViewData["Menues"] = Secciones.GetAccesosDirectos(id);
			base.ViewData["Seccion"] = new Seccion(id);
			return base.View();
		}
	}
}
