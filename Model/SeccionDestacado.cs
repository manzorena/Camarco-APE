using Camarco.Tools.SQL;
using System;
using System.Data;
using System.Collections.Generic;

namespace Camarco.Model
{
	public class SeccionDestacado
	{
		public int Id
		{
			get;
			set;
		}

		public int FileID
		{
			get;
			set;
		}

		public int SeccionID
		{
			get;
			set;
		}

		public byte Orden
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

		public File File
		{
			get;
			set;
		}

		public SeccionDestacado()
		{
			this.Id = 0;
			this.FileID = 0;
			this.Orden = 0;
			this.Titulo = "";
			this.Descripcion = "";
		}

		public SeccionDestacado(int pid)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("SeccionDestacado_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@Id", SqlDbType.Int, pid.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("SeccionDestacado > Load : El ID de SeccionDestacado no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.File = new File((int)dR["FileID"]);
					this.Titulo = (string)dR["Titulo"];
					this.Descripcion = (string)dR["Descripcion"];
					this.Orden = (byte)dR["Orden"];
					this.Id = pid;
					ds.Clear();
				}
			}
		}

        public static List<Articulo> TransformarDesatacadosEnArticulos(List<Camarco.Model.SeccionDestacado> seccionDestacados)
        {
            List<Articulo> result = new List<Articulo>();
            foreach (Camarco.Model.SeccionDestacado sd in seccionDestacados)
            {
                List<ArticuloImagen> ai = new List<ArticuloImagen>();
                ai.Add(new ArticuloImagen(){
                    FileID = sd.FileID,
					File = sd.File,
                });

                var desc = String.IsNullOrEmpty(sd.Descripcion) || sd.Descripcion.Trim().Length == 0 ? "SinLink" : "ConLink";
                Resource r = new Resource()
                {
                    Slug = sd.Descripcion,
                    Nombre = desc,
                };

                result.Add(new Articulo()
                {
                    Imagenes = ai,
                    Resource = r,
                    Titulo = sd.Titulo,
                });
            }            
            return result;
        }

		public void Save()
		{
			if (this.Id == 0)
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					this.Id = dbHelper.RunSPReturnInteger("SeccionDestacado_Save", true, new customParameter[]
					{
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString()),
						dbHelper.MP("@Orden", SqlDbType.TinyInt, this.Orden.ToString()),
						dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString())
					});
				}
			}
			else
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					dbHelper.RunSP("SeccionDestacado_Update", true, new customParameter[]
					{
						dbHelper.MP("@Id", SqlDbType.Int, this.Id.ToString()),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@Orden", SqlDbType.TinyInt, this.Orden.ToString())
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("SeccionDestacado_Remove", true, new customParameter[]
				{
					dbHelper.MP("@Id", SqlDbType.Int, this.Id.ToString())
				});
			}
		}
	}
}
