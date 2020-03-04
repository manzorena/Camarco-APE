using Camarco.Model;
using Camarco.Session;
using System;
using System.Web;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class LoginController : Controller
	{
		public ActionResult Index()
		{
			return base.View();
		}

		public ActionResult Logout()
		{
            Session.Session s = new Session.Session();
			s.LogOut();
			return this.Redirect(base.Url.Action("Index", "Login", new
			{
				area = "Adm"
			}));
		}

		[HttpPost]
		public ActionResult Index(FormCollection formCollection)
		{
			ActionResult result;
			try
			{
				Usuario iUsuario = Login.ValidateCredentials(formCollection["txtUsuario"], formCollection["txtPassword"]);
				HttpCookie loginCookie = new HttpCookie("HUID");
				loginCookie.Value = iUsuario.GetCookie();
				loginCookie.Expires = DateTime.Now.AddMinutes(60.0);
				base.ControllerContext.HttpContext.Response.Cookies.Add(loginCookie);
				result = this.Redirect(base.Url.Action("List", "Seccion", new
				{
					area = "Adm"
				}));
			}
			catch (Exception ex)
			{
				base.ViewData["error"] = ex.Message.Replace(Environment.NewLine, "");
				result = base.View();
			}
			return result;
		}
	}
}
