using Camarco.Tools;
using Camarco.Web.WS.Camarco.NL;
using Newtonsoft.Json.Linq;
using NLog;
using System;
using System.Configuration;
using System.Data;
using System.DirectoryServices.AccountManagement;
using System.Web.Mvc;

namespace Camarco.Web.Controllers
{
	public class SessionController : Controller
	{
		[HttpPost]
		public ActionResult Validate(string data)
		{
            
            //JObject o = JObject.Parse(data);
            ActionResult result;
            //try
            //{
            //    string URI = "http://out.camarco.org.ar:8009/Api/CRM/Post";

            //    System.Net.WebClient client = new System.Net.WebClient();
            //    client.Headers.Add("content-type", "application/json");//set your header here, you can add multiple headers
            //    string s = Encoding.ASCII.GetString(client.UploadData(URI, "POST", Encoding.Default.GetBytes("")));

            //    alert();

            //        UserPrincipal user = UserPrincipal.FindByIdentity(pc, (string)o["u"]);

            //        if (user == null)
            //        {
            //            throw new Exception("Usuario y/o contraseña no corresponden a un usuario registrado.");
            //        }
            //        if (!pc.ValidateCredentials((string)o["u"], (string)o["p"]))
            //        {
            //            throw new Exception("Usuario y/o contraseña no corresponden a un usuario registrado.");
            //        }


            //        base.Session["UserID"] = (string)o["u"];
            //        base.Session["UserName"] = (string)o["u"];
            //        base.Session["Email"] = "";
            //        base.Session["Subscripto_Capacitacion"] = false;
            //        base.Session["Subscripto_Institucional"] = false;



                    //if (((string)base.Session["Email"]).Length > 0)
                    //{
                    //    try
                    //    {
                    //        api_2_1 gestorB = new api_2_1();
                    //        object e = gestorB.GetContactGroups(ConfigurationManager.AppSettings["gestorBApiKey"], ConfigurationManager.AppSettings["gestorBAccountID"], (string)base.Session["Email"]);
                    //        if (e != null)
                    //        {
                    //            if (e.GetType().Name == "ErrorResult")
                    //            {
                    //                if (((ErrorResult)e).Code != "108")
                    //                {
                    //                    Logger logger = LogManager.GetLogger("CamarcoLogger");
                    //                    logger.Error("Login > Newsletter > " + ((ErrorResult)e).Code + " : " + ((ErrorResult)e).Description);
                    //                }
                    //            }
                    //            else
                    //            {
                    //                foreach (DataRow grupo in ((DataSet)e).Tables[0].Rows)
                    //                {
                    //                    if ((string)grupo[1] == ConfigurationManager.AppSettings["gestorB_Grupo_Capacitacion"])
                    //                    {
                    //                        base.Session["Subscripto_Capacitacion"] = true;
                    //                    }
                    //                    if ((string)grupo[1] == ConfigurationManager.AppSettings["gestorB_Grupo_Institucional"])
                    //                    {
                    //                        base.Session["Subscripto_Institucional"] = true;
                    //                    }
                    //                }
                    //            }
                    //        }
                    //    }
                    //    catch (Exception ex)
                    //    {
                    //        Logger logger = LogManager.GetLogger("CamarcoLogger");
                    //        logger.Error("Login > GestorB > " + ex.Message);
                    //    }
                    //}
            //}
            //catch (Exception ex)
            //{
            //    result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
            //    return result;
            //}
            result = base.Content("{\"status\":\"ok\"}", "application/json");
            return result;
		}

		[HttpPost]
		public ActionResult Recover(string data)
		{
			JObject o = JObject.Parse(data);
			ActionResult result;
			try
			{
				Mail i = new Mail("Recuperacion de Contraseña");
				i.AddTo(ConfigurationManager.AppSettings["contactoEmail"]);
				string strBody = "Nombre y Apellido: " + (string)o["n"];
				strBody = strBody + Environment.NewLine + "Email: " + (string)o["m"];
				strBody = strBody + Environment.NewLine + "Empresa: " + (string)o["e"];
				i.SetPlaintextBody(strBody);
				i.Send();
			}
			catch (Exception ex)
			{
				result = base.Content("{\"status\":\"error\", \"message\":\"" + ex.Message.Replace(Environment.NewLine, "") + "\"}", "application/json");
				return result;
			}
			result = base.Content("{\"status\":\"ok\"}", "application/json");
			return result;
		}

		public ActionResult Logout()
		{
			base.Session.Clear();
			return base.RedirectToAction("Dispatch", "Templates");
		}
	}
}
