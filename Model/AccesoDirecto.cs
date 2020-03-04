using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class AccesoDirecto
	{
		public int Id
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public byte Orden
		{
			get;
			set;
		}

		public int SeccionID
		{
			get;
			set;
		}

		public List<AccesoDirectoLink> Links
		{
			get;
			set;
		}

		public AccesoDirecto()
		{
			this.Titulo = "";
			this.Orden = 0;
			this.Links = new List<AccesoDirectoLink>();
		}

		public AccesoDirecto(int id)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenu_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuID", SqlDbType.Int, id.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("AccesoDirecto > Load : El ID de AccesoDirecto no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Titulo = (string)dR["Titulo"];
					this.SeccionID = (int)dR["SeccionID"];
					this.Orden = (byte)dR["Orden"];
					ds.Clear();
				}
				this.Links = new List<AccesoDirectoLink>();
			}
			this.Id = id;
		}

		public void LoadLinks()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenu_GetLink", false, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuID", SqlDbType.Int, this.Id.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Links.Add(new AccesoDirectoLink((int)dR["SeccionMenuLinkID"]));
					}
					ds.Clear();
				}
			}
		}

		public void Save()
		{
			if (this.Id == 0)
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					this.Id = dbHelper.RunSPReturnInteger("SeccionMenu_Save", true, new customParameter[]
					{
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Orden", SqlDbType.TinyInt, this.Orden.ToString()),
						dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString())
					});
				}
			}
			else
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					dbHelper.RunSP("SeccionMenu_Update", true, new customParameter[]
					{
						dbHelper.MP("@SeccionMenuID", SqlDbType.Int, this.Id.ToString()),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo)
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("SeccionMenu_Remove", true, new customParameter[]
				{
					dbHelper.MP("@SeccionMenuID", SqlDbType.Int, this.Id.ToString())
				});
			}
		}
	}
}
