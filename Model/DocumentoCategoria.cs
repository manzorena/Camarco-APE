using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class DocumentoCategoria
	{
		public int DocumentoCategoriaID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public DocumentoCategoria Parent
		{
			get;
			set;
		}

		public DocumentoCategoria()
		{
			this.DocumentoCategoriaID = 0;
			this.Nombre = "";
			this.Parent = null;
		}

		public DocumentoCategoria(int CID)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("DocumentoCategoria_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, CID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("DocumentoCategoria > Load : El ID de Categoria no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Nombre = (string)dR["Nombre"];
					this.Parent = ((dR["ParentID"] == DBNull.Value) ? null : new DocumentoCategoria((int)dR["ParentID"]));
					ds.Clear();
				}
			}
			this.DocumentoCategoriaID = CID;
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.DocumentoCategoriaID == 0)
				{
					this.DocumentoCategoriaID = dbHelper.RunSPReturnInteger("DocumentoCategoria_Save", true, new customParameter[]
					{
						dbHelper.MP("@Nombre", SqlDbType.VarChar, this.Nombre),
						dbHelper.MP("@ParentID", SqlDbType.Int, (this.Parent == null) ? "0" : this.Parent.DocumentoCategoriaID.ToString())
					});
				}
				else
				{
					dbHelper.RunSPReturnInteger("DocumentoCategoria_Update", true, new customParameter[]
					{
						dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, this.DocumentoCategoriaID),
						dbHelper.MP("@Nombre", SqlDbType.VarChar, this.Nombre),
						dbHelper.MP("@ParentID", SqlDbType.Int, (this.Parent == null) ? "0" : this.Parent.DocumentoCategoriaID.ToString())
					});
				}
			}
		}

		public List<DocumentoCategoria> GetSubs()
		{
			List<DocumentoCategoria> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<DocumentoCategoria> retval = new List<DocumentoCategoria>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("DocumentoCategoria_GetSubs", false, new customParameter[]
				{
					dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, this.DocumentoCategoriaID)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new DocumentoCategoria((int)dR["DocumentoCategoriaID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("DocumentoCategoria_Remove", true, new customParameter[]
				{
					dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, this.DocumentoCategoriaID)
				});
			}
		}

		public bool TieneDocumentos()
		{
			bool result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = (dbHelper.RunSPReturnInteger("DocumentoCategoria_TieneDocumentos", false, new customParameter[]
				{
					dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, this.DocumentoCategoriaID)
				}) == 1);
			}
			return result;
		}

		public void Unificar(int target)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("DocumentoCategoria_Unificar", true, new customParameter[]
				{
					dbHelper.MP("@DocumentoCategoriaID", SqlDbType.Int, this.DocumentoCategoriaID),
					dbHelper.MP("@Target", SqlDbType.Int, target)
				});
			}
		}
	}
}
