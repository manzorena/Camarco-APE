using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class Articulo
	{
		public int ArticuloID
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public string Subtitulo
		{
			get;
			set;
		}

		public string DescripcionCorta
		{
			get;
			set;
		}

		public string DescripcionLarga
		{
			get;
			set;
		}

		public string VideoURL
		{
			get;
			set;
		}

		public DateTime FechaPublicacion
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

		public List<ArticuloImagen> Imagenes
		{
			get;
			set;
		}

		public List<ArticuloArchivo> Archivos
		{
			get;
			set;
		}

		public bool Destacado
		{
			get;
			set;
		}

        public bool Evento
        {
            get;
            set;
        }

		public string FechaHora
		{
			get;
			set;
		}

		public Articulo()
		{
			this.ArticuloID = (this.ResourceID = 0);
			this.Titulo = (this.Subtitulo = (this.DescripcionCorta = (this.DescripcionLarga = (this.VideoURL = ""))));
			this.Imagenes = new List<ArticuloImagen>();
			this.Archivos = new List<ArticuloArchivo>();
			this.Resource = new Resource();
			this.Destacado = false;
            this.Evento = false;
		}

		public Articulo(int id) : this()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Articulo_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@ArticuloID", SqlDbType.Int, id.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Articulo > Load : El ID de Articulo no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Titulo = (string)dR["Titulo"];
					this.Subtitulo = (string)dR["Subtitulo"];
					this.DescripcionCorta = (string)dR["DescripcionCorta"];
					this.DescripcionLarga = (string)dR["DescripcionLarga"];
					this.FechaHora = ((dR["FechaHora"] == DBNull.Value) ? "" : ((string)dR["FechaHora"]));
					this.FechaPublicacion = (DateTime)dR["FechaPublicacion"];
					this.VideoURL = ((dR["VideoURL"] == DBNull.Value) ? "" : ((string)dR["VideoURL"]));
					this.Resource = new Resource((int)dR["ResourceID"]);
                    this.Destacado = ((byte)dR["Destacado"] == 1);
                    this.Evento = ((byte)dR["EsEvento"] == 1);
					ds.Clear();
				}
			}
			this.ArticuloID = id;
		}

		public void LoadImagenes()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Articulo_GetImagenes", false, new customParameter[]
				{
					dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Imagenes.Add(new ArticuloImagen((int)dR["ArticuloImagenID"]));
					}
					ds.Clear();
				}
			}
		}

		public void LoadArchivos()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Articulo_GetArchivos", false, new customParameter[]
				{
					dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Archivos.Add(new ArticuloArchivo((int)dR["ArticuloArchivoID"], (int)dR["FileID"], (string)dR["Titulo"]));
					}
					ds.Clear();
				}
			}
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.ArticuloID == 0)
				{
					this.ArticuloID = dbHelper.RunSPReturnInteger("Articulo_Save", true, new customParameter[]
					{
						dbHelper.MP("@Titulo", SqlDbType.VarChar, Text.Truncate(this.Titulo, 200)),
						dbHelper.MP("@Subtitulo", SqlDbType.VarChar, Text.Truncate(this.Subtitulo, 200)),
						dbHelper.MP("@DescripcionCorta", SqlDbType.VarChar, this.DescripcionCorta),
						dbHelper.MP("@DescripcionLarga", SqlDbType.VarChar, this.DescripcionLarga),
						dbHelper.MP("@VideoURL", SqlDbType.VarChar, this.VideoURL),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
						dbHelper.MP("@Destacado", SqlDbType.TinyInt, this.Destacado ? "1" : "0"),
                        dbHelper.MP("@EsEvento", SqlDbType.TinyInt, this.Evento ? "1" : "0"),
						dbHelper.MP("@FechaHora", SqlDbType.VarChar, this.FechaHora)
					});
				}
				else
				{
					dbHelper.RunSP("Articulo_Update", true, new customParameter[]
					{
						dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString()),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, Text.Truncate(this.Titulo, 200)),
						dbHelper.MP("@Subtitulo", SqlDbType.VarChar, Text.Truncate(this.Subtitulo, 200)),
						dbHelper.MP("@DescripcionCorta", SqlDbType.VarChar, this.DescripcionCorta),
						dbHelper.MP("@DescripcionLarga", SqlDbType.VarChar, this.DescripcionLarga),
						dbHelper.MP("@VideoURL", SqlDbType.VarChar, this.VideoURL),
						dbHelper.MP("@Destacado", SqlDbType.TinyInt, this.Destacado ? "1" : "0"),
                        dbHelper.MP("@EsEvento", SqlDbType.TinyInt, this.Evento ? "1" : "0"),
						dbHelper.MP("@FechaHora", SqlDbType.VarChar, this.FechaHora),
						dbHelper.MP("@FechaPublicacion", SqlDbType.SmallDateTime, this.FechaPublicacion.ToString("dd/MM/yyyy"))
					});
				}
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Articulo_Remove", true, new customParameter[]
				{
					dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString())
				});
			}
			ResourceManager.Remove(this.Resource.ResourceID);
		}
	}
}
