using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Tematicas
	{
		public static List<string> GetBySeccion(int SeccionID)
		{
			List<string> retval = new List<string>();
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_GetTags", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID),
					dbHelper.MP("@Type", SqlDbType.TinyInt, 1)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add((string)dR["Text"]);
					}
					ds.Clear();
				}
			}
			return retval;
		}

		public static int Save(string Text)
		{
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Tag_Save", true, new customParameter[]
				{
					dbHelper.MP("@Text", SqlDbType.VarChar, Text.ToLower())
				});
			}
			return result;
		}
	}
}
