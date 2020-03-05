using Camarco.Tools;
using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Camarco.Model
{
	public class Resource
	{
		public string Slug;

		public int ResourceID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public ResourceType Type
		{
			get;
			set;
		}

		public string Tags
		{
			get;
			set;
		}

		public string URL
		{
			get;
			set;
		}

		public int Accessed
		{
			get;
			set;
		}

		public int Downloaded
		{
			get;
			set;
		}

		public List<Seccion> Secciones
		{
			get;
			set;
		}

		public Resource()
		{
			this.Slug = "";
			this.ResourceID = 0;
			this.Nombre = "";
			this.Tags = "";
			this.Accessed = 0;
			this.URL = "";
			this.Secciones = new List<Seccion>();
		}

		public Resource(int RID)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resource_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, RID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Resource > Load : El ID de Resource no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Nombre = (string)dR["Nombre"];
					this.Type = (ResourceType)((byte)dR["Type"]);
					this.URL = (string)dR["URL"];
					this.Accessed = (int)dR["Accessed"];
					this.Downloaded = (int)dR["Downloaded"];
					this.Slug = (string)dR["Slug"];
					this.Secciones = new List<Seccion>();
					ds.Clear();
				}
				List<string> t = new List<string>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Resource_GetTags", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, RID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						t.Add((string)dR["Text"]);
					}
				}
				this.Tags = string.Join(",", t.ToArray());
			}
			this.ResourceID = RID;
		}

		public void LoadSecciones()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("ResourceSecciones_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						this.Secciones.Add(new Seccion((int)dR["SeccionID"]));
					}
					ds.Clear();
				}
			}
		}

		public void SetAccessed()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Resource_Accessed", true, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString())
				});
			}
		}

		public void SetDownloaded()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Resource_Downloaded", true, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString())
				});
			}
		}

		public void Save()
		{
			this.Slug = Camarco.Tools.Slug.Create(true, this.Nombre);
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.ResourceID > 0)
				{
					dbHelper.RunSP("Resource_Update", true, new customParameter[]
					{
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
						dbHelper.MP("@Nombre", SqlDbType.VarChar, Text.Truncate(this.Nombre, 300)),
						dbHelper.MP("@URL", SqlDbType.VarChar, this.URL),
						dbHelper.MP("@Type", SqlDbType.TinyInt, ((int)this.Type).ToString()),
						dbHelper.MP("@Slug", SqlDbType.VarChar, this.Slug)
					});
				}
				else
				{
					this.ResourceID = dbHelper.RunSPReturnInteger("Resource_Save", true, new customParameter[]
					{
						dbHelper.MP("@Nombre", SqlDbType.VarChar, Text.Truncate(this.Nombre, 300)),
						dbHelper.MP("@URL", SqlDbType.VarChar, this.URL),
						dbHelper.MP("@Type", SqlDbType.TinyInt, ((int)this.Type).ToString()),
						dbHelper.MP("@Slug", SqlDbType.VarChar, this.Slug)
					});
				}
				StringBuilder seccionesxml = new StringBuilder("<secciones>");
				foreach (Seccion s in this.Secciones)
				{
					seccionesxml.Append("<seccion Id=\"" + s.SeccionID + "\"/>");
				}
				seccionesxml.Append("</secciones>");
				dbHelper.RunSP("Resource_SetSecciones", true, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
					dbHelper.MP("@Secciones", SqlDbType.Xml, seccionesxml.ToString())
				});
				StringBuilder tagsxml = new StringBuilder("<tags>");
				string[] array = this.Tags.Split(new char[]
				{
					','
				});
				for (int i = 0; i < array.Length; i++)
				{
					string s2 = array[i];
					if (!string.IsNullOrEmpty(s2))
					{
						tagsxml.Append("<tag Id=\"" + Tematicas.Save(s2.Trim()).ToString() + "\"/>");
					}
				}
				tagsxml.Append("</tags>");
				dbHelper.RunSP("Resource_SetTags", true, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID.ToString()),
					dbHelper.MP("@Tags", SqlDbType.Xml, tagsxml.ToString())
				});
			}
		}

		public string GetPublicUrl(int SeccionID)
		{
			string result;
			if (this.URL.Length > 0)
			{
				result = this.URL;
			}
			else
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					result = dbHelper.RunSPReturnString("Resource_GetSeccionSlug", false, new customParameter[]
					{
						dbHelper.MP("@SeccionID", SqlDbType.Int, SeccionID),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID)
					}) + "/" + this.Slug;
				}
			}
			return result;
		}

		public string GetPublicUrl(string ParentSlug)
		{
			string result;
			if (this.URL.Length > 0)
			{
				result = this.URL;
			}
			else
			{
				result = ParentSlug + "/" + this.Slug;
			}
			return result;
		}
	}
}
