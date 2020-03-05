using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class ArticuloManager
	{
		public static int CountAll()
		{
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Articulos_CountAll", false, new customParameter[0]);
			}
			return result;
		}

		public static List<Articulo> List(int page, int perpage)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Articulos_List", false, new customParameter[]
				{
					dbHelper.MP("@Page", SqlDbType.Int, page.ToString()),
					dbHelper.MP("@PerPage", SqlDbType.TinyInt, perpage.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Articulo((int)dR["ArticuloID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static int CountFiltered(string nombre, int seccion)
		{
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Articulos_CountFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Titulo", SqlDbType.VarChar, nombre),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccion.ToString())
				});
			}
			return result;
		}

		public static List<Articulo> ListFiltered(int page, int perpage, string nombre, int seccion)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Articulos_ListFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Page", SqlDbType.Int, page.ToString()),
					dbHelper.MP("@PerPage", SqlDbType.TinyInt, perpage.ToString()),
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccion.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Articulo((int)dR["ArticuloID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static Articulo GetByResource(int ResourceID)
		{
			Articulo result;
			using (DBHelper dbHelper = new DBHelper())
			{
				int DocumentoID = dbHelper.RunSPReturnInteger("Articulos_GetByResource", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, ResourceID.ToString())
				});
				if (DocumentoID == -1)
				{
					result = null;
				}
				else
				{
					Articulo d = new Articulo(DocumentoID);
					d.LoadArchivos();
					d.LoadImagenes();
					result = d;
				}
			}
			return result;
		}

		public static List<Articulo> ListFilteredByUser(int seccionid, string tag)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_TagFilter", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid),
					dbHelper.MP("@Type", SqlDbType.Int, 2),
					dbHelper.MP("@Tag", SqlDbType.VarChar, tag.ToLower())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(ArticuloManager.GetByResource((int)dR["ResourceID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}
	}
}
