using Camarco.Model;
using System;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class CuentaController : BaseController
	{
		public ActionResult Index()
		{
			return base.View();
		}

		[HttpPost]
		public ActionResult Index(FormCollection collection)
		{
			Usuario u = new Usuario(this._currentSession.UsuarioID);
			try
			{
				u.ChangePassword(collection["txtActual"], collection["txtNuevo"]);
				base.ViewData["mensaje"] = "Se ha actualizado el Password correctamente.";
			}
			catch
			{
				base.ViewData["error"] = "El password Actual ingresado no es correcto.";
			}
			return base.View();
		}
	}
}
