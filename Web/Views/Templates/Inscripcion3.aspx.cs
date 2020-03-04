using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Crm.Sdk;
using Microsoft.Crm.SdkTypeProxy;
using Microsoft.Crm.Sdk.Query;
using Microsoft.Crm.Sdk.Utility; 


namespace Camarco.Web.Views.Templates
{
    public partial class Inscripcion3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_cmprbr_Click(object sender, EventArgs e)
        {
            
            string mail = this.txt_mail_comprobar.ToString();
            if (mail == "")
                mail="";//MENSAJE DE ERROR,EL E-MAIL NO PUEDE ESTAR VACIO
            else
            {
                DynamicEntity contacto = Camarco.Tools.CRM.CRMHelper.ContactoByEmail(mail);
                if (contacto == null)
                    contacto = null; //MENSAJE DE ERROR, EL E-MAIL NO PERTENECE A NINGUN CONTACTO EXISTENTE
                else
                {
                    txt_nombre.Value = TryCompletarString(contacto, "firstname");
                    txt_apellido.Value = TryCompletarString(contacto, "lastname");
                    txt_dni.Value = TryCompletarString(contacto, "huddle_documento");
                }

            }
        }

        protected void btn_inscribir_Click(object sender, EventArgs e)
        {

            if (txt_apellido.Value == "" || txt_dni.Value =="" || txt_nombre.Value =="")
                txt_apellido.Value = ""; //MENSAJE DE ERROR, EL APELLIDO DEBE ESTAR CARGADO
            else
                {
                    string contactoNombre = txt_nombre.Value.ToString();
                    string contactoApellido = txt_apellido.Value.ToString();
                    string contactoDNI = txt_dni.Value.ToString();
                    string idContacto=""; 
                    DynamicEntity contacto = Camarco.Tools.CRM.CRMHelper.ContactoByDNI(txt_dni.Value);//intenta recuperar el contacto
                    
                    if (contacto == null)
                    {
                        //crear
                        
                        //idContacto = Camarco.Tools.CRM.CRMHelper.CreateContacto(contactoNombre,contactoApellido,contactoDNI);      
                    }
                    else
                    {
                     //actualizar
                        idContacto = ((Key)contacto["contactid"]).Value.ToString();
                        //Camarco.Tools.CRM.CRMHelper.UpdateContacto(idContacto, contactoNombre, contactoApellido, contactoDNI);

                    }

                    //inscripcion al curso
                    string campaignid = "ABE1222D-7314-E111-8639-001E908E9D61";
                    //Camarco.Tools.CRM.CRMHelper.AgregarRespuestaCampaña(campaignid, idContacto);



                }


        }

        private static string TryCompletarString(DynamicEntity contacto, string columna)
        {
            try
            {
                return (contacto[columna] != null ? contacto[columna].ToString() : "");
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
}