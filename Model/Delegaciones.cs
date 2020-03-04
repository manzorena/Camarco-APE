using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Delegaciones
	{
		public static List<Delegacion> ListAll()
		{
			List<Delegacion> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Delegacion> retval = new List<Delegacion>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Delegaciones_ListAll", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Delegacion((int)dR["DelegacionID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}
	}
}
