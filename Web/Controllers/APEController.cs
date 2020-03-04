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
    public class APEController : Controller
    {
        Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper();

        public ActionResult Index()
        {
            DataSet ds = dbHelper.RunSQLReturnDataSet("SELECT TOP (3) Articulos.ArticuloID FROM ResourcesSecciones INNER JOIN  Articulos on ResourcesSecciones.ResourceID= Articulos.ResourceID WHERE SeccionID=86", false);
            Resource resource_seccion = ResourceManager.GetBySlugType("APE", ResourceType.SECCION);
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


            List<VideoYoutubeModel> videosTodos = new List<VideoYoutubeModel>();
            //Log("Antes de los videos");
            List<VideoYoutubeModel> videos = new List<VideoYoutubeModel>();

            //Log("URL 1:");

            try
            {

                string URL1 = "https://www.youtube.com/feeds/videos.xml?playlist_id=UUlsn_5Udmwo6AbXDM4Vt35g"; //EmaNOB: Replciar para Capacitación
                XmlDocument feedXML1 = new XmlDocument();
                Log("Antes del load del feed.- Se viene el error??");
                feedXML1.Load(URL1);
                Log("Cantidad de nodos: " + feedXML1.DocumentElement.ChildNodes.Count);
                foreach (XmlNode nodo in feedXML1.DocumentElement.ChildNodes)
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
                                if (video.Descripcion.Length > 40)
                                {
                                    video.Descripcion = video.Descripcion.Substring(0, 40);
                                }
                                videosTodos.Add(video);
                            }
                        }
                    }
                }

                //Log("Feed 2");
                //string URL2 = "https://www.youtube.com/feeds/videos.xml?playlist_id=UUlsn_5Udmwo6AbXDM4Vt35g";
                //XmlDocument feedXML2 = new XmlDocument();
                //Log("Antes del load de la URL2");
                //feedXML2.Load(URL2);
                //Log("Cantidad de no2: " + feedXML2.DocumentElement.ChildNodes.Count);
                //foreach (XmlNode nodo in feedXML2.DocumentElement.ChildNodes)
                //{
                //    if (nodo.Name == "entry")
                //    {
                //        foreach (XmlNode nodoBebe in nodo.ChildNodes)
                //        {
                //            if (nodoBebe.Name == "media:group")
                //            {
                //                VideoYoutubeModel video = new VideoYoutubeModel();
                //                video.Titulo = nodoBebe["media:title"].InnerXml;
                //                video.UrlVideo = nodo["link"].Attributes[1].Value;
                //                video.UrlImagen = nodoBebe["media:thumbnail"].Attributes[0].Value;
                //                video.Descripcion = nodoBebe["media:description"].InnerXml;

                //                if (video.Descripcion.Length > 40)
                //                {
                //                    video.Descripcion = video.Descripcion.Substring(0, 40);
                //                }

                //                videosTodos.Add(video);
                //            }
                //        }
                //    }
                //}
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
                //int primero = rnd.Next(0, videosTodos.Count);
                //int segundo = primero;
                //while (segundo == primero)
                //{
                //    segundo = rnd.Next(0, videosTodos.Count);
                //}
                videos.Add(videosTodos[0]);
                //videos.Add(videosTodos[segundo]);

                //Envío la información a la view
                ViewData["videos"] = videos;
            }
            else
            {
                Log("Por el else");
                ViewData["videos"] = new List<VideoYoutubeModel>();
            }
            Log("Antes del return");

            return View("Vista_APE");

        }

        public static void Log(string logMessage)
        {
            using (StreamWriter sw = new StreamWriter("C:\\LogsWeb\\LogEspacioPyme - " + DateTime.Now.ToString("dd-MM-yyyy") + ".txt", true))
            {
                sw.Write("\r\nLog Entry : ");
                sw.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString());
                sw.WriteLine("{0}", logMessage);
                sw.WriteLine("-------------------------------");
            }
        }

        public ActionResult ViewPDF()
        {
                string embed = "<object data=\"{0}\" type=\"image/tiff\" width =\"5000px\" height=\"3000px\">";
                embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
                embed += " or download <a target = \"_blank\" href= \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
                embed += "</object>";
                TempData["Embed"] = string.Format(embed, VirtualPathUtility.GetDirectory("/Content/CSS/Front/imagenes/App.png"));

                return RedirectToAction("Visor");
            }

    }

        
}
