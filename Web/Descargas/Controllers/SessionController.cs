using Camarco.Tools;
using Camarco.Web.WS.Camarco.NL;
using Newtonsoft.Json.Linq;
using NLog;
using System;
using System.Configuration;
using System.Collections.Specialized;
using System.Data;
using System.DirectoryServices.AccountManagement;
using System.Web.Mvc;
using System.Text;
using System.Net;
using WebApplication_CRM.Encrypter.Methods.Interfaces;
using WebApplication_CRM.Encrypter.Methods.Implementations;
using System.Diagnostics;
using Camarco.Model;

namespace Camarco.Web.Controllers
{

    
	public class SessionController : Controller
	{
        private static Logger logger = LogManager.GetCurrentClassLogger();

        private readonly RSAMethod _rsaMethod = new RSAMethod();

		[HttpPost]
		public ActionResult Validate(string data)
		{
            JObject o = JObject.Parse(data);

            Session["UserID"] = (string)o["u"];

			ActionResult result;
			try
			{
                var usr_pass="";
                string user_encripted="";

               //    { "textoEncriptado", "GxXPerpxlEHIG6nFMlUjSQfwW4SAtoyGH8gsq5zRqMD0qRXl0LJt3iosf9yGaHSHz2V5sd9/zsrUXQFvK51/A+KhXLqxDHr/Vf1mj2DVaDpkC3MyU8zN0pQsigxnBLm6CV0aL4opB8LxHvq64Nc7Cfl4EHuiT6v5PN8Mdcw6k/XWzQgaziE7juV/hWyVbND3p7ke/rZ959WlgWqVNpvkgR5gfZayxxZS9gJnLZ5rSHJDIz8GysA9ItuTelKxcanItyYLnyfugX8+rEPuWrLJ9nQXNYMR6usL1yu683WViQRag7cEV7Uyz2VdOmnHKOyo3EbmObFuzkM1huKyxKmEQg==" },
                try
                {
                    usr_pass = (string)o["u"] + "|" + (string)o["p"];
                    user_encripted = _rsaMethod.Encrypt(usr_pass);
                }
                catch (Exception ex)
                {
                    throw new Exception("Encrypt method failed. "+ ex);
                }

                string URI = "http://out.camarco.org.ar:8009/api/CRM/Post";
                string myParameters = '"'+user_encripted+'"';

                using (WebClient wc = new WebClient())
                {
                    wc.UseDefaultCredentials = true;
                    wc.Headers[HttpRequestHeader.ContentType] = "application/json";

                    var Error = false;
                    try
                    {
                        string HtmlResult = wc.UploadString(URI, myParameters);
                    }
                    catch
                    {
                        Error = true;
                    }
                    if (Error){throw new Exception("Usuario y/o contraseña no corresponden a un usuario registrado.");}
                }

                #region
                // AGREGAR ACA EL METODO DE VALIDACIÓN

                    //UserPrincipal user = UserPrincipal.FindByIdentity(pc, (string)o["u"]);

                    //if (user == null)
                    //{
                    //    throw new Exception("Usuario y/o contraseña no corresponden a un usuario registrado.");
                    //}
                    //if (!pc.ValidateCredentials((string)o["u"], (string)o["p"]))
                    //{
                    //    throw new Exception("Usuario y/o contraseña no corresponden a un usuario registrado.");
                //}



                
                #endregion
                base.Session["UserID"] = (string)o["u"];
                    base.Session["UserName"] = (string)o["u"];
					base.Session["Email"] = "";
					base.Session["Subscripto_Capacitacion"] = false;
					base.Session["Subscripto_Institucional"] = false;
               
#region
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
                #endregion
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
