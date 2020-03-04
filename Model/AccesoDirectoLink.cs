using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public class AccesoDirectoLink
	{
		public int Id
		{
			get;
			set;
		}

		public int SeccionMenuID
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public string Link
		{
			get;
			set;
		}

		public Resource Resource
		{
			get;
			set;
		}

		public int ResourceID
		{
			get;
			set;
		}

		public AccesoDirectoLink()
		{
			this.Link = "";
			this.Resource = null;
			this.ResourceID = 0;
			this.Titulo = "";
		}

		public AccesoDirectoLink(int id)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenuLink_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuLinkID", SqlDbType.Int, id.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("AccesoDirecto > Load : El ID de AccesoDirecto no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Link = (string)dR["Link"];
					this.Titulo = (string)dR["Titulo"];
					this.Resource = ((dR["ResourceID"] == DBNull.Value) ? null : new Resource((int)dR["ResourceID"]));
					ds.Clear();
				}
				this.Id = id;
			}
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("SeccionMenuLink_Save", true, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuID", SqlDbType.Int, this.SeccionMenuID.ToString()),
					dbHelper.MP("@Link", SqlDbType.VarChar, this.Link),
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
					dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo.ToString())
				});
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("SeccionMenuLink_Remove", true, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuLinkID", SqlDbType.Int, this.Id.ToString())
				});
			}
		}
	}
}
