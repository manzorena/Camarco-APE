
using NLog;
using System;
using System.Web.Mvc;

namespace Camarco
{
	public class BaseController : Controller
	{
		public Session.Session _currentSession = null;

		protected override void OnActionExecuting(ActionExecutingContext filterContext)
		{
			this._currentSession = new Session.Session();
			base.OnActionExecuting(filterContext);
		}

		protected override void OnException(ExceptionContext filterContext)
		{
			filterContext.ExceptionHandled = true;
			string name = filterContext.Exception.GetType().Name;
			if (name != null)
			{
				if (name == "SessionException")
				{
					filterContext.Result = base.RedirectToAction("Index", "Login");
					return;
				}
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
