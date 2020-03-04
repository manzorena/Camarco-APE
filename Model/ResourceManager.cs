using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
    public static class ResourceManager
	{
		public static void Remove(int ResourceID)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Resource_Remove", true, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, ResourceID.ToString())
				});
			}
		}

		public static List<Resource> SimpleFilter(int seccionid, int tipo, string nombre)
		{
			nombre = Text.SQLQueryAcentos(nombre);
			List<Resource> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Resource> retval = new List<Resource>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_SimpleFilter", false, new customParameter[]
				{
					dbHelper.MP("@Tipo", SqlDbType.TinyInt, tipo.ToString()),
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Resource((int)dR["ResourceID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Resource> GlobalSearch(string nombre, int page)
		{
			nombre = Text.SQLQueryAcentos(nombre);
			List<Resource> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Resource> retval = new List<Resource>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_GlobalSearch", false, new customParameter[]
				{
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre),
					dbHelper.MP("@Page", SqlDbType.Int, page)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						Resource rr = new Resource((int)dR["ResourceID"]);
						rr.LoadSecciones();
						retval.Add(rr);
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static int GlobalSearchCount(string nombre)
		{
			nombre = Text.SQLQueryAcentos(nombre);
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Resources_GlobalSearchCount", false, new customParameter[]
				{
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre)
				});
			}
			return result;
		}

		public static List<Resource> ListBySeccionType(int seccionid, int tipo, int max)
		{
			List<Resource> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Resource> retval = new List<Resource>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_ListBySeccionType", false, new customParameter[]
				{
					dbHelper.MP("@Tipo", SqlDbType.TinyInt, tipo.ToString()),
					dbHelper.MP("@Max", SqlDbType.Int, max),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Resource((int)dR["ResourceID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Resource> ListBySeccionType3(int seccionid, int tipo, int max)
		{
			List<Resource> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Resource> retval = new List<Resource>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_ListBySeccionType3", false, new customParameter[]
				{
					dbHelper.MP("@Tipo", SqlDbType.TinyInt, tipo.ToString()),
					dbHelper.MP("@Max", SqlDbType.Int, max),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Resource((int)dR["ResourceID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static Resource GetBySlugType(string slug, ResourceType rtype)
		{
			Resource result;
			using (DBHelper dbHelper = new DBHelper())
			{
				DBHelper arg_59_0 = dbHelper;
				string arg_59_1 = "Resources_GetBySlugType";
				bool arg_59_2 = false;
				customParameter[] array = new customParameter[2];
				array[0] = dbHelper.MP("@Slug", SqlDbType.VarChar, slug.ToLower());
				customParameter[] arg_53_0_cp_0 = array;
				int arg_53_0_cp_1 = 1;
				DBHelper arg_4E_0 = dbHelper;
				string arg_4E_1 = "@Type";
				SqlDbType arg_4E_2 = SqlDbType.TinyInt;
				int num = (int)rtype;
				arg_53_0_cp_0[arg_53_0_cp_1] = arg_4E_0.MP(arg_4E_1, arg_4E_2, num.ToString());
				int ResourceID = arg_59_0.RunSPReturnInteger(arg_59_1, arg_59_2, array);
				if (ResourceID == -1)
				{
					result = null;
				}
				else
				{
					result = new Resource(ResourceID);
				}
			}
			return result;
		}

		public static Resource GetBySlug(string slug)
		{
			Resource result;
			using (DBHelper dbHelper = new DBHelper())
			{
				int ResourceID = dbHelper.RunSPReturnInteger("Resources_GetBySlug", false, new customParameter[]
				{
					dbHelper.MP("@Slug", SqlDbType.VarChar, slug.ToLower())
				});
				if (ResourceID == -1)
				{
					result = null;
				}
				else
				{
					result = new Resource(ResourceID);
				}
			}
			return result;
		}

		public static List<Resource> Capacitacion_List(int seccionid, int page)
		{
			List<Resource> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Resource> retval = new List<Resource>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_Capacitacion_List", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid),
					dbHelper.MP("@Page", SqlDbType.Int, page)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Resource((int)dR["ResourceID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}
	}
}
