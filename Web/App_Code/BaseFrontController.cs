using NLog;
using System;
using System.Web.Mvc;

namespace Camarco.Web
{
	public class BaseFrontController : Controller
	{
		protected override void OnException(ExceptionContext filterContext)
		{
			filterContext.ExceptionHandled = true;
			string name = filterContext.Exception.GetType().Name;
			if (name != null)
			{
				if (name == "UnauthorizedError")
				{
					base.View("UnauthorizedError").ExecuteResult(base.ControllerContext);
					return;
				}
			}
			Logger logger = LogManager.GetLogger("CamarcoLogger");
			logger.Error(filterContext.Exception.ToString());
			base.View("Error").ExecuteResult(base.ControllerContext);
		}
	}
}
