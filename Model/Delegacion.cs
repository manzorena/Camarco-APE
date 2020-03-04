using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public class Delegacion
	{
		public int DelegacionID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public string Domicilio
		{
			get;
			set;
		}

		public string Email
		{
			get;
			set;
		}

		public string Telefono
		{
			get;
			set;
		}

		public string Fax
		{
			get;
			set;
		}

		public string Contacto
		{
			get;
			set;
		}

		public string Presidente
		{
			get;
			set;
		}

		public Provincia Provincia
		{
			get;
			set;
		}

		public int ProvinciaID
		{
			get;
			set;
		}

		public Delegacion()
		{
			this.Nombre = (this.Domicilio = (this.Email = (this.Telefono = (this.Fax = (this.Contacto = (this.Presidente = ""))))));
		}

		public Delegacion(int id)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Delegacion_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@DelegacionID", SqlDbType.Int, id.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Seccion > Load : El ID de Seccion no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Nombre = (string)dR["Nombre"];
					this.Domicilio = (string)dR["Domicilio"];
					this.Email = (string)dR["Email"];
					this.Telefono = (string)dR["Telefono"];
					this.Fax = (string)dR["Fax"];
					this.Contacto = (string)dR["Contacto"];
					this.Presidente = (string)dR["Presidente"];
					this.Provincia = new Provincia((int)((short)dR["ProvinciaID"]), (string)dR["ProvinciaNombre"]);
					ds.Clear();
				}
			}
			this.DelegacionID = id;
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Delegacion_Remove", true, new customParameter[]
				{
					dbHelper.MP("@DelegacionID", SqlDbType.Int, this.DelegacionID.ToString())
				});
			}
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.DelegacionID > 0)
				{
					dbHelper.RunSP("Delegacion_Update", true, new customParameter[]
					{
						dbHelper.MP("@DelegacionID", SqlDbType.Int, this.DelegacionID.ToString()),
						dbHelper.MP("@Domicilio", SqlDbType.VarChar, this.Domicilio),
						dbHelper.MP("@Email", SqlDbType.VarChar, this.Email),
						dbHelper.MP("@Telefono", SqlDbType.VarChar, this.Telefono),
						dbHelper.MP("@Fax", SqlDbType.VarChar, this.Fax),
						dbHelper.MP("@Contacto", SqlDbType.VarChar, this.Contacto),
						dbHelper.MP("@Presidente", SqlDbType.VarChar, this.Presidente),
						dbHelper.MP("@Nombre", SqlDbType.VarChar, this.Nombre),
						dbHelper.MP("@ProvinciaID", SqlDbType.SmallInt, this.ProvinciaID.ToString())
					});
				}
				else
				{
					this.DelegacionID = dbHelper.RunSPReturnInteger("Delegacion_Save", true, new customParameter[]
					{
						dbHelper.MP("@Domicilio", SqlDbType.VarChar, this.Domicilio),
						dbHelper.MP("@Email", SqlDbType.VarChar, this.Email),
						dbHelper.MP("@Telefono", SqlDbType.VarChar, this.Telefono),
						dbHelper.MP("@Fax", SqlDbType.VarChar, this.Fax),
						dbHelper.MP("@Contacto", SqlDbType.VarChar, this.Contacto),
						dbHelper.MP("@Presidente", SqlDbType.VarChar, this.Presidente),
						dbHelper.MP("@Nombre", SqlDbType.VarChar, this.Nombre),
						dbHelper.MP("@ProvinciaID", SqlDbType.SmallInt, this.ProvinciaID.ToString())
					});
				}
			}
		}
	}
}
