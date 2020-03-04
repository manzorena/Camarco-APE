using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public class ArticuloImagen
	{
		public int ArticuloID
		{
			get;
			set;
		}

		public int ArticuloImagenID
		{
			get;
			set;
		}

		public byte Orden
		{
			get;
			set;
		}

		public File File
		{
			get;
			set;
		}

		public File FileThumb
		{
			get;
			set;
		}

		public int FileID
		{
			get;
			set;
		}

		public int FileThumbID
		{
			get;
			set;
		}

		public ArticuloImagen()
		{
			this.FileThumbID = (this.ArticuloID = (this.ArticuloImagenID = (this.FileID = 0)));
			this.Orden = 0;
		}

		public ArticuloImagen(int id) : this()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("ArticuloImagen_GetById", false, new customParameter[]
				{
					dbHelper.MP("@ArticuloImagenID", SqlDbType.Int, id.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Articulo > Load : El ID de Articulo no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.ArticuloID = (int)dR["ArticuloID"];
					this.Orden = (byte)dR["Orden"];
					this.File = new File((int)dR["FileID"]);
					this.FileThumb = ((dR["FileThumbID"] == DBNull.Value) ? null : new File((int)dR["FileThumbID"]));
					ds.Clear();
				}
			}
			this.ArticuloImagenID = id;
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.ArticuloImagenID == 0)
				{
					this.ArticuloImagenID = dbHelper.RunSPReturnInteger("ArticuloImagen_Save", true, new customParameter[]
					{
						dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString()),
						dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString()),
						dbHelper.MP("@FileThumbID", SqlDbType.Int, this.FileThumbID.ToString()),
						dbHelper.MP("@Orden", SqlDbType.TinyInt, this.Orden.ToString())
					});
				}
				else
				{
					dbHelper.RunSP("ArticuloImagen_Update", true, new customParameter[]
					{
						dbHelper.MP("@ArticuloImagenID", SqlDbType.Int, this.ArticuloImagenID.ToString()),
						dbHelper.MP("@Orden", SqlDbType.TinyInt, this.Orden.ToString())
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("ArticuloImagen_Remove", true, new customParameter[]
				{
					dbHelper.MP("@ArticuloImagenID", SqlDbType.Int, this.ArticuloImagenID.ToString())
				});
			}
		}
	}
}
