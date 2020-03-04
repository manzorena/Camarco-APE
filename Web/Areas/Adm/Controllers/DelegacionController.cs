using Camarco.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class DelegacionController : BaseController
	{
		public ActionResult List()
		{
			return base.View(Delegaciones.ListAll());
		}

		public ActionResult Nueva()
		{
			return base.View("Delegacion", new Delegacion());
		}

		public ActionResult Editar(int id)
		{
			return base.View("Delegacion", new Delegacion(id));
		}

		[HttpPost]
		public ActionResult Delete(int id)
		{
			ActionResult result;
			try
			{
				new Delegacion(id).Remove();
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
				Delegacion s;
				if ((int)o["id"] > 0)
				{
					s = new Delegacion((int)o["id"]);
				}
				else
				{
					s = new Delegacion();
				}
				s.Nombre = (string)o["nombre"];
				s.Domicilio = (string)o["domicilio"];
				s.Contacto = (string)o["contacto"];
				s.Email = (string)o["email"];
				s.Fax = (string)o["fax"];
				s.Presidente = (string)o["presidente"];
				s.ProvinciaID = (int)o["provincia"];
				s.Save();
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
