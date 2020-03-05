using Camarco.Integration;
using Camarco.Model;
using Camarco.Tools;
using NLog;
using System;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Web;
using System.Web.Caching;
using System.Web.Mvc;

namespace Camarco.Web.Controllers
{
	public class FileController : BaseFrontController
	{
		[HttpPost]
		public ActionResult Upload(string token)
		{
			ActionResult result;
			try
			{
				Directory.CreateDirectory(base.Server.MapPath("~/Uploads/" + token));
				foreach (string tagname in base.Request.Files)
				{
					HttpPostedFileBase file = base.Request.Files[tagname];
					if (file.FileName.Length != 0)
					{
						file.SaveAs(base.Server.MapPath("~/Uploads/" + token + "/" + Path.GetFileName(file.FileName)));
					}
				}
				result = base.Content("{\"success\":\"true\"}", "text/plain");
			}
			catch (Exception ex)
			{
				Logger logger = LogManager.GetLogger("CamarcoLogger");
				logger.Error("Upload failed! > " + ex.Message);
				result = base.Content("{\"success\":\"false\"}", "text/plain");
			}
			return result;
		}

		public ActionResult UploadImage(string width, string height, string token)
		{
			ActionResult result;
			try
			{
				Directory.CreateDirectory(base.Server.MapPath("~/Uploads/" + token));
				foreach (string tagname in base.Request.Files)
				{
					HttpPostedFileBase file = base.Request.Files[tagname];
					if (file.FileName.Length != 0)
					{
						if (width.Length > 0)
						{
							string fileName = Path.GetFileName(file.FileName);
							string ext = Path.GetExtension(file.FileName);
							file.SaveAs(base.Server.MapPath(string.Concat(new string[]
							{
								"~/Uploads/",
								token,
								"/",
								fileName.Replace(ext, ""),
								"b",
								ext
							})));
							FileManager.CropImageMantain(int.Parse(width), int.Parse(height), string.Concat(new string[]
							{
								base.Server.MapPath("~/Uploads/" + token),
								"\\",
								fileName.Replace(ext, ""),
								"b",
								ext
							}), base.Server.MapPath("~/Uploads/" + token) + "\\" + fileName);
						}
						else
						{
							file.SaveAs(base.Server.MapPath("~/Uploads/" + token + "/" + Path.GetFileName(file.FileName)));
						}
					}
				}
				result = base.Content("{\"success\":\"true\"}", "text/plain");
			}
			catch (Exception ex)
			{
				Logger logger = LogManager.GetLogger("CamarcoLogger");
				logger.Error("Upload failed! > " + ex.Message);
				result = base.Content("{\"success\":\"false\"}", "text/plain");
			}
			return result;
		}

		private byte[] GetBytesFromCache(string path)
		{
			object fromCache = HttpRuntime.Cache.Get(path);
			byte[] result;
			if (fromCache == null)
			{
				result = null;
			}
			else
			{
				try
				{
					result = (fromCache as byte[]);
				}
				catch
				{
					result = null;
				}
			}
			return result;
		}

		public ActionResult GetFile(int id)
		{
			Camarco.Model.File a = new Camarco.Model.File(id);
			byte[] imageBytes;
			if (a.IsImage())
			{
				imageBytes = this.GetBytesFromCache("file" + id);
				if (imageBytes == null)
				{
					imageBytes = a.GetFile();
					HttpRuntime.Cache.Insert("file" + id, imageBytes, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes((double)int.Parse(ConfigurationManager.AppSettings["fileCacheMinutes"])));
				}
			}
			else
			{
				imageBytes = a.GetFile();
			}
			FileContentResult f = new FileContentResult(imageBytes, a.GetHTTPContentType());
			f.FileDownloadName = a.Filename;
			base.Response.Cache.SetExpires(DateTime.Now.AddYears(1));
			base.Response.Cache.SetLastModified(DateTime.Now.AddYears(-1));
			return f;
		}

		public ActionResult GetPublicFile(int id)
		{
			Camarco.Model.File a = new Camarco.Model.File(id);
			byte[] imageBytes = a.GetFile();
			a.SetDownloaded();
			return new FileContentResult(imageBytes, a.GetHTTPContentType())
			{
				FileDownloadName = a.Filename
			};
		}

		public ActionResult GetPrivateFile(int id)
		{
			if (base.Session["UserID"] == null)
			{
				throw new UnauthorizedAccessException();
			}
			Camarco.Model.File a = new Camarco.Model.File(id);
			byte[] imageBytes = a.GetFile();
			a.SetDownloaded();
			return new FileContentResult(imageBytes, a.GetHTTPContentType())
			{
				FileDownloadName = a.Filename
			};
		}

		public ActionResult Cleanup(string token)
		{
			if (Directory.Exists(base.Server.MapPath("~/Uploads/" + token)))
			{
				try
				{
					Directory.Delete(base.Server.MapPath("~/Uploads/" + token), true);
				}
				catch
				{
					Thread updateThread = new Thread(new ParameterizedThreadStart(Sync.DelayedCleanup));
					updateThread.Start(base.Server.MapPath("~/Uploads/" + token));
				}
			}
			return base.Content("{\"status\":\"ok\"}", "application/json");
		}

		public ActionResult ImageCrop(string token, string image, int width, int height, int hudheight, int hudwidth)
		{
			base.ViewData["image"] = image;
			base.ViewData["token"] = token;
			base.ViewData["width"] = width;
			base.ViewData["height"] = height;
			Bitmap curImage = new Bitmap(base.Server.MapPath("~/Uploads/" + token + "/" + image));
			base.ViewData["imageWidth"] = curImage.Width;
			base.ViewData["imageHeight"] = curImage.Height;
			if (curImage.Width > hudwidth || curImage.Height > hudheight)
			{
				if (curImage.Height > hudheight && curImage.Height - hudheight > curImage.Width - hudwidth)
				{
					base.ViewData["scaleFactor"] = (double)hudheight / (double)curImage.Height;
				}
				else
				{
					base.ViewData["scaleFactor"] = (double)hudwidth / (double)curImage.Width;
				}
			}
			else
			{
				base.ViewData["scaleFactor"] = 1.0;
			}
			return base.View();
		}

		[HttpPost]
		public ActionResult ImageCrop(string token, string image, int x, int y, int w, int h, int sw, int sh)
		{
			ActionResult result;
			try
			{
				string ext = Path.GetExtension(image);
				FileManager.ResizeImage(x, y, w, h, sw, sh, base.Server.MapPath("~/Uploads/" + token) + "\\" + image, string.Concat(new string[]
				{
					base.Server.MapPath("~/Uploads/" + token),
					"\\",
					image.Replace(ext, ""),
					"b",
					ext
				}));
				result = base.Content(string.Concat(new string[]
				{
					"{\"success\":\"true\", \"img\":\"",
					image.Replace(ext, ""),
					"b",
					ext,
					"\"}"
				}), "application/json");
			}
			catch
			{
				result = base.Content("{\"success\":\"false\"}", "application/json");
			}
			return result;
		}
	}
}
