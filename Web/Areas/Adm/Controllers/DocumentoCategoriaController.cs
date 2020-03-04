using Camarco.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class DocumentoCategoriaController : BaseController
	{
		public ActionResult List()
		{
			return base.View(DocumentoManager.GetCategorias());
		}

		[HttpPost]
		public ActionResult Delete(int id)
		{
			ActionResult result;
			try
			{
				new DocumentoCategoria(id).Remove();
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
		public ActionResult TieneDocumentos(int id)
		{
			ActionResult result;
			try
			{
				if (new DocumentoCategoria(id).TieneDocumentos())
				{
					result = base.Content("{\"status\":\"ok\", \"tiene\":\"1\"}", "application/json");
				}
				else
				{
					result = base.Content("{\"status\":\"ok\", \"tiene\":\"0\"}", "application/json");
				}
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
			}
			return result;
		}

		[HttpPost, ValidateInput(false)]
		public ActionResult Save(string data)
		{
			JObject o = JObject.Parse(data);
			DocumentoCategoria s = new DocumentoCategoria();
			ActionResult result;
			try
			{
				s.DocumentoCategoriaID = (int)o["id"];
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

		[HttpPost]
		public ActionResult Unificar(string data)
		{
			JObject o = JObject.Parse(data);
			ActionResult result;
			try
			{
				new DocumentoCategoria((int)o["id"]).Unificar((int)o["target"]);
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}
	}
}
