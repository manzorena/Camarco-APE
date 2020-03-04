using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Camarco.Model;

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
                base.ViewData["seccion"] = seccion;
            }
            
            return View("adhesion-al-programa");

        }


    }

}
