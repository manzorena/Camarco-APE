using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Secciones
	{
		public static List<Seccion> ListAll()
		{
			List<Seccion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Seccion> retval = new List<Seccion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_ListAll", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Seccion> ListByTemplate(byte TemplateID)
		{
			List<Seccion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Seccion> retval = new List<Seccion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_ListByTemplate", false, new customParameter[]
				{
					dbHelper.MP("@TemplateID", SqlDbType.TinyInt, TemplateID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<AccesoDirecto> GetAccesosDirectos(int SeccionID)
		{
			List<AccesoDirecto> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<AccesoDirecto> retval = new List<AccesoDirecto>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetAccesosDirectos", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						AccesoDirecto ad = new AccesoDirecto((int)dR["SeccionMenuID"]);
						ad.LoadLinks();
						retval.Add(ad);
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static Seccion GetByResource(int ResourceID)
		{
			Seccion result;
			using (DBHelper dbHelper = new DBHelper())
			{
				int SeccionID = dbHelper.RunSPReturnInteger("Secciones_GetByResource", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, ResourceID.ToString())
				});
				if (SeccionID == -1)
				{
					result = null;
				}
				else
				{
					result = new Seccion(SeccionID);
				}
			}
			return result;
		}

		public static List<Seccion> GetMenu()
		{
			List<Seccion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Seccion> retval = new List<Seccion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetMenu", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Seccion> GetEspacioPyme()
		{
			List<Seccion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Seccion> retval = new List<Seccion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetEspacioPyme", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Seccion> GetSubsecciones(int SeccionID)
		{
			List<Seccion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Seccion> retval = new List<Seccion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetSubs", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}
	}
}
