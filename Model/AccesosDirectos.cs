using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Camarco.Model
{
	public class AccesoDirecto
	{
		public int Id { get; set; }
		public string Titulo { get; set; }
		public byte Orden { get; set; }
		public int SeccionID { get; set; }
		public List<AccesoDirectoLink> Links { get; set; }
		public AccesoDirecto() { Titulo = ""; Orden = 0; Links = new List<AccesoDirectoLink>(); }
		
		public AccesoDirecto(int id)
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				using (System.Data.DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenu_GetByID", false, dbHelper.MP("@SeccionMenuID", System.Data.SqlDbType.Int, id.ToString())))
				{
					if (ds.Tables[0].Rows.Count == 0)
						throw new Exception("AccesoDirecto > Load : El ID de AccesoDirecto no existe.");
					System.Data.DataRow dR = ds.Tables[0].Rows[0];
					Titulo = (string)dR["Titulo"];
					SeccionID = (int)dR["SeccionID"];
					Orden = (byte)dR["Orden"];
					ds.Clear();
				}
				Links = new List<AccesoDirectoLink>();
				
			}
			Id = id;
		}
		public void LoadLinks()
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				using (System.Data.DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenu_GetLink", false, dbHelper.MP("@SeccionMenuID", System.Data.SqlDbType.Int, Id.ToString())))
				{
					foreach (System.Data.DataRow dR in ds.Tables[0].Rows)
					{
						Links.Add(new AccesoDirectoLink((int)dR["SeccionMenuLinkID"]));
					}
					ds.Clear();
				}
			}
		}
		public void Save()
		{
			if (Id == 0)
			{
				using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
				{
					Id = dbHelper.RunSPReturnInteger("SeccionMenu_Save", true, dbHelper.MP("@Titulo", System.Data.SqlDbType.VarChar, Titulo), dbHelper.MP("@Orden", System.Data.SqlDbType.TinyInt, Orden.ToString()), dbHelper.MP("@SeccionID", System.Data.SqlDbType.Int, SeccionID.ToString()));
				}
			}
			else
			{
				using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
				{
					dbHelper.RunSP("SeccionMenu_Update", true, dbHelper.MP("@SeccionMenuID", System.Data.SqlDbType.Int, Id.ToString()), dbHelper.MP("@Titulo", System.Data.SqlDbType.VarChar, Titulo));
				}
			}
		}
		public void Remove()
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				dbHelper.RunSP("SeccionMenu_Remove", true, dbHelper.MP("@SeccionMenuID", System.Data.SqlDbType.Int, Id.ToString()));
			}
		}


	}
	public class AccesoDirectoLink
	{
		public int Id { get; set; }
		public int SeccionMenuID{get;set;}
		public string Titulo { get; set; }
		public string Link{get;set;}
		public Resource Resource {get;set;}
		public int ResourceID { get; set; }
		public AccesoDirectoLink() { Link = ""; Resource = null; ResourceID = 0; Titulo = ""; }
		public AccesoDirectoLink(int id)
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				using (System.Data.DataSet ds = dbHelper.RunSPReturnDataSet("SeccionMenuLink_GetByID", false, dbHelper.MP("@SeccionMenuLinkID", System.Data.SqlDbType.Int, id.ToString())))
				{
					if (ds.Tables[0].Rows.Count == 0)
						throw new Exception("AccesoDirecto > Load : El ID de AccesoDirecto no existe.");
					System.Data.DataRow dR = ds.Tables[0].Rows[0];
					Link = (string)dR["Link"];
					Titulo = (string)dR["Titulo"];
					Resource = (dR["ResourceID"] == DBNull.Value ? null : new Resource((int)dR["ResourceID"]));
					ds.Clear();
				}
				Id = id;
			}
		}
		public void Save()
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				dbHelper.RunSP("SeccionMenuLink_Save", true, dbHelper.MP("@SeccionMenuID", System.Data.SqlDbType.Int, SeccionMenuID.ToString()), dbHelper.MP("@Link", System.Data.SqlDbType.VarChar, Link), dbHelper.MP("@ResourceID", System.Data.SqlDbType.Int, ResourceID.ToString()), dbHelper.MP("@Titulo", System.Data.SqlDbType.VarChar, Titulo.ToString()));
			}

		}
		public void Remove()
		{
			using (Tools.SQL.DBHelper dbHelper = new Tools.SQL.DBHelper())
			{
				dbHelper.RunSP("SeccionMenuLink_Remove", true, dbHelper.MP("@SeccionMenuLinkID", System.Data.SqlDbType.Int, Id.ToString()));
			}
		}
	}
}
