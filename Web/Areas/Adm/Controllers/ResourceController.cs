using Camarco.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class ResourceController : Controller
	{
		[HttpPost]
		public ActionResult SimpleFilter(string data)
		{
			JObject o = JObject.Parse(data);
			return base.View(ResourceManager.SimpleFilter((int)o["seccionid"], int.Parse((string)o["tipo"]), (string)o["nombre"]));
		}
	}
}
