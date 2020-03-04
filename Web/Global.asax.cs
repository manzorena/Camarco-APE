using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web
{
	// Note: For instructions on enabling IIS6 or IIS7 classic mode, 
	// visit http://go.microsoft.com/?LinkId=9394801

	public class MvcApplication : System.Web.HttpApplication
	{
		public static void RegisterRoutes(RouteCollection routes)
		{
            //routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            //routes.IgnoreRoute("Content/{*pathInfo}");
            //routes.IgnoreRoute("Scripts/{*pathInfo}");
            routes.MapRoute(
            "espacio-pyme", // Route name
            "espacio-pyme", // URL with parameters
            new { controller = "EspacioPymeActual", action = "index" } // Parameter defaults
            );

            routes.MapRoute(
            "transparencia", // Route name
            "transparencia", // URL with parameters
            new { controller = "Transparencia", action = "index" } // Parameter defaults
            );

            routes.MapRoute(
            "APE", // Route name
            "APE", // URL with parameters
            new { controller = "APE", action = "index" } // Parameter defaults
            );

            routes.MapRoute(
            "programa de integridad", // Route name
            "transparencia/programa-de-integridad", // URL with parameters
            new { controller = "Transparencia", action = "integridad" } // Parameter defaults
            );

            routes.MapRoute(
            "consultas y denuncias", // Route name
            "transparencia/consultas", // URL with parameters
            new { controller = "Transparencia", action = "consultas" } // Parameter defaults
            );

            routes.MapRoute(
            "adhesion al programa", // Route name
            "transparencia/adhesion-al-programa", // URL with parameters
            new { controller = "Transparencia", action = "adhesion" } // Parameter defaults
            );

            routes.MapRoute(
            "escuela-de-gestion", // Route name
            "escuela-de-gestion", // URL with parameters
            new { controller = "Capacitacion", action = "index" } // Parameter defaults
            );

            //routes.MapRoute(
            //name: "espacio-pyme", // Route name
            //url: "{name}", // URL with parameters
            //defaults: new { controller = "EspacioPymeActual", action = "index" } // Parameter defaults
            //);

            routes.MapRoute(
            "pruebaPay", // Route name
            "pruebaPay", // URL with parameters
            new { controller = "Templates", action = "pruebaPay" } // Parameter defaults
            );
            routes.MapRoute(
            "pruebaAjax", // Route name
            "pruebaAjax", // URL with parameters
            new { controller = "Templates", action = "pruebaAjax" } // Parameter defaults
            );
            
            routes.MapRoute(
            "inscripcionExitosa", // Route name
            "inscripcionExitosa", // URL with parameters
            new { controller = "Templates", action = "inscripcionExitosa" } // Parameter defaults
            );
            
            routes.MapRoute(
            "comprobar", // Route name
            "comprobar", // URL with parameters
            new { controller = "Templates", action = "comprobar" } // Parameter defaults
            );

            

            routes.MapRoute(
             "Aver", // Route name
             "Aver", // URL with parameters
             new { controller = "Templates", action = "Aver" } // Parameter defaults
             );

            routes.MapRoute(
             "Home", // Route name
             "Home", // URL with parameters
             new { controller = "Templates", action = "Home" } // Parameter defaults
             );

            routes.MapRoute(
             "VerMas", // Route name
             "VerMas", // URL with parameters
             new { controller = "Templates", action = "VerMas" } // Parameter defaults
             );

            routes.MapRoute(
             "Inscripcion", // Route name
             "Inscripcion", // URL with parameters
             new { controller = "Templates", action = "Inscripcion" } // Parameter defaults
             );

            routes.MapRoute(
             "Facturacion", // Route name
             "Facturacion", // URL with parameters
             new { controller = "Templates", action = "Facturacion" } // Parameter defaults
             );

            routes.MapRoute(
             "Respuesta", // Route name
             "Respuesta", // URL with parameters
             new { controller = "Templates", action = "Respuesta" } // Parameter defaults
             );

            routes.MapRoute(
             "Confirmacion", // Route name
             "Confirmacion", // URL with parameters
             new { controller = "Templates", action = "Confirmacion" } // Parameter defaults
             );

            routes.MapRoute(
             "RespuestaPayU", // Route name
             "RespuestaPayU", // URL with parameters
             new { controller = "Templates", action = "RespuestaPayU" } // Parameter defaults
             );

            routes.MapRoute(
                "Contacto", // Route name
                "Contacto/{delegacion}", // URL with parameters
                new { controller = "Templates", action = "Contacto", delegacion =-1} // Parameter defaults
            );

			routes.MapRoute(
				"Newsletter", // Route name
				"Newsletter", // URL with parameters
				new { controller = "Templates", action = "Newsletter" } // Parameter defaults
			);

			routes.MapRoute(
				"EspacioPyme", // Route name
				"EspacioPyme", // URL with parameters
				new { controller = "Templates", action = "EspacioPyme" } // Parameter defaults
			);


            routes.MapRoute(
                "Cursos", // Route name
                "Cursos/{slug}", // URL with parameters
                new { controller = "Templates", action = "Cursos" } // Parameter defaults
            );
			routes.MapRoute(
				"CursosMail", // Route name
				"CursosMail", // URL with parameters
				new { controller = "Templates", action = "CursosMail" } // Parameter defaults
			);
			routes.MapRoute(
				"File", // Route name
				"File/{action}/{id}", // URL with parameters
				new { controller = "File", action = "GetFile", id=UrlParameter.Optional } // Parameter defaults
			);

			routes.MapRoute(
				"Session", // Route name
				"Session/{action}", // URL with parameters
				new { controller = "Session", action = "Validate", id = UrlParameter.Optional } // Parameter defaults
			);

			routes.MapRoute(
				"Buscar", // Route name
				"Buscar/{query}/{page}", // URL with parameters
				new { controller = "Search", action="GlobalSearch",page=1 } // Parameter defaults
			);

            routes.MapRoute(
                "BuscarCapacitacion", // Route name
                "Buscar-capacitacion/{query}/{noticias}/{cursos}", // URL with parameters
                new { controller = "Search", action = "CapacitacionSearch", noticias = 1, cursos = 1 } // Parameter defaults
            );

			routes.MapRoute(
				"SearchAsync", // Route name
				"Search/{action}", // URL with parameters
				new { controller = "Search"} // Parameter defaults
			);

			routes.MapRoute(
				"Secciones", // Route name
				"{slug_s}/{slug_ss}/{slug_r}", // URL with parameters
				new { controller = "Templates", action = "Dispatch", slug_s = UrlParameter.Optional, slug_ss = UrlParameter.Optional, slug_r = UrlParameter.Optional } // Parameter defaults
			);
			

		}

		protected void Application_Start()
		{
			AreaRegistration.RegisterAllAreas();

			RegisterRoutes(RouteTable.Routes);
		}
	}
}