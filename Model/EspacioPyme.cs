using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Camarco.Model
{
	public static class EspacioPyme
	{
		public static List<EspacioPymeResult> GetMasLeidos(int[] secciones)
		{
			List<EspacioPymeResult> retval = new List<EspacioPymeResult>();
			using (DBHelper dbHelper = new DBHelper())
			{
				foreach (Seccion s in Secciones.GetEspacioPyme())
				{
					if (secciones.Length <= 0 || secciones.Contains(s.SeccionID))
					{
						EspacioPymeResult item = new EspacioPymeResult(s.SeccionID, s.Color);
						using (DataSet ds = dbHelper.RunSPReturnDataSet("EspacioPyme_GetMasLeidos", false, new customParameter[]
						{
							dbHelper.MP("@SeccionID", SqlDbType.Int, s.SeccionID)
						}))
						{
							foreach (DataRow dR in ds.Tables[0].Rows)
							{
								item.Items.Add(new Resource((int)dR["ResourceID"]));
							}
							ds.Clear();
						}
						retval.Add(item);
					}
				}
			}
			return retval;
		}

		public static List<EspacioPymeResult> GetMasDescargados(int[] secciones)
		{
			List<EspacioPymeResult> retval = new List<EspacioPymeResult>();
			using (DBHelper dbHelper = new DBHelper())
			{
				foreach (Seccion s in Secciones.GetEspacioPyme())
				{
					if (secciones.Length <= 0 || secciones.Contains(s.SeccionID))
					{
						EspacioPymeResult item = new EspacioPymeResult(s.SeccionID, s.Color);
						using (DataSet ds = dbHelper.RunSPReturnDataSet("EspacioPyme_GetMasDescargados", false, new customParameter[]
						{
							dbHelper.MP("@SeccionID", SqlDbType.Int, s.SeccionID)
						}))
						{
							foreach (DataRow dR in ds.Tables[0].Rows)
							{
								item.Items.Add(new Resource((int)dR["ResourceID"]));
							}
							ds.Clear();
						}
						retval.Add(item);
					}
				}
			}
			return retval;
		}

		public static List<EspacioPymeResult> GetCursos()
		{
			List<EspacioPymeResult> retval = new List<EspacioPymeResult>();
			using (DBHelper dbHelper = new DBHelper())
			{
				Seccion s = Secciones.ListByTemplate(4)[0];
				if (s != null)
				{
					EspacioPymeResult item = new EspacioPymeResult(s.SeccionID, s.Color);
					using (DataSet ds = dbHelper.RunSPReturnDataSet("EspacioPyme_GetCursos", false, new customParameter[0]))
					{
						foreach (DataRow dR in ds.Tables[0].Rows)
						{
							item.Items.Add(new Resource((int)dR["ResourceID"]));
						}
						ds.Clear();
					}
					retval.Add(item);
				}
			}
			return retval;
		}

		public static string SerializeResult(List<EspacioPymeResult> results)
		{
			StringBuilder retval = new StringBuilder("{\"data\": {}, \"id\": \"root\", \"name\": \"\",\"children\":[");
			List<string> resultsArray = new List<string>();
			foreach (EspacioPymeResult r in results)
			{
				int countItem = r.Items.Count - 1;
				bool AddedPrevious = false;
				string aResult = "";
				if (r.Items.Count > 0)
				{
					object obj = aResult;
					aResult = string.Concat(new object[]
					{
						obj,
						AddedPrevious ? "," : "",
						"{ \"id\": \"",
						r.SeccionID,
						"\", \"name\": \"",
						r.SeccionID,
						"\",  \"children\": ["
					});
					int area = 15;
					if (countItem > 5)
					{
                        area = (int)Math.Round((decimal)(80 / countItem), 0);
					}
					int index = 1;
					List<string> children = new List<string>();
					foreach (Resource rr in r.Items)
					{
						string image = "";
						string extra = "";
						if (rr.Type == ResourceType.CURSO)
						{
							Curso c = Cursos.GetByResource(rr.ResourceID);
							if (c.ImagenID > 0)
							{
								image = "\"image\": \"/File/GetFile?id=" + c.ImagenID + "\",";
							}
							extra = "\"extra\":\"Inicio " + c.CronogramaInicio.ToString("MMMM yyyy") + "\",";
						}
						if (rr.Type == ResourceType.ARTICULO)
						{
							Articulo a = ArticuloManager.GetByResource(rr.ResourceID);
							a.LoadImagenes();
							if (a.Imagenes.Count > 0 && a.Imagenes[0].FileID > 0)
							{
								image = "\"image\": \"/File/GetFile?id=" + a.Imagenes[0].FileID + "\",";
							}
						}
						string url = rr.GetPublicUrl(0);
						if (rr.Type == ResourceType.CURSO)
						{
							url = "Cursos/" + rr.Slug;
						}
						children.Add(string.Concat(new object[]
						{
							"{ \"id\": \"",
							r.SeccionID,
							index,
							"\", \"name\": \"",
							rr.Nombre.Replace("\"", ""),
							"\",  \"children\": [], \"data\": {\"theme\": \"",
							r.Color,
							"\", \"playcount\": \"1\",  \"url\": \"/",
							url,
							"\", ",
							extra,
							" ",
							image,
							" \"$area\": \"",
							(index == 1) ? "20" : area.ToString(),
							"\"}}"
						}));
						index++;
					}
					aResult += string.Join(",", children.ToArray());
					aResult += "],\"data\": { \"playcount\": \"1\", \"$area\": \"100\" }}";
				}
				if (aResult.Length > 0)
				{
					resultsArray.Add(aResult);
				}
			}
			retval.Append(string.Join(",", resultsArray.ToArray()) + "]}");
			return retval.ToString();
		}
	}
}
