using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Provincias
	{
		public static List<Provincia> ListAll()
		{
			List<Provincia> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Provincia> retval = new List<Provincia>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Provincias_ListAll", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Provincia((int)((short)dR["ProvinciaID"]), (string)dR["Nombre"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}
	}
}
