using System;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm
{
	public class AdmAreaRegistration : AreaRegistration
	{
		public override string AreaName
		{
			get
			{
				return "Adm";
			}
		}

		public override void RegisterArea(AreaRegistrationContext context)
		{
			context.MapRoute("Adm_base", "Admin-Camarco/", new
			{
				controller = "Login",
				action = "Index",
				id = UrlParameter.Optional
			});
			context.MapRoute("Adm_default", "Admin-Camarco/{controller}/{action}/{id}", new
			{
				action = "Index",
				id = UrlParameter.Optional
			});
		}
	}
}
