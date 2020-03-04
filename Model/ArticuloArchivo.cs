using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public class ArticuloArchivo
	{
		public int ArticuloArchivoID
		{
			get;
			set;
		}

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

		public File File
		{
			get;
			set;
		}

		public int FileID
		{
			get;
			set;
		}

		public ArticuloArchivo()
		{
			this.ArticuloID = (this.FileID = 0);
			this.Titulo = "";
		}

		public ArticuloArchivo(int id, int fid, string t)
		{
			this.ArticuloArchivoID = id;
			this.File = new File(fid);
			this.Titulo = t;
		}

		public ArticuloArchivo(int id)
		{
			this.ArticuloArchivoID = id;
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				this.ArticuloArchivoID = dbHelper.RunSPReturnInteger("ArticuloArchivo_Save", true, new customParameter[]
				{
					dbHelper.MP("@ArticuloID", SqlDbType.Int, this.ArticuloID.ToString()),
					dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
					dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString())
				});
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("ArticuloArchivo_Remove", true, new customParameter[]
				{
					dbHelper.MP("@ArticuloArchivoID", SqlDbType.Int, this.ArticuloArchivoID.ToString())
				});
			}
		}
	}
}
