using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Camarco.Model;
using System.IO;
using System.Net;
using System.Net.Mail;

namespace Camarco.Web.Controllers
{

    public class TransparenciaController : Controller
    {
        //
        // GET: /Transparencia/

        public ActionResult Index()
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("transparencia", ResourceType.SECCION);
            if (resource_seccion == null)
            {
                return base.View("404");
            }
            else
            {
                Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
                seccion.LoadDestacados();
                base.ViewData["seccion"] = seccion;
            }

            return View("Transparencia");
        }

        public ActionResult integridad()
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("programa-de-integridad", ResourceType.SECCION);
            Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
            seccion.LoadDestacados();
            seccion.LoadSeccionDocumentos();
            base.ViewData["seccion"] = seccion;

            if (resource_seccion == null)
            {
                return base.View("404");
            }
            return View("integridad");
        }



        public ActionResult consultas()
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("consultas", ResourceType.SECCION);
            if (resource_seccion == null)
            {
                return base.View("404");
            }
            else
            {
                Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
                seccion.LoadDestacados();
                base.ViewData["seccion"] = seccion;
                base.ViewData["isInquietudSelected"] = true;
            }

            return View("consultas");
        }




        public ActionResult adhesion()
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("adhesion-al-programa", ResourceType.SECCION);
            if (resource_seccion == null)
            {
                return base.View("404");
            }
            else
            {
                Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
                seccion.LoadDestacados();
                seccion.LoadSeccionDocumentos();
                base.ViewData["seccion"] = seccion;
            }
            
            return View("adhesion-al-programa");


// --------------------------------------------- POST ACTIONS ---------------------------------------------------------

        }
        [HttpPost]
        public ActionResult Index(ConsultaForm consulta, DenunciaForm denuncia, 
        System.Web.HttpPostedFileWrapper file, string selected_form)
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("transparencia", ResourceType.SECCION);
            Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
            seccion.LoadDestacados();
            base.ViewData["seccion"] = seccion;

            var resumen = "";

            if (selected_form == "consulta") 
            {

                if (string.IsNullOrEmpty(consulta.consulta_mensaje))
                {
                    ModelState.AddModelError("consulta_mensaje", "El campo Mensaje NO puede estar vacío, intente nuevamente");
                }

                if (ModelState.IsValid)
                {
                    ViewData["cons_nombre"] = consulta.consulta_nombre;
                    ViewData["cons_mensaje"] = consulta.consulta_mensaje;
                    consulta.Save();
                    ViewData["send?"] = "true";
                }
                else
                {
                    var n = 0;
                    var errores = new System.Web.Mvc.ModelError[20];
                    foreach (ModelState modelState in ModelState.Values)
                    {
                        foreach (ModelError error in modelState.Errors)
                        {
                            errores[n] = error;
                            n++;
                        }
                    }
                    ViewData["Errors"] = errores;
                    return View("Transparencia");
                }
            }




            if (selected_form == "denuncia")
            {
                if (file != null)
                {
                    if (file.ContentLength >= 10250938)
                    {
                        ModelState.AddModelError("denuncia_archivo", "El archivo cargado NO debe superar los 10 MB, intente nuevamente");
                    }
                    else
                    {
                        BinaryReader b = new BinaryReader(file.InputStream);
                        byte[] binData = b.ReadBytes(file.ContentLength);

                        string result = Convert.ToBase64String(binData);
                        denuncia.denuncia_archivo = result;
                        denuncia.denuncia_tipo_de_archivo = file.ContentType;
                    }

                }

                if (string.IsNullOrEmpty(denuncia.denuncia_resumen))
                {
                    ModelState.AddModelError("denuncia_resumen", "Resumen is required");
                }
            }



            if (ModelState.IsValid)
            {

                if (selected_form == "consulta") { resumen = consulta.consulta_mensaje;} else { resumen = denuncia.denuncia_resumen;}

                // ------PROCEDIMIENTO DE ENVIO DE MAIL--------
                System.Net.Mail.MailMessage mmsg = new System.Net.Mail.MailMessage();

                var fromAddress = new MailAddress("denunciascamarco@gmail.com", "denunciascamarco");
                mmsg.To.Add("consultasydenuncias@camarco.org.ar");  //correo de a quien se envia el mail
                mmsg.Subject = "Se cargo una nueva " + selected_form; // asunto del mail
                mmsg.SubjectEncoding = System.Text.Encoding.UTF8;
                //mmsg.Bcc.Add("mbianchi@mstech.la"); // correo de a quien se envia una copia del mail
                
                mmsg.IsBodyHtml = true;
                var a = "<h3>se ha recibido la siguiente "+ selected_form +":</h3><div style='background-color: #F8F8FF'; padding: 5px;><p>" + resumen + "</p></div>";
                mmsg.Body = a; //contenido del mail
                mmsg.BodyEncoding = System.Text.Encoding.UTF8;




                mmsg.From = new System.Net.Mail.MailAddress("denunciascamarco@gmail.com"); //correo de quien envia el mail
                System.Net.Mail.SmtpClient cliente = new System.Net.Mail.SmtpClient();
                cliente.Port = 587;
                cliente.EnableSsl = true;
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
                cliente.UseDefaultCredentials = false;
                cliente.Credentials = new NetworkCredential(fromAddress.Address, "Camara$$2019");
                cliente.Host = "smtp.gmail.com";

                try
                {
                    cliente.Send(mmsg);

                    denuncia.save();
                    ViewData["send?"] = "true";
                }
                catch (Exception ex)
                {
                    ViewData["Errors"] = "ERROR EN ENVIO DE MAIL";
                    return View("Transparencia");
                }
            }

            else
            {
                var n = 0;
                var errores = new List<System.Web.Mvc.ModelError>();
                foreach (ModelState modelState in ModelState.Values)
                {
                    foreach (ModelError error in modelState.Errors)
                    {
                        if (error != null)
                        {
                            errores.Add(error);
                        }

                    }
                }
                ViewData["Errors"] = errores;
                return View("Transparencia");
            }


            return View("Transparencia");
        }


        [HttpPost]
        public ActionResult AdhesionForm(Adhesion_form form, System.Web.HttpPostedFileWrapper file)
        {
            Resource resource_seccion = ResourceManager.GetBySlugType("transparencia", ResourceType.SECCION);
            Seccion seccion = Secciones.GetByResource(resource_seccion.ResourceID);
            seccion.LoadDestacados();
            seccion.LoadSeccionDocumentos();
            base.ViewData["seccion"] = seccion;
            byte[] binData2 = null;


            if (file != null)
            {
                if (file.ContentLength >= 10250938)
                {
                    ModelState.AddModelError("adhesion_archivo", "El archivo cargado NO debe superar los 10 MB, intente nuevamente");
                }
                else
                {
                    BinaryReader b = new BinaryReader(file.InputStream);
                    byte[] binData = b.ReadBytes(file.ContentLength);
                    binData2 = binData;
                    string result = Convert.ToBase64String(binData);
                    form.adhesion_nota = result;
                    form.adhesion_tipo_de_archivo = file.ContentType;
                }
            }


            if (string.IsNullOrEmpty(form.adhesion_name))
            {
                ModelState.AddModelError("adhesion_name", "nombre y apellido is required");
            }

            if (string.IsNullOrEmpty(form.adhesion_name))
            {
                ModelState.AddModelError("adhesion_empresa", "empresa is required");
            }

            if (string.IsNullOrEmpty(form.adhesion_name))
            {
                ModelState.AddModelError("adhesion_cargo", "cargo is required");
            }

            if (string.IsNullOrEmpty(form.adhesion_name))
            {
                ModelState.AddModelError("adhesion_nota", " is required");
            }

            if (ModelState.IsValid)
            {


                // ------PROCEDIMIENTO DE ENVIO DE MAIL--------
                System.Net.Mail.MailMessage mmsg = new System.Net.Mail.MailMessage();

                BinaryReader b = new BinaryReader(file.InputStream);
                //byte[] binData = b.ReadBytes(file.ContentLength);
                var stream = new MemoryStream(binData2);

                var fromAddress = new MailAddress("denunciascamarco@gmail.com", "denunciascamarco");
                mmsg.To.Add("consultasydenuncias@camarco.org.ar");  //correo de a quien se envia el mail
                mmsg.Subject = "Se cargo un nuevo Formulario de adhesión" ;// asunto del mail
                mmsg.Attachments.Add(new Attachment( stream,  file.FileName, file.ContentType));
                mmsg.SubjectEncoding = System.Text.Encoding.UTF8;
                //mmsg.Bcc.Add("mbianchi@mstech.la"); // correo de a quien se envia una copia del mail

                mmsg.IsBodyHtml = true;
                var a = "<h3>Nombre y apellido: <p>"+ form.adhesion_name +"</p></h3><h3>Empresa: <p>"+ form.adhesion_empresa +"</p></h3><h3>Cargo: <p>"+form.adhesion_cargo+"</p></h3>";
                mmsg.Body = a; //contenido del mail
                mmsg.BodyEncoding = System.Text.Encoding.UTF8;




                mmsg.From = new System.Net.Mail.MailAddress("denunciascamarco@gmail.com"); //correo de quien envia el mail
                System.Net.Mail.SmtpClient cliente = new System.Net.Mail.SmtpClient();
                cliente.Port = 587;
                cliente.EnableSsl = true;
                cliente.DeliveryMethod = SmtpDeliveryMethod.Network;
                cliente.UseDefaultCredentials = false;
                cliente.Credentials = new NetworkCredential(fromAddress.Address, "Camara$$2019");
                cliente.Host = "smtp.gmail.com";

                try
                {
                    cliente.Send(mmsg);

                    form.Save();
                    ViewData["send?"] = "true";
                }
                catch (Exception ex)
                {
                    
                    ViewData["Errors"] = "ERROR EN ENVIO DE MAIL";
                    return View("Transparencia");
                }

        }
            else
            {
                var n = 0;
                var errores = new System.Web.Mvc.ModelError[20];
                foreach (ModelState modelState in ModelState.Values)
                {
                    foreach (ModelError error in modelState.Errors)
                    {
                        errores[n] = error;
                        n++;
                    }
                }
                ViewData["Errors"] = errores;
                return View("adhesion-al-programa");                
            }


            return View("Transparencia");
        }




    }
}
