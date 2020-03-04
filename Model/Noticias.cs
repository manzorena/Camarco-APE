using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Noticias
	{
		public static List<Articulo> GetDestacados(int SeccionID)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetDestacados", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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

		public static List<Articulo> GetRecientes(int SeccionID)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetRecientes", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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

        public static List<Articulo> GetProximos5(int SeccionID)
        {
            List<Articulo> result;
            using (DBHelper dbHelper = new DBHelper())
            {
                List<Articulo> retval = new List<Articulo>();
                using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetProximos5", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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

        public static List<Articulo> GetUltimos5Eventos(int SeccionID)
        {
            List<Articulo> result;
            using (DBHelper dbHelper = new DBHelper())
            {
                List<Articulo> retval = new List<Articulo>();
                using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetUltimos5Eventos", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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

		public static List<Articulo> GetMasLeidas(int SeccionID)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetMasLeidas", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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

        public static List<Articulo> GetMasLeidasSinEventos(int SeccionID)
		{
			List<Articulo> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Articulo> retval = new List<Articulo>();
                using (DataSet ds = dbHelper.RunSPReturnDataSet("Noticias_GetMasLeidasSinEventos", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
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
	}
}
