using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class Documento
	{
		public bool ModelValidated = false;

		public int DocumentoID
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public string Descripcion
		{
			get;
			set;
		}

		public List<DocumentoCategoria> Categorias
		{
			get;
			set;
		}

		public DateTime FechaModificacion
		{
			get;
			set;
		}

		public int FileID
		{
			get;
			set;
		}

		public int ResourceID
		{
			get;
			set;
		}

		public bool Publico
		{
			get;
			set;
		}

		public Resource Resource
		{
			get;
			set;
		}

		public Documento()
		{
			this.DocumentoID = 0;
			this.Titulo = "";
			this.Descripcion = "";
			this.FechaModificacion = DateTime.Now;
			this.Publico = true;
			this.Categorias = new List<DocumentoCategoria>();
		}

		public Documento(int DID)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Documento_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@DocumentoID", SqlDbType.Int, DID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Documento > Load : El ID de Documento no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Titulo = (string)dR["Titulo"];
					this.Descripcion = (string)dR["Descripcion"];
					this.Categorias = new List<DocumentoCategoria>();
					this.FechaModificacion = (DateTime)dR["FechaModificacion"];
					this.FileID = (int)dR["FileID"];
					this.Publico = ((byte)dR["Publico"] == 1);
					this.ResourceID = (int)dR["ResourceID"];
					ds.Clear();
				}
			}
			this.DocumentoID = DID;
		}

		public void LoadCategorias()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Documento_GetCategorias", false, new customParameter[]
				{
					dbHelper.MP("@DocumentoID", SqlDbType.Int, this.DocumentoID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Categorias.Add(new DocumentoCategoria((int)dR["DocumentoCategoriaID"]));
					}
					ds.Clear();
				}
			}
		}

		public bool ValidateModel()
		{
			List<string> Errors = new List<string>();
			if (this.Titulo.Length == 0)
			{
				Errors.Add("Debe ingresar el Nombre.");
			}
			if (Errors.Count > 0)
			{
				throw new ValidationException(Errors);
			}
			this.ModelValidated = true;
			return true;
		}

		public void Save()
		{
			if (!this.ModelValidated)
			{
				this.ValidateModel();
			}
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.DocumentoID > 0)
				{
					dbHelper.RunSP("Documento_Update", true, new customParameter[]
					{
						dbHelper.MP("@DocumentoID", SqlDbType.Int, this.DocumentoID.ToString()),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@FechaModificacion", SqlDbType.SmallDateTime, this.FechaModificacion.ToString("dd/MM/yyyy")),
						dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString()),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
						dbHelper.MP("@Publico", SqlDbType.TinyInt, this.Publico ? "1" : "0")
					});
					dbHelper.RunSP("Documento_ClearCategorias", true, new customParameter[]
					{
						dbHelper.MP("@DocumentoID", SqlDbType.Int, this.DocumentoID.ToString())
					});
				}
				else
				{
					this.DocumentoID = dbHelper.RunSPReturnInteger("Documento_Save", true, new customParameter[]
					{
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@FechaModificacion", SqlDbType.SmallDateTime, this.FechaModificacion.ToString("yyyy-MM-dd HH:mm:ss")),
						dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString()),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
						dbHelper.MP("@Publico", SqlDbType.TinyInt, this.Publico ? "1" : "0")
					});
				}
				foreach (DocumentoCategoria c in this.Categorias)
				{
					dbHelper.RunSP("Documento_AddCategoria", true, new customParameter[]
					{
						dbHelper.MP("@DocumentoID", SqlDbType.Int, this.DocumentoID.ToString()),
						dbHelper.MP("@CategoriaID", SqlDbType.Int, c.DocumentoCategoriaID.ToString())
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Documento_Remove", true, new customParameter[]
				{
					dbHelper.MP("@DocumentoID", SqlDbType.Int, this.DocumentoID.ToString())
				});
			}
			ResourceManager.Remove(this.ResourceID);
		}

		public void LoadResource()
		{
			this.Resource = ((this.ResourceID == 0) ? new Resource() : new Resource(this.ResourceID));
		}
	}
}
