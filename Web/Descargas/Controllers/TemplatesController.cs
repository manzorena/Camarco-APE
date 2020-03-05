using Camarco.Integration;
using Camarco.Model;
using Camarco.Tools;
using Camarco.Tools.CRM;
using Camarco.Web.WS.Camarco.NL;
using Microsoft.Crm.Sdk;
using Microsoft.Crm.SdkTypeProxy;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NLog;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Caching;
using System.Web.Mvc;
using System.Net.Mail;
using System.Net;

namespace Camarco.Web.Controllers
{
	public class TemplatesController : BaseFrontController
	{
		[HttpPost]
		public ActionResult Contacto(string data)
		{
			JObject o = JObject.Parse(data);
			int DelegacionID = (int)o["del"];
			Mail i = new Mail("Contacto");
			if (DelegacionID > 0)
			{
				Delegacion d = new Delegacion(DelegacionID);
				string[] array = d.Email.Split(new char[]
				{
					';'
				});
				for (int j = 0; j < array.Length; j++)
				{
					string e = array[j];
					if (e.Length > 0)
					{
						i.AddTo(e);
					}
				}
			}
			else
			{
				i.AddTo(ConfigurationManager.AppSettings["contactoEmail"]);
			}
			string strBody = "Nombre y Apellido: " + (string)o["na"];
			strBody = strBody + Environment.NewLine + "Email: " + (string)o["em"];
			strBody = strBody + Environment.NewLine + "Empresa: " + (string)o["e"];
			strBody = strBody + Environment.NewLine + "Tel: " + (string)o["te"];
			strBody = strBody + Environment.NewLine + "Domicilio: " + (string)o["d"];
			strBody = strBody + Environment.NewLine + "Localidad: " + (string)o["l"];
			strBody = strBody + Environment.NewLine + "Provincia: " + (string)o["p"];
			strBody = strBody + Environment.NewLine + "Mensaje: " + (string)o["m"];
			if ((bool)o["s"])
			{
				api_2_1 gestorB = new api_2_1();
				List<string> campos = new List<string>();
				campos.Add("FirstName:" + (string)o["na"]);
				List<string> grupos = new List<string>();
				grupos.Add(ConfigurationManager.AppSettings["gestorB_Grupo_Institucional"]);
				object e2 = gestorB.AddOrUpdateContact(ConfigurationManager.AppSettings["gestorBApiKey"], ConfigurationManager.AppSettings["gestorBAccountID"], (string)o["em"], campos.ToArray(), grupos.ToArray(), false);
				if (e2.GetType().Name == "ErrorResult")
				{
					Logger logger = LogManager.GetLogger("CamarcoLogger");
					logger.Error("Login > Newsletter > " + ((ErrorResult)e2).Code + " : " + ((ErrorResult)e2).Description);
				}
			}
			i.SetPlaintextBody(strBody);
			i.Send();
			return base.Content("{\"status\":\"ok\"}", "application/json");
		}

		public ActionResult Contacto(int delegacion)
		{
			ActionResult result;
			if (delegacion == -1)
			{
				result = base.View();
			}
			else
			{
				result = base.View("ContactoDelegacion", new Delegacion(delegacion));
			}
			return result;
		}

		[HttpPost]
		public ActionResult Newsletter(string data)
		{
			JObject o = JObject.Parse(data);
			api_2_1 gestorB = new api_2_1();
			List<string> campos = new List<string>();
			campos.Add("FirstName:" + (string)o["n"]);
			campos.Add("LastName:" + (string)o["a"]);
			List<string> grupos = new List<string>();
			string text = (string)o["t"];
			if (text != null)
			{
				if (!(text == "capacitacion"))
				{
					if (text == "institucional")
					{
						grupos.Add(ConfigurationManager.AppSettings["gestorB_Grupo_Institucional"]);
					}
				}
				else
				{
					grupos.Add(ConfigurationManager.AppSettings["gestorB_Grupo_Capacitacion"]);
				}
			}
			//object e = gestorB.AddOrUpdateContact(ConfigurationManager.AppSettings["gestorBApiKey"], ConfigurationManager.AppSettings["gestorBAccountID"], (string)o["em"], campos.ToArray(), grupos.ToArray(), false);

            //envio de mail a sarajy@camarco.org.ar
            Mail mail = new Mail("Nueva suscripción al newsletter");
            mail.AddTo("sarajy@camarco.org.ar");
            mail.SetPlaintextBody("El usuario: " + (string)o["a"] + " " + (string)o["n"] + ", mail: " + (string)o["em"] + " " + "se suscribió al Newsletter" + text);
            mail.Send();

            //if (e.GetType().Name == "ErrorResult")
            //{
            //    Logger logger = LogManager.GetLogger("CamarcoLogger");
            //    logger.Error("Login > Newsletter > " + ((ErrorResult)e).Code + " : " + ((ErrorResult)e).Description);
            //}
			return base.Content("{\"status\":\"ok\"}", "application/json");
		}

		[OutputCache(Duration = 300, VaryByParam = "None")]
		public ActionResult EspacioPyme()
		{
			int[] s = new int[0];
			base.ViewData["JSON"] = Camarco.Model.EspacioPyme.SerializeResult(Camarco.Model.EspacioPyme.GetMasLeidos(s));
			return base.View();
		}

		[HttpPost]
		public ActionResult CursosMail(string data)
		{
			JObject o = JObject.Parse(data);
			Mail i = new Mail("Curso");
			i.AddTo(ConfigurationManager.AppSettings["contactoEmailCapacitacion"]);
			string strBody = "Nombre y Apellido: " + (string)o["na"];
			strBody = strBody + Environment.NewLine + "Email: " + (string)o["em"];
			Curso c = new Curso(o["id"].ToString());
			strBody = strBody + Environment.NewLine + "Curso: " + c.Titulo;
			object obj = strBody;
			strBody = string.Concat(new object[]
			{
				obj,
				Environment.NewLine,
				"Url: http://www.camarco.org.ar/Cursos/",
				c.CampaignID
			});
			strBody = strBody + Environment.NewLine + "Mensaje: " + (string)o["m"];
			if ((bool)o["s"])
			{
				api_2_1 gestorB = new api_2_1();
				List<string> campos = new List<string>();
				campos.Add("FirstName:" + (string)o["na"]);
				List<string> grupos = new List<string>();
				grupos.Add(ConfigurationManager.AppSettings["gestorB_Grupo_Capacitacion"]);
				object e = gestorB.AddOrUpdateContact(ConfigurationManager.AppSettings["gestorBApiKey"], ConfigurationManager.AppSettings["gestorBAccountID"], (string)o["em"], campos.ToArray(), grupos.ToArray(), false);
				if (e.GetType().Name == "ErrorResult")
				{
					Logger logger = LogManager.GetLogger("CamarcoLogger");
					logger.Error("Login > Newsletter > " + ((ErrorResult)e).Code + " : " + ((ErrorResult)e).Description);
				}
			}
			i.SetPlaintextBody(strBody);
			i.Send();
			return base.Content("{\"status\":\"ok\"}", "application/json");
		}

		public ActionResult Inscripcion()
		{
			string dni = "";
			if (base.Request["inscripcionDNI"] != null)
			{
				base.Session["inscripcionDNI"] = base.Request["inscripcionDNI"].ToString();
			}
			dni = base.Session["inscripcionDNI"].ToString();
			if (base.Request["campaignId"] != null)
			{
				base.Session["campaignId"] = base.Request["campaignId"].ToString();
			}
			DynamicEntity campaña = CRMHelper.Retrieve(base.Session["campaignId"].ToString());
			DynamicEntity unicoInscripto = CRMHelper.UnicoInscripto(base.Session["campaignId"].ToString(), base.Session["inscripcionDNI"].ToString());
			if (unicoInscripto != null)
			{
				base.Session["yaInscripto"] = "true";
			}
			else
			{
				base.Session["yaInscripto"] = "false";
			}
			base.Session["cursoGratis"] = "no";
			if (Convert.ToInt32(campaña["huddle_costonosocio"].ToString()) == 0)
			{
				base.Session["cursoGratis"] = "si";
			}
			try
			{
				base.ViewData["tipoEvento"] = ((Picklist)campaña["msa_eventtype"]).name;
			}
			catch (Exception)
			{
				base.ViewData["tipoEvento"] = "";
			}
			try
			{
				base.ViewData["delegacionCentral"] = ((Lookup)campaña["new_delegacioncentralid"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacionCentral"] = "";
			}
			try
			{
				base.ViewData["delegacion1"] = ((Lookup)campaña["new_delegacion1id"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacion1"] = "";
			}
			try
			{
				base.ViewData["delegacion2"] = ((Lookup)campaña["new_delegacion2id"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacion2"] = "";
			}
			try
			{
				base.ViewData["delegacion3"] = ((Lookup)campaña["new_delegacion3id"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacion3"] = "";
			}
			try
			{
				base.ViewData["delegacion4"] = ((Lookup)campaña["new_delegacion4id"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacion4"] = "";
			}
			try
			{
				base.ViewData["delegacion5"] = ((Lookup)campaña["new_delegacion5id"]).name;
			}
			catch (Exception)
			{
				base.ViewData["delegacion5"] = "";
			}
			RetrieveMultipleResponse collectionRol = CRMHelper.RetrieveLook("new_rolcargofuncion");
			using (List<BusinessEntity>.Enumerator enumerator = collectionRol.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["RolCargoFuncion"] = base.ViewData["RolCargoFuncion"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["RolCargoFuncion"] = base.ViewData["RolCargoFuncion"].ToString().Substring(0, base.ViewData["RolCargoFuncion"].ToString().Length - 1);
			RetrieveMultipleResponse collectionArea = CRMHelper.RetrieveLook("new_area");
			using (List<BusinessEntity>.Enumerator enumerator = collectionArea.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["area"] = base.ViewData["area"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["area"] = base.ViewData["area"].ToString().Substring(0, base.ViewData["area"].ToString().Length - 1);
			RetrieveMultipleResponse collectionTituloProfesional = CRMHelper.RetrieveLook("new_tituloprofesional");
			using (List<BusinessEntity>.Enumerator enumerator = collectionTituloProfesional.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["tituloProfesional"] = base.ViewData["tituloProfesional"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["tituloProfesional"] = base.ViewData["tituloProfesional"].ToString().Substring(0, base.ViewData["tituloProfesional"].ToString().Length - 1);
			RetrieveMultipleResponse collectionTipoDomicilio = CRMHelper.RetrieveLook("new_tipodomicilio");
			using (List<BusinessEntity>.Enumerator enumerator = collectionTipoDomicilio.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["tipoDomicilio"] = base.ViewData["tipoDomicilio"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["tipoDomicilio"] = base.ViewData["tipoDomicilio"].ToString().Substring(0, base.ViewData["tipoDomicilio"].ToString().Length - 1);
			RetrieveMultipleResponse collectionTipoOrg = CRMHelper.RetrieveLook("new_tipoorganizacion");
			using (List<BusinessEntity>.Enumerator enumerator = collectionTipoOrg.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["tipoOrganizacion"] = base.ViewData["tipoOrganizacion"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["tipoOrganizacion"] = base.ViewData["tipoOrganizacion"].ToString().Substring(0, base.ViewData["tipoOrganizacion"].ToString().Length - 1);
			RetrieveMultipleResponse collectionPregunta = CRMHelper.RetrieveLook("new_preguntafinal");
			using (List<BusinessEntity>.Enumerator enumerator = collectionPregunta.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					base.ViewData["pregunta"] = base.ViewData["pregunta"] + item["new_name"].ToString() + "§";
				}
			}
			base.ViewData["pregunta"] = base.ViewData["pregunta"].ToString().Substring(0, base.ViewData["pregunta"].ToString().Length - 1);
			DynamicEntity contacto = CRMHelper.ContactoByDNI(dni);
			base.ViewData["nombre"] = Curso.CompletarString(contacto, "firstname");
			base.ViewData["apellido"] = Curso.CompletarString(contacto, "lastname");
			base.ViewData["sexo"] = Curso.DevolverTextoPickList(contacto, "new_sexo");
			base.ViewData["emailaddress1"] = Curso.CompletarString(contacto, "emailaddress1");
			base.ViewData["DNI"] = dni;
			base.ViewData["telephone1"] = Curso.CompletarString(contacto, "telephone1");
			base.ViewData["mobilephone"] = Curso.CompletarString(contacto, "mobilephone");
			base.ViewData["tipo_domicilio"] = Curso.DevolverTextoPickList(contacto, "new_tipodomicilio");
			base.ViewData["address1_name"] = Curso.CompletarString(contacto, "address1_name");
			DateTime fecha = Curso.CompletarDate(contacto, "huddle_fechanacimiento");
			if (fecha == DateTime.Today)
			{
				base.ViewData["dia"] = "";
				base.ViewData["mes"] = "";
				base.ViewData["ano"] = "";
			}
			else
			{
				fecha = fecha.AddDays(1.0);
				base.ViewData["dia"] = fecha.Day.ToString();
				base.ViewData["mes"] = fecha.Month.ToString();
				base.ViewData["ano"] = fecha.Year.ToString();
			}
			decimal numeroCalle = Curso.CompletarNumberCRM(contacto, "huddle_address1numero");
			if (numeroCalle == 0m)
			{
				base.ViewData["huddle_address1numero"] = "";
			}
			else
			{
				base.ViewData["huddle_address1numero"] = numeroCalle;
			}
			base.ViewData["huddle_address1piso"] = Curso.CompletarString(contacto, "huddle_address1piso");
			base.ViewData["huddle_address1departamento"] = Curso.CompletarString(contacto, "huddle_address1departamento");
			base.ViewData["address1_city"] = Curso.CompletarString(contacto, "address1_city");
			base.ViewData["RolCargoFuncionSelected"] = Curso.DevolverTextoLookUp(contacto, "new_rolid");
			base.ViewData["areaSelected"] = Curso.DevolverTextoLookUp(contacto, "new_areaid");
			base.ViewData["tipoDomicilioSelected"] = Curso.DevolverTextoLookUp(contacto, "new_tipodomicilioid");
			base.ViewData["tituloProfesionalSelected"] = Curso.DevolverTextoLookUp(contacto, "new_tituloprofesionalid");
			base.ViewData["fecnac"] = Curso.CompletarDate(contacto, "huddle_fechanacimiento");
			base.ViewData["fecnac"] = base.ViewData["fecnac"].ToString().Substring(0, 10);
			string idEmpresa = Curso.CompletarCustomer(contacto, "parentcustomerid");
			DynamicEntity empresa = new DynamicEntity();
			empresa = CRMHelper.EmpresaById(idEmpresa);
			if (empresa == null)
			{
				base.ViewData["READONLY"] = "false";
			}
			try
			{
				if (empresa["accountnumber"].ToString() != "" && ((Picklist)empresa["new_condicion"]).name.ToString() == "Activo")
				{
					base.ViewData["READONLY"] = "true";
				}
				else
				{
					base.ViewData["READONLY"] = "false";
				}
			}
			catch (Exception)
			{
				base.ViewData["READONLY"] = "false";
			}
			base.ViewData["nameEmpresa"] = Curso.CompletarString(empresa, "name");
			base.ViewData["sic"] = Curso.CompletarString(empresa, "sic");
			base.ViewData["telefonoEmpresa"] = Curso.CompletarString(empresa, "telephone1");
			base.ViewData["mailEmpresa"] = Curso.CompletarString(empresa, "emailaddress1");
			base.ViewData["huddle_espyme"] = Curso.CompletarBoolCRM(empresa, "huddle_espyme");
			base.ViewData["dirEmpresa"] = Curso.CompletarString(empresa, "address1_name");
			decimal numeroCalleEmpresa = Curso.CompletarNumberCRM(empresa, "huddle_numero");
			if (numeroCalleEmpresa == 0m)
			{
				base.ViewData["huddle_numero"] = "";
			}
			else
			{
				base.ViewData["huddle_numero"] = numeroCalleEmpresa;
			}
			base.ViewData["huddle_piso"] = Curso.CompletarString(empresa, "huddle_piso");
			base.ViewData["huddle_departamento"] = Curso.CompletarString(empresa, "huddle_departamento");
			base.ViewData["ciudadEmpresa"] = Curso.CompletarString(empresa, "address1_city");
			base.ViewData["new_pais"] = Curso.CompletarString(empresa, "new_pais");
			base.ViewData["accountnumber"] = Curso.CompletarString(empresa, "accountnumber");
			base.ViewData["tipoOrganizacionSelected"] = Curso.DevolverTextoLookUp(empresa, "new_tipoorganizacionid");
			return base.View();
		}

		public ActionResult Facturacion()
		{
			DynamicEntity campaña = CRMHelper.Retrieve(base.Session["campaignId"].ToString());
			base.ViewData["codigoEvento"] = campaña["codename"].ToString();
			try
			{
				base.Session["nombreDelegacion"] = base.Request["delegacion"].ToString();
			}
			catch (Exception)
			{
				base.Session["nombreDelegacion"] = "Sede Central";
			}
			if (base.Session["nombreDelegacion"].ToString() == "Sede Central")
			{
				base.Session["costoCursoSocio"] = Convert.ToDouble(campaña["msa_costofadmission"].ToString());
			}
			else
			{
				base.Session["costoCursoSocio"] = Convert.ToDouble(campaña["huddle_costosociointerior"].ToString());
			}
			base.Session["costoCursoColegio"] = Convert.ToDouble(campaña["new_costocolegioprof"].ToString());
			base.Session["costoCursoEstudiante"] = Convert.ToDouble(campaña["new_costoestudiante"].ToString());
			base.Session["costoCursoNoSocio"] = Convert.ToDouble(campaña["huddle_costonosocio"].ToString());
			try
			{
				base.Session["costoCursoFuncionario"] = Convert.ToDouble(campaña["new_costofuncionario"].ToString());
			}
			catch (Exception)
			{
				base.Session["costoCursoFuncionario"] = base.Session["costoCursoColegio"].ToString();
			}
			if (base.Request["hidden_txt_cuit"] != null)
			{
				base.Session["empresaCuit"] = base.Request["hidden_txt_cuit"].ToString();
			}
			DynamicEntity empresa = null;
			if (base.Session["empresaCuit"].ToString() != "1")
			{
				empresa = CRMHelper.EmpresaByCuit(base.Session["empresaCuit"].ToString());
			}
			try
			{
				if (empresa["accountnumber"].ToString() != "" && ((Picklist)empresa["new_condicion"]).name == "Activo")
				{
					base.Session["empresaSocia"] = "true";
				}
				else
				{
					base.Session["empresaSocia"] = "false";
				}
			}
			catch (Exception)
			{
				base.Session["empresaSocia"] = "false";
			}
			if (base.Request["txt_mailEmpresa"] != null)
			{
				base.Session["empresaMail"] = base.Request["txt_mailEmpresa"].ToString();
			}
			try
			{
				base.Session["empresaTipo"] = base.Request["tipoOrg"].ToString();
			}
			catch (Exception)
			{
				base.Session["empresaTipo"] = "";
			}
			if (empresa == null && base.Request["txt_razon"] != null)
			{
				base.Session["empresaRazonSocial"] = base.Request["txt_razon"].ToString();
				if (base.Session["empresaCuit"].ToString() != "1")
				{
					base.Session["empresaCuitArmado"] = base.Session["empresaCuit"].ToString();
				}
				else
				{
					base.Session["empresaCuitArmado"] = base.Session["empresaCuit"].ToString();
				}
				base.Session["empresaTel"] = base.Request["txt_telEmpresa"].ToString();
				if (base.Request["pyme"] == null)
				{
					base.Session["empresaPyme"] = false;
				}
				else
				{
					base.Session["empresaPyme"] = true;
				}
				base.Session["empresaCalleNom"] = base.Request["calleEmp_nom"].ToString();
				try
				{
					base.Session["empresaCalleNum"] = Convert.ToInt32(base.Request["calleEmp_num"]);
				}
				catch (Exception)
				{
					base.Session["empresaCalleNum"] = 0;
				}
				base.Session["empresaPiso"] = base.Request["emp_piso"].ToString();
				base.Session["empresaDepto"] = base.Request["emp_dpto"].ToString();
				base.Session["empresaCiudad"] = base.Request["emp_ciudad"].ToString();
				base.Session["empresaPais"] = base.Request["emp_pais"].ToString();
				base.Session["empresaTipo"] = base.Request["tipoOrg"].ToString();
				if (base.Request["select_Socio"] == "Socio")
				{
					base.Session["empresaEsSocio"] = "Activo";
				}
				else
				{
					base.Session["empresaEsSocio"] = "";
				}
				DynamicEntity tipoEmpresa = CRMHelper.RetrieveEntityByName(base.Session["empresaTipo"].ToString(), "new_tipoorganizacion");
				base.Session["idTipo"] = ((Key)tipoEmpresa["new_tipoorganizacionid"]).Value.ToString();
			}
			base.Session["resp_nombre"] = base.Request["resp_nombre"].ToString();
			base.Session["resp_apellido"] = base.Request["resp_apellido"].ToString();
			base.Session["resp_mail"] = base.Request["resp_mail"].ToString();
			base.Session["resp_tel"] = base.Request["resp_tel"].ToString();
			base.Session["contactoNom"] = base.Request["nombre"].ToString();
			base.Session["contactoApellido"] = base.Request["apellido"].ToString();
			base.Session["contactoMail"] = base.Request["mail"].ToString();
			base.Session["contactoDni"] = base.Request["DNI"].ToString();
			base.Session["contactoTel"] = base.Request["telefono"].ToString();
			base.Session["contactoCel"] = base.Request["celular"].ToString();
			base.Session["contactoDirCalle"] = base.Request["calle_nom"].ToString();
			base.Session["contactoDirNum"] = Convert.ToInt32(base.Request["calle_num"]);
			base.Session["contactoDirPiso"] = base.Request["piso"].ToString();
			base.Session["contactoDirDepto"] = base.Request["depto"].ToString();
			base.Session["contactoCity"] = base.Request["ciudad"].ToString();
			base.Session["contactoPuesto"] = base.Request["cargo"].ToString();
			base.Session["contactoSexo"] = base.Request["sexo"].ToString();
			base.Session["contactoArea"] = base.Request["area"].ToString();
			base.Session["titulo_prof"] = base.Request["titulo_prof"].ToString();
			base.Session["contactoTipoDir"] = base.Request["tipo_domicilio"].ToString();
			base.Session["preguntaFinal"] = base.Request["pregunta"].ToString();
			base.Session["contactoAno"] = base.Request["ano"].ToString();
			base.Session["contactoMes"] = base.Request["mes"].ToString();
			base.Session["contactoDia"] = base.Request["dia"].ToString();
			DynamicEntity cargo = CRMHelper.RetrieveEntityByName(base.Session["contactoPuesto"].ToString(), "new_rolcargofuncion");
			base.Session["idCargo"] = ((Key)cargo["new_rolcargofuncionid"]).Value.ToString();
			DynamicEntity area = CRMHelper.RetrieveEntityByName(base.Session["contactoArea"].ToString(), "new_area");
			base.Session["idArea"] = ((Key)area["new_areaid"]).Value.ToString();
			DynamicEntity tipoDomicilio = CRMHelper.RetrieveEntityByName(base.Session["contactoTipoDir"].ToString(), "new_tipodomicilio");
			base.Session["idTipoDir"] = ((Key)tipoDomicilio["new_tipodomicilioid"]).Value.ToString();
			DynamicEntity tituloProf = CRMHelper.RetrieveEntityByName(base.Session["titulo_prof"].ToString(), "new_tituloprofesional");
			base.Session["idtitulo_prof"] = ((Key)tituloProf["new_tituloprofesionalid"]).Value.ToString();
			string nombreDelegacion = "Sede Central";
			if (base.Request["delegacion"] != null)
			{
				nombreDelegacion = base.Request["delegacion"].ToString();
			}
			base.Session["nombreDelegacion"] = nombreDelegacion;
			DynamicEntity delegacion = CRMHelper.DelegacionByNombre(nombreDelegacion);
			base.Session["idDelegacion"] = ((Key)delegacion["new_provinciaid"]).Value.ToString();
			ActionResult result;
			if (base.Session["cursoGratis"].ToString() == "si")
			{
				result = base.RedirectToAction("Respuesta", "Templates");
			}
			else
			{
				result = base.View();
			}
			return result;
		}

		public ActionResult Respuesta()
		{
			DynamicEntity campaña = CRMHelper.Retrieve(base.Session["campaignId"].ToString());
			if (base.Session["cursoGratis"].ToString() != "si")
			{
				string pagoO = "0";
				try
				{
					pagoO = base.Request["pagoOnline"].ToString();
				}
				catch (Exception)
				{
					string pagoC = base.Request["pagoCamara"].ToString();
				}
				if (pagoO == "1")
				{
					base.Session["modoPago"] = "Online";
				}
				else
				{
					base.Session["modoPago"] = "Camara";
				}
				base.Session["ordenCompra"] = base.Request["ordenCompra"].ToString();
				base.Session["porcentajeP"] = Convert.ToInt32(base.Request["porcentaje_part"]);
				base.Session["porcentajeE"] = Convert.ToInt32(base.Request["porcentaje_empresa"]);
				base.Session["cuilF"] = base.Request["Cuil_fact"];
				if (base.Session["cuilF"] == null)
				{
					base.Session["cuilF"] = "";
				}
				base.Session["cuitF"] = base.Request["Cuit_fact"];
				if (base.Session["cuitF"] == null)
				{
					base.Session["cuitF"] = "";
				}
				base.Session["razonF"] = base.Request["razon_fact"];
				if (base.Session["razonF"] == null)
				{
					base.Session["razonF"] = "";
				}
				base.Session["tipoArancel"] = base.Request["select_arancel"];
				base.Session["codigoProm"] = base.Request["codigoProm"].ToString();
				double costoCurso = 0.0;
				string error = "";
				base.Session["costoCursoSimple"] = Convert.ToDouble(campaña["huddle_costonosocio"].ToString());
				if (base.Session["tipoArancel"].ToString() == "Socio" && base.Session["nombreDelegacion"].ToString() == "Sede Central")
				{
					costoCurso = Convert.ToDouble(campaña["msa_costofadmission"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "socioBsAs";
				}
				if (base.Session["tipoArancel"].ToString() == "Socio" && base.Session["nombreDelegacion"].ToString() != "Sede Central")
				{
					costoCurso = Convert.ToDouble(campaña["huddle_costosociointerior"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "socioInt";
				}
				if (base.Session["tipoArancel"].ToString() == "Colegio")
				{
					costoCurso = Convert.ToDouble(campaña["new_costocolegioprof"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "colegio";
				}
				if (base.Session["tipoArancel"].ToString() == "Estudiante")
				{
					costoCurso = Convert.ToDouble(campaña["new_costoestudiante"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "estudiante";
				}
				if (base.Session["tipoArancel"].ToString() == "Beca")
				{
					costoCurso = Convert.ToDouble(campaña["huddle_costonosocio"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "beca";
				}
				if (base.Session["tipoArancel"].ToString() == "NoSocio")
				{
					costoCurso = Convert.ToDouble(campaña["huddle_costonosocio"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "noSocio";
				}
				if (base.Session["tipoArancel"].ToString() == "Funcionario")
				{
					costoCurso = Convert.ToDouble(campaña["new_costofuncionario"].ToString());
					base.Session["costoCurso"] = costoCurso;
					base.Session["opcionPago"] = "funcionario";
				}
				base.Session["estadoInscripcion"] = "Pendiente";
				base.Session["estadoPago"] = "Pendiente";
				if (base.Session["codigoProm"].ToString() != "")
				{
					DynamicEntity promo = CRMHelper.PromoById(base.Session["codigoProm"].ToString());
					if (promo != null && ((CrmBoolean)promo["new_usado"]).Value.ToString() == "False")
					{
						base.Session["costoCurso"] = Convert.ToDouble(costoCurso.ToString()) * Convert.ToDouble(((CrmDecimal)promo["new_descuento"]).Value);
						base.Session["estadoInscripcion"] = "Pendiente";
						base.ViewData["mensajeCodigoProm"] = "Código de promoción: Confirmado";
					}
					else
					{
						base.Session["costoCurso"] = costoCurso;
						error = "El código de promoción ingresado ya fue utilizado o es incorrecto. Asegúrese de distinguir entre mayúsculas y minúsculas, y de agregar los guiones medios. Si no existieron errores la Escuela de Gestión se comunicará con usted para validar su código de promoción.";
						base.Session["estadoInscripcion"] = "Pendiente";
						base.ViewData["mensajeCodigoProm"] = "Código de promoción: No confirmado";
					}
				}
				if (base.Session["modoPago"].ToString() == "Online")
				{
					base.Session["estadoInscripcion"] = "Iniciado";
					base.Session["estadoPago"] = "Pendiente";
				}
				if (base.Session["modoPago"].ToString() == "Camara")
				{
					base.Session["estadoInscripcion"] = "Pendiente";
					base.Session["estadoPago"] = "Pendiente";
				}
				DynamicEntity pregunta = CRMHelper.RetrieveEntityByName(base.Session["preguntaFinal"].ToString(), "new_preguntafinal");
				base.Session["idPregunta"] = ((Key)pregunta["new_preguntafinalid"]).Value.ToString();
				base.ViewData["cNombreApellido"] = base.Session["contactoNom"] + " " + base.Session["contactoApellido"];
				base.Session["cCursoNombre"] = campaña["msa_eventname"].ToString();
				base.ViewData["cCosto"] = base.Session["costoCurso"].ToString();
				base.ViewData["cCostoCurso"] = base.Session["costoCursoSimple"].ToString();
				base.ViewData["cError"] = error;
			}
			else
			{
				DynamicEntity pregunta = CRMHelper.RetrieveEntityByName(base.Session["preguntaFinal"].ToString(), "new_preguntafinal");
				base.Session["idPregunta"] = ((Key)pregunta["new_preguntafinalid"]).Value.ToString();
				base.Session["modoPago"] = "Camara";
				base.ViewData["cNombreApellido"] = base.Session["contactoNom"] + " " + base.Session["contactoApellido"];
				base.Session["cCursoNombre"] = campaña["msa_eventname"].ToString();
				base.ViewData["cCosto"] = "0";
				base.ViewData["cCostoCurso"] = "0";
			}
			return base.View();
		}

		public ActionResult Confirmacion()
		{
			DynamicEntity contacto = CRMHelper.ContactoByDNI(base.Session["contactoDni"].ToString());
			DynamicEntity empresa = null;
			if (base.Session["empresaCuit"].ToString() != "1")
			{
				empresa = CRMHelper.EmpresaByCuit(base.Session["empresaCuit"].ToString());
			}
			string idEmpresa;
			if (empresa == null)
			{
				if (base.Session["empresaRazonSocial"] != null)
				{
					string empresaRazonSocial = base.Session["empresaRazonSocial"].ToString();
					string empresaCuitArmado = base.Session["empresaCuit"].ToString();
					string empresaTel = base.Session["empresaTel"].ToString();
					string empresaMail = base.Session["empresaMail"].ToString();
					bool empresaPyme = base.Session["pyme"] != null;
					string empresaCalleNom = base.Session["empresaCalleNom"].ToString();
					int empresaCalleNum = Convert.ToInt32(base.Session["empresaCalleNum"].ToString());
					string empresaPiso = base.Session["empresaPiso"].ToString();
					string empresaDepto = base.Session["empresaDepto"].ToString();
					string empresaCiudad = base.Session["empresaCiudad"].ToString();
					string empresaPais = base.Session["empresaPais"].ToString();
					string empresaTipo = base.Session["empresaTipo"].ToString();
					string empresaEsSocio;
					if (base.Session["empresaEsSocio"].ToString() == "Socio")
					{
						empresaEsSocio = "Activo";
					}
					else
					{
						empresaEsSocio = "";
					}
					string idTipo = base.Session["idTipo"].ToString();
					idEmpresa = CRMHelper.CreateEmpresa(empresaRazonSocial.ToUpper(), empresaCuitArmado.ToUpper(), empresaTel.ToUpper(), empresaMail.ToUpper(), empresaPyme, empresaCalleNom.ToUpper(), empresaCalleNum, empresaPiso.ToUpper(), empresaDepto.ToUpper(), empresaCiudad.ToUpper(), empresaPais.ToUpper(), empresaEsSocio.ToUpper(), idTipo);
				}
				else
				{
					idEmpresa = ((Customer)contacto["parentcustomerid"]).Value.ToString();
				}
			}
			else
			{
				idEmpresa = ((Key)empresa["accountid"]).Value.ToString();
			}
			string contactoNom = base.Session["contactoNom"].ToString();
			string contactoApellido = base.Session["contactoApellido"].ToString();
			string contactoMail = base.Session["contactoMail"].ToString();
			string contactoDni = base.Session["contactoDni"].ToString();
			string contactoTel = base.Session["contactoTel"].ToString();
			string contactoCel = base.Session["contactoCel"].ToString();
			string contactoDirCalle = base.Session["contactoDirCalle"].ToString();
			int contactoDirNum = Convert.ToInt32(base.Session["contactoDirNum"].ToString());
			string contactoDirPiso = base.Session["contactoDirPiso"].ToString();
			string contactoDirDepto = base.Session["contactoDirDepto"].ToString();
			string contactoCity = base.Session["contactoCity"].ToString();
			string contactoPuesto = base.Session["contactoPuesto"].ToString();
			string contactoSexo = base.Session["contactoSexo"].ToString();
			string contactoArea = base.Session["contactoArea"].ToString();
			string contactoTipoDir = base.Session["contactoTipoDir"].ToString();
			string contactoAno = base.Session["contactoAno"].ToString();
			string contactoMes = base.Session["contactoMes"].ToString();
			string contactoDia = base.Session["contactoDia"].ToString();
			string contactoTitulo = base.Session["titulo_prof"].ToString();
			string idCargo = base.Session["idCargo"].ToString();
			string idArea = base.Session["idArea"].ToString();
			string idTipoDir = base.Session["idTipoDir"].ToString();
			string idTitulo = base.Session["idtitulo_prof"].ToString();
			string idContacto;
			if (contacto == null)
			{
				idContacto = CRMHelper.CreateContacto(contactoNom.ToUpper(), contactoApellido.ToUpper(), contactoMail.ToUpper(), contactoDni.ToUpper(), contactoTel.ToUpper(), contactoCel.ToUpper(), contactoDirCalle.ToUpper(), contactoDirNum, contactoDirPiso.ToUpper(), contactoDirDepto.ToUpper(), contactoCity.ToUpper(), idCargo.ToUpper(), idEmpresa.ToUpper(), contactoSexo.ToUpper(), idArea.ToUpper(), idTipoDir.ToUpper(), contactoAno.ToUpper(), contactoMes.ToUpper(), contactoDia.ToUpper(), idTitulo.ToUpper());
			}
			else
			{
				idContacto = ((Key)contacto["contactid"]).Value.ToString();
				CRMHelper.UpdateContacto(idContacto.ToUpper(), contactoNom.ToUpper(), contactoApellido.ToUpper(), contactoMail.ToUpper(), contactoDni.ToUpper(), contactoTel.ToUpper(), contactoCel.ToUpper(), contactoDirCalle.ToUpper(), contactoDirNum, contactoDirPiso.ToUpper(), contactoDirDepto.ToUpper(), contactoCity.ToUpper(), idCargo.ToUpper(), idEmpresa.ToUpper(), contactoSexo.ToUpper(), idArea.ToUpper(), idTipoDir.ToUpper(), contactoAno.ToUpper(), contactoMes.ToUpper(), contactoDia.ToUpper(), idTitulo.ToUpper());
			}
			DynamicEntity empresaDatos = CRMHelper.EmpresaById(idEmpresa);
			string empresaDatosCuit = Curso.CompletarString(empresaDatos, "sic");
			string empresaDatosRazon = Curso.CompletarString(empresaDatos, "name");
			string empresaDatosSocio = "";
			if (base.Session["empresaSocia"].ToString() == "true")
			{
				empresaDatosSocio = "si";
			}
			string empresaDatosMail = "";
			if (base.Session["empresaMail"] != null)
			{
				empresaDatosMail = base.Session["empresaMail"].ToString();
			}
			else
			{
				empresaDatosMail = Curso.CompletarString(empresaDatos, "emailaddress1");
			}
			string empresaDatosTel = Curso.CompletarString(empresaDatos, "telephone1");
			string empresaDatosCiudad = Curso.CompletarString(empresaDatos, "address1_city");
			string empresaDatosDir = Curso.CompletarString(empresaDatos, "address1_name");
			string empresaDatosNum = Curso.CompletarNumberCRM(empresaDatos, "huddle_numero").ToString();
			string empresaDatosPiso = Curso.CompletarString(empresaDatos, "huddle_piso");
			string empresaDatosDepto = Curso.CompletarString(empresaDatos, "huddle_departamento");
			string empresaDatosTipo = base.Session["empresaTipo"].ToString();
			string idDelegacion = base.Session["idDelegacion"].ToString();
			int porcentajeP;
			int porcentajeE;
			string cuilF;
			string cuitF;
			string razonF;
			string costoCurso;
			string ordenCompra;
			string estadoInscripcion;
			string estadoPago;
			string opcionPago;
			string modoPago;
			try
			{
				porcentajeP = Convert.ToInt32(base.Session["porcentajeP"].ToString());
				porcentajeE = Convert.ToInt32(base.Session["porcentajeE"].ToString());
				cuilF = base.Session["cuilF"].ToString();
				cuitF = base.Session["cuitF"].ToString();
				razonF = base.Session["razonF"].ToString();
				string preguntaFinal = base.Session["preguntaFinal"].ToString();
				string tipoArancel = base.Session["tipoArancel"].ToString();
				string codigoProm = base.Session["codigoProm"].ToString();
				costoCurso = base.Session["costoCurso"].ToString();
				ordenCompra = base.Session["ordenCompra"].ToString();
				estadoInscripcion = base.Session["estadoInscripcion"].ToString();
				estadoPago = base.Session["estadoPago"].ToString();
				opcionPago = base.Session["opcionPago"].ToString();
				modoPago = base.Session["modoPago"].ToString();
			}
			catch (Exception)
			{
				porcentajeP = 0;
				porcentajeE = 0;
				cuilF = "";
				cuitF = "";
				razonF = "";
				costoCurso = "";
				ordenCompra = "";
				estadoInscripcion = "";
				estadoPago = "";
				opcionPago = "";
				modoPago = "";
			}
			DynamicEntity campaña = CRMHelper.Retrieve(base.Session["campaignId"].ToString());
			string idPregunta = base.Session["idPregunta"].ToString();
			string respNombre = base.Session["resp_nombre"].ToString();
			string respApellido = base.Session["resp_apellido"].ToString();
			string respMail = base.Session["resp_mail"].ToString();
			string respTel = base.Session["resp_tel"].ToString();
			string idProm = "";
			string porcentajeBeca = "";
			if (base.Session["cursoGratis"].ToString() != "si")
			{
				DynamicEntity promo = CRMHelper.PromoById(base.Session["codigoProm"].ToString());
				if (promo != null && ((CrmBoolean)promo["new_usado"]).Value.ToString() == "False")
				{
					idProm = ((Key)promo["new_promocionid"]).Value.ToString();
                    //Camarco.Tools.CRM.CRMHelper.DesactivarCodigo(idProm, contactoDni);
                    Camarco.Tools.CRM.CRMHelper.DesactivarCodigo(idProm, contactoDni);

					decimal porcentaje = ((CrmDecimal)promo["new_descuento"]).Value * 100m;
					porcentajeBeca = Convert.ToInt32(porcentaje).ToString() + "%";
				}
			}
			string idCamp = base.Session["campaignId"].ToString();
			string rtaCam = Camarco.Tools.CRM.CRMHelper.AgregarRespuestaCampaña(porcentajeBeca.ToUpper(), idProm.ToUpper(), idCamp.ToUpper(), idContacto.ToUpper(), contactoDni.ToUpper(), idDelegacion.ToUpper(), porcentajeP, porcentajeE, cuilF.ToUpper(), cuitF.ToUpper(), razonF.ToUpper(), idPregunta.ToUpper(), costoCurso.ToUpper(), ordenCompra.ToUpper(), estadoInscripcion.ToUpper(), respNombre.ToUpper(), respApellido.ToUpper(), respTel.ToUpper(), respMail.ToUpper(), estadoPago.ToUpper(), contactoPuesto.ToUpper(), contactoNom.ToUpper(), contactoApellido.ToUpper(), contactoDia.ToUpper(), contactoMes.ToUpper(), contactoAno.ToUpper(), contactoTel.ToUpper(), contactoCel.ToUpper(), contactoCity.ToUpper(), contactoDirCalle.ToUpper(), contactoDirNum, contactoDirPiso.ToUpper(), contactoDirDepto.ToUpper(), empresaDatosCuit.ToUpper(), empresaDatosRazon.ToUpper(), empresaDatosSocio.ToUpper(), empresaDatosMail.ToUpper(), empresaDatosTel.ToUpper(), empresaDatosCiudad.ToUpper(), empresaDatosDir.ToUpper(), empresaDatosNum.ToUpper(), empresaDatosPiso.ToUpper(), empresaDatosDepto.ToUpper(), contactoTitulo.ToUpper(), modoPago.ToUpper(), opcionPago.ToUpper(), idEmpresa, contactoMail.ToUpper(), empresaDatosTipo.ToUpper());
			if (base.Session["modoPago"].ToString() == "Camara")
			{
				base.Response.Redirect("/", false);
			}
			base.ViewData["rtaCam"] = rtaCam;
			base.ViewData["api"] = "9kO2C7Mj5m19sRBvgbhTWErHDw";
			base.ViewData["merchantId"] = "533404";
			base.ViewData["accountId"] = "535345";
			base.ViewData["currency"] = "ARS";
			base.ViewData["amount"] = costoCurso.ToString();
			string firma = string.Concat(new string[]
			{
				base.ViewData["api"].ToString(),
				"~",
				base.ViewData["merchantId"].ToString(),
				"~",
				base.ViewData["rtaCam"].ToString(),
				"~",
				base.ViewData["amount"].ToString(),
				"~",
				base.ViewData["currency"].ToString()
			});
			MD5 md5 = MD5.Create();
			byte[] inputBytes = Encoding.ASCII.GetBytes(firma);
			byte[] hash = md5.ComputeHash(inputBytes);
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < hash.Length; i++)
			{
				sb.Append(hash[i].ToString("X2"));
			}
			string firmaHash = sb.ToString();
			base.ViewData["signature"] = firmaHash;
			return base.View();
		}

		public void VerMas(string data)
		{
			if (base.Session["pagina"] != null)
			{
				if (Convert.ToInt32(base.Session["pagina"].ToString()) == 0)
				{
					base.Session["pagina"] = Convert.ToInt32(base.Session["pagina"].ToString()) + 10;
				}
				else
				{
					base.Session["pagina"] = Convert.ToInt32(base.Session["pagina"].ToString()) + 5;
				}
			}
			else
			{
				base.Session["pagina"] = 10;
			}
			base.Response.Redirect("/Capacitacion", false);
		}

		public ActionResult RespuestaPayU()
		{
			try
			{
				string codResp = base.Request.Form["reference_sale"];
				string estado = base.Request.Form["state_pol"];
				string metodoPago = "Efectivo";
				string medioPago = base.Request.Form["payment_method_name"];
				string idPago = base.Request.Form["transaction_id"];
				try
				{
					if (base.Request.Form["payment_method_id"].ToString() == "2")
					{
						metodoPago = "Credito";
					}
					if (base.Request.Form["payment_method_id"].ToString() == "7")
					{
						metodoPago = "Efectivo";
					}
					if (base.Request.Form["payment_method_id"].ToString() == "4")
					{
						metodoPago = "Transferencia";
					}
				}
				catch (Exception)
				{
					metodoPago = "Efectivo";
				}
				string cuotas;
				try
				{
					cuotas = base.Request.Form["installments_number"];
				}
				catch (Exception)
				{
					cuotas = "0";
				}
				string requestMontoTotal = base.Request.Form["value"];
				requestMontoTotal = requestMontoTotal.Replace(",", ".");
				float montoFloat = float.Parse(requestMontoTotal, CultureInfo.InvariantCulture.NumberFormat);
				double montoInt = (double)Convert.ToInt32(montoFloat);
				double comision;
				double montoNeto;
				if (metodoPago == "Credito")
				{
					comision = (montoInt * 4.99 / 100.0 + 3.0) * 1.21;
					montoNeto = montoInt - comision;
				}
				else
				{
					comision = (montoInt * 3.99 / 100.0 + 3.0) * 1.21;
					montoNeto = montoInt - comision;
				}
				montoNeto = Convert.ToDouble(montoNeto.ToString("#.##"));
				if (estado == "4")
				{
					CRMHelper.PagoRespuesta(codResp, idPago, montoNeto, metodoPago, medioPago, cuotas, comision.ToString());
				}
			}
			catch (Exception)
			{
			}
			return base.View();
		}

		public ActionResult Cursos(string slug)
		{
			ActionResult result;
			if (slug == null)
			{
				result = base.View();
			}
			else if (slug.Length > 11)
			{
				result = base.View("Curso", Camarco.Model.Cursos.GetByCRMCampaignId(slug));
			}
			else
			{
				result = base.View("Curso", Camarco.Model.Cursos.GetByCRMDNI(slug));
			}
			return result;
		}

		public ActionResult Dispatch(string slug_s, string slug_ss, string slug_r)
		{
			if (HttpRuntime.Cache.Get("CursosRefresh") == null)
			{
				Thread updateThread = new Thread(new ParameterizedThreadStart(Sync.Cursos));
				updateThread.Start(base.Server.MapPath("~/Uploads/"));
				HttpRuntime.Cache.Insert("CursosRefresh", "1", null, DateTime.Now.AddDays(1.0), Cache.NoSlidingExpiration);
			}
			ActionResult result;
			if (slug_s == null)
			{
				Seccion defaultS = Secciones.ListByTemplate(1)[0];
				defaultS.LoadDestacados();
				base.ViewData["seccion"] = defaultS;
				result = base.View(this.GetTemplateName(1));
			}
			else
			{
				Resource resource_seccion = ResourceManager.GetBySlugType(slug_s, ResourceType.SECCION);
				if (resource_seccion == null)
				{
					result = base.View("404");
				}
				else
				{
					Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
					if (slug_ss == null && slug_r == null)
					{
						seccion.LoadDestacados();
						base.ViewData["seccion"] = seccion;
						result = base.View(this.GetTemplateName(seccion.Template));
					}
					else
					{
						Resource resource_subseccion = ResourceManager.GetBySlugType(slug_ss, ResourceType.SECCION);
						string selectedView = "";
						if (resource_subseccion == null)
						{
							base.ViewData["seccion"] = seccion;
							Resource resource_resource = ResourceManager.GetBySlug(slug_ss);
							if (resource_resource == null)
							{
								result = base.View("404");
							}
							else
							{
								switch (resource_resource.Type)
								{
								case ResourceType.ARTICULO:
								{
									Articulo a = ArticuloManager.GetByResource(resource_resource.ResourceID);
									a.Resource.SetAccessed();
									base.ViewData["resource"] = a;
									selectedView = "Articulo";
									break;
								}
								}
								if (selectedView.Length == 0)
								{
									selectedView = "404";
								}
								result = base.View(selectedView);
							}
						}
						else
						{
							seccion = Secciones.GetByResource(resource_subseccion.ResourceID);
							base.ViewData["seccion"] = seccion;
							if (slug_r == null)
							{
								seccion.LoadDestacados();
								result = base.View(this.GetTemplateName(seccion.Template));
							}
							else
							{
								Resource resource_resource = ResourceManager.GetBySlug(slug_r);
								if (resource_resource == null)
								{
									result = base.View("404");
								}
								else
								{
									switch (resource_resource.Type)
									{
									case ResourceType.ARTICULO:
										base.ViewData["resource"] = ArticuloManager.GetByResource(resource_resource.ResourceID);
										selectedView = "Articulo";
										break;
									case ResourceType.CURSO:
										base.ViewData.Model = Camarco.Model.Cursos.GetByResource(resource_resource.ResourceID);
										selectedView = "Curso";
										break;
									}
									result = base.View(selectedView);
								}
							}
						}
					}
				}
			}
			return result;
		}

		private string GetTemplateName(int TemplateID)
		{
			string result;
			switch (TemplateID)
			{
			case 1:
				result = "Home";
				break;
			case 2:
				result = "AgendaArticulos";
				break;
			case 3:
				result = "Biblioteca";
				break;
			case 4:
				result = "Capacitacion";
				break;
			case 5:
				result = "Pagina";
				break;
			case 6:
				result = "GuiasPracticas";
				break;
			case 7:
				result = "Delegaciones";
				break;
			default:
				result = "Home";
				break;
			}
			return result;
		}

		public ActionResult pruebaAjax()
		{
			return base.View();
		}

		public ActionResult inscripcionExitosa()
		{
			return base.View();
		}

		public string comprobar()
		{
			string cuit = base.Request.Form["cuit"].ToString();
			DynamicEntity empresa = CRMHelper.EmpresaByCuit(cuit);
			return JsonConvert.SerializeObject(new
			{
				nombre = empresa["name"].ToString(),
				mail = empresa["emailaddress1"].ToString()
			});
		}

		public ActionResult pruebaPay()
		{
			return base.View();
		}
	}
}
