using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Camarco.Model;
using Camarco.Tools;
using System.Data;
using System.Xml;
using System.IO;

namespace Camarco.Web.Controllers
{
    public class EspacioPymeActualController : Controller
    {
        Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper();


        //
        // GET: /EspacioPymeActual/

        public ActionResult Index()
        {
            
            Log("Inicia Index Espacio Pyme");
            int id = 0;
            Log("Antes del DS");
            DataSet ds = dbHelper.RunSQLReturnDataSet("SELECT SeccionID FROM Secciones where Nombre = 'Espacio Pyme'", false);
            Log("Cantidad de secciones: " + ds.Tables[0].Rows);
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                id = Convert.ToInt32(dr["SeccionID"]);
            }

            Log("IDentificador: " + id);

            ds.Clear();
            
            Log("Antes de la sección");
            Seccion espacioPymeModel = new Seccion(id);
            Log("Antes de todos los videos");
            List<VideoYoutubeModel> videosTodos = new List<VideoYoutubeModel>();
            Log("Antes de los videos");
            List<VideoYoutubeModel> videos = new List<VideoYoutubeModel>();

            Log("URL 1:");

            try
            {

            string URL1 = "https://www.youtube.com/feeds/videos.xml?playlist_id=PLgmTNEyoJV7xkRYjjLTUelDio2E1W4vWv"; //EmaNOB: Replciar para Capacitación
            XmlDocument feedXML1 = new XmlDocument();
            Log("Antes del load del feed.- Se viene el error??");
            feedXML1.Load(URL1);
            Log("Cantidad de nodos: " + feedXML1.DocumentElement.ChildNodes.Count);
            foreach (XmlNode nodo in feedXML1.DocumentElement.ChildNodes) {
                if (nodo.Name == "entry") {
                    foreach (XmlNode nodoBebe in nodo.ChildNodes) {
                        if (nodoBebe.Name == "media:group") {
                            VideoYoutubeModel video = new VideoYoutubeModel();
                            video.Titulo = nodoBebe["media:title"].InnerXml;
                            video.UrlVideo = nodo["link"].Attributes[1].Value;
                            video.UrlImagen = nodoBebe["media:thumbnail"].Attributes[0].Value;
                            video.Descripcion = nodoBebe["media:description"].InnerXml;
                            videosTodos.Add(video);
                        }
                    }
                }
            }

            Log("Feed 2");
            string URL2 = "https://www.youtube.com/feeds/videos.xml?playlist_id=PLgmTNEyoJV7y0x-cXskbL9NGEciUd5mFA";
            XmlDocument feedXML2 = new XmlDocument();
            Log("Antes del load de la URL2");
            feedXML2.Load(URL2);
            Log("Cantidad de no2: " + feedXML2.DocumentElement.ChildNodes.Count);
            foreach (XmlNode nodo in feedXML2.DocumentElement.ChildNodes)
            {
                if (nodo.Name == "entry")
                {
                    foreach (XmlNode nodoBebe in nodo.ChildNodes)
                    {
                        if (nodoBebe.Name == "media:group")
                        {
                            VideoYoutubeModel video = new VideoYoutubeModel();
                            video.Titulo = nodoBebe["media:title"].InnerXml;
                            video.UrlVideo = nodo["link"].Attributes[1].Value;
                            video.UrlImagen = nodoBebe["media:thumbnail"].Attributes[0].Value;
                            video.Descripcion = nodoBebe["media:description"].InnerXml;
                            videosTodos.Add(video);
                        }
                    }
                }
            }
            }
            catch (Exception ex)
            {
                Log("Error: " + ex.ToString());
            }
            //Eligo 2 videos al azar
            Random rnd = new Random();
            Log("Antes del random de " + videosTodos.Count);

            if (videosTodos.Count > 0)
            {
                int primero = rnd.Next(0, videosTodos.Count);
                int segundo = primero;
                while (segundo == primero)
                {
                    segundo = rnd.Next(0, videosTodos.Count);
                }
                videos.Add(videosTodos[primero]);
                videos.Add(videosTodos[segundo]);

                //Envío la información a la view
                ViewData["videos"] = videos;
            }
            else
            {
                Log("Por el else");
                ViewData["videos"] = new List<VideoYoutubeModel>();
            }
            Log("Antes del return");
            return View("EspacioPymeActual", espacioPymeModel);

            ////Ideal seria tener una clase en el proyecto de acceso a datos (Tools) y ahí hacer todas las consultas necesarias, 
            ////y que devuelva un model cargado --> espacioPymeModel = instanciaDatos.GetEspacioPymeModel();
            
            ////Instancio el modelo necesario para la view
            //EspacioPymeModel espacioPymeModel = new EspacioPymeModel();

            ////Cargo el modelo con los datos
            //DataSet ds = dbHelper.RunSQLReturnDataSet("SELECT top 5 Files.FileID, Files.Filename, Articulos.Titulo, Articulos.FechaPublicacion, Resources.Slug FROM Files INNER JOIN ArticulosImagenes ON Files.FileID=ArticulosImagenes.FileID INNER JOIN Articulos ON Articulos.ArticuloID=ArticulosImagenes.ArticuloID INNER JOIN Resources ON Resources.ResourceID=Articulos.ResourceID where Articulos.FechaPublicacion > GETDATE() order by 'FechaPublicacion'", false);
            //foreach (DataRow dr in ds.Tables[0].Rows)
            //{
            //    //Creo una nueva noticia
            //    ArticuloModel articuloAgenda = new ArticuloModel();

            //    //Le asigno la informacion de una fila de la DataTable
            //    articuloAgenda.Id = Convert.ToInt32(dr["FileID"]);
            //    articuloAgenda.Titulo = Convert.ToString(dr["Titulo"]);
            //    articuloAgenda.Mes = (Convert.ToDateTime(dr["FechaPublicacion"])).Month;
            //    articuloAgenda.Dia = (Convert.ToDateTime(dr["FechaPublicacion"])).Day;
            //    articuloAgenda.Ruta = Convert.ToString(dr["Slug"]);

            //    //Para evitar error "Object refence not set to an instance of an object"
            //    if (espacioPymeModel.ArticulosAgenda == null)
            //    {
            //        espacioPymeModel.ArticulosAgenda = new List<ArticuloModel>();
            //    }
                
            //    //Agrego esa noticia a la Lista de noticias de mi modelo
            //    espacioPymeModel.ArticulosAgenda.Add(articuloAgenda);
            //}
            //ds.Clear();


            //ds = dbHelper.RunSQLReturnDataSet("SELECT top 5 Files.FileID, Articulos.Titulo, Resources.Slug FROM Files INNER JOIN ArticulosImagenes ON Files.FileID=ArticulosImagenes.FileID INNER JOIN Articulos ON Articulos.ArticuloID=ArticulosImagenes.ArticuloID INNER JOIN Resources ON Resources.ResourceID=Articulos.ResourceID", false);
            //foreach (DataRow dr in ds.Tables[0].Rows)
            //{
            //    //Creo una nueva noticia
            //    ArticuloModel articuloSlider = new ArticuloModel();

            //    //Le asigno la informacion de una fila de la DataTable
            //    articuloSlider.Id = Convert.ToInt32(dr["FileID"]);
            //    articuloSlider.Titulo = Convert.ToString(dr["Titulo"]);
            //    articuloSlider.Ruta = Convert.ToString(dr["Slug"]);

            //    //Para evitar error "Object refence not set to an instance of an object"
            //    if (espacioPymeModel.ArticulosSlider == null)
            //    {
            //        espacioPymeModel.ArticulosSlider = new List<ArticuloModel>();
            //    }

            //    //Agrego esa noticia a la Lista de noticias de mi modelo
            //    espacioPymeModel.ArticulosSlider.Add(articuloSlider);
            //}
            //ds.Clear();



            ////Devuelvo la view con el model ya cargado
            //return View("EspacioPymeActual", espacioPymeModel);
        }

        public static void Log(string logMessage)
        {
            using (StreamWriter sw = new StreamWriter("F:\\LogsWeb\\LogEspacioPyme - " + DateTime.Now.ToString("dd-MM-yyyy") + ".txt", true))
            {
                sw.Write("\r\nLog Entry : ");
                sw.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString());
                sw.WriteLine("{0}", logMessage);
                sw.WriteLine("-------------------------------");
            }
        }
    }
}
