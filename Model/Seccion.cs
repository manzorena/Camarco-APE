using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class Seccion
	{
		public bool ModelValidated = false;

		public int SeccionID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public string Descripcion
		{
			get;
			set;
		}

		public string TituloPagina
		{
			get;
			set;
		}

		public string Texto
		{
			get;
			set;
		}

		public string Video
		{
			get;
			set;
		}

		public int Orden
		{
			get;
			set;
		}

		public int Template
		{
			get;
			set;
		}

		public string Color
		{
			get;
			set;
		}

		public bool MenuPrincipal
		{
			get;
			set;
		}

		public Seccion Parent
		{
			get;
			set;
		}

		public List<SeccionDestacado> Destacados
		{
			get;
			set;
		}

		public List<SeccionArchivo> Archivos
		{
			get;
			set;
		}

		public int ResourceID
		{
			get;
			set;
		}

		public Resource Resource
		{
			get;
			set;
		}

		public bool EspacioPyme
		{
			get;
			set;
		}

		public Seccion()
		{
			this.ResourceID = 0;
			this.Resource = new Resource();
			this.Texto = "";
			this.Video = "";
			this.Nombre = "";
			this.Descripcion = "";
			this.Orden = 0;
			this.Template = 0;
			this.SeccionID = 0;
			this.MenuPrincipal = false;
			this.Parent = null;
			this.Destacados = new List<SeccionDestacado>();
			this.Archivos = new List<SeccionArchivo>();
			this.TituloPagina = "";
			this.EspacioPyme = false;
		}

		public Seccion(int pSID) : this()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, pSID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Seccion > Load : El ID de Seccion no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Nombre = (string)dR["Nombre"];
					this.Descripcion = (string)dR["Descripcion"];
					this.TituloPagina = (string)dR["TituloPagina"];
					this.Color = (string)dR["Color"];
					this.Orden = (int)((byte)dR["Orden"]);
					this.Template = (int)((byte)dR["Template"]);
					this.Resource = new Resource((int)dR["ResourceID"]);
					this.MenuPrincipal = ((byte)dR["MenuPrincipal"] == 1);
					this.Parent = ((dR["ParentID"] == DBNull.Value) ? null : new Seccion((int)dR["ParentID"]));
					this.Texto = ((dR["Texto"] == DBNull.Value) ? null : ((string)dR["Texto"]));
					this.Video = ((dR["Video"] == DBNull.Value) ? null : ((string)dR["Video"]));
					this.EspacioPyme = (dR["EspacioPyme"] != DBNull.Value && (byte)dR["EspacioPyme"] == 1);
					this.Destacados = new List<SeccionDestacado>();
					this.Archivos = new List<SeccionArchivo>();
					ds.Clear();
				}
			}
			this.SeccionID = pSID;
		}

		public void LoadDestacados()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetDestacados", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Destacados.Add(new SeccionDestacado((int)dR["SeccionDestacado"]));
					}
					ds.Clear();
				}
			}
		}

        public void LoadDestacadosSeccion(int seccionID)
        {
            using (DBHelper dbHelper = new DBHelper())
            {
                using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetDestacados", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccionID.ToString())
				}))
                {
                    foreach (DataRow dR in ds.Tables[0].Rows)
                    {
                        this.Destacados.Add(new SeccionDestacado((int)dR["SeccionDestacado"]));
                    }
                    ds.Clear();
                }
            }
        }

		public void LoadArchivos()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Seccion_GetArchivos", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Archivos.Add(new SeccionArchivo((int)dR["SeccionArchivoID"], (int)dR["FileID"], (string)dR["Titulo"]));
					}
					ds.Clear();
				}
			}
		}

		public bool ValidateModel()
		{
			List<string> Errors = new List<string>();
			if (this.Nombre.Length == 0)
			{
				Errors.Add("Debe ingresar el Nombre.");
			}
			if (this.Descripcion.Length == 0)
			{
				Errors.Add("Debe ingresar la Descripcion de la Seccion.");
			}
			if (this.Template == 0)
			{
				Errors.Add("Debe seleccionar el Template de la Seccion.");
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
				if (this.SeccionID > 0)
				{
					dbHelper.RunSP("Seccion_Update", true, new customParameter[]
					{
						dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString()),
						dbHelper.MP("@Nombre", SqlDbType.VarChar, Text.Truncate(this.Nombre, 100)),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, Text.Truncate(this.Descripcion, 500)),
						dbHelper.MP("@TituloPagina", SqlDbType.VarChar, Text.Truncate(this.TituloPagina, 100)),
						dbHelper.MP("@Texto", SqlDbType.VarChar, Text.Truncate(this.Texto, 8000)),
						dbHelper.MP("@Video", SqlDbType.VarChar, this.Video),
						dbHelper.MP("@Color", SqlDbType.VarChar, this.Color),
						dbHelper.MP("@Template", SqlDbType.TinyInt, this.Template.ToString()),
						dbHelper.MP("@MenuPrincipal", SqlDbType.TinyInt, this.MenuPrincipal ? "1" : "0"),
						dbHelper.MP("@ParentID", SqlDbType.Int, (this.Parent == null) ? "0" : this.Parent.SeccionID.ToString()),
						dbHelper.MP("@EspacioPyme", SqlDbType.TinyInt, this.EspacioPyme ? 1 : 0)
					});
				}
				else
				{
					this.SeccionID = dbHelper.RunSPReturnInteger("Seccion_Save", true, new customParameter[]
					{
						dbHelper.MP("@Nombre", SqlDbType.VarChar, Text.Truncate(this.Nombre, 100)),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, Text.Truncate(this.Descripcion, 500)),
						dbHelper.MP("@TituloPagina", SqlDbType.VarChar, Text.Truncate(this.TituloPagina, 100)),
						dbHelper.MP("@Texto", SqlDbType.VarChar, Text.Truncate(this.Texto, 8000)),
						dbHelper.MP("@Video", SqlDbType.VarChar, this.Video),
						dbHelper.MP("@Color", SqlDbType.VarChar, this.Color),
						dbHelper.MP("@Template", SqlDbType.TinyInt, this.Template.ToString()),
						dbHelper.MP("@MenuPrincipal", SqlDbType.TinyInt, this.MenuPrincipal ? "1" : "0"),
						dbHelper.MP("@ParentID", SqlDbType.Int, (this.Parent == null) ? "0" : this.Parent.SeccionID.ToString()),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
						dbHelper.MP("@EspacioPyme", SqlDbType.TinyInt, this.EspacioPyme ? 1 : 0)
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Seccion_Remove", true, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString())
				});
			}
		}

		public void Reordenar(int Orden)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Seccion_Reordenar", true, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString()),
					dbHelper.MP("@Orden", SqlDbType.TinyInt, Orden.ToString())
				});
			}
		}
	}
}
