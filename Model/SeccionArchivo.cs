using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public class SeccionArchivo
	{
		public int SeccionArchivoID
		{
			get;
			set;
		}

		public int SeccionID
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

		public SeccionArchivo()
		{
			this.SeccionID = (this.FileID = 0);
			this.Titulo = "";
		}

		public SeccionArchivo(int id, int fid, string t)
		{
			this.SeccionArchivoID = id;
			this.File = new File(fid);
			this.Titulo = t;
		}

		public SeccionArchivo(int id)
		{
			this.SeccionArchivoID = id;
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				this.SeccionArchivoID = dbHelper.RunSPReturnInteger("SeccionArchivo_Save", true, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, this.SeccionID.ToString()),
					dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
					dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString())
				});
			}
		}

		public void Remove()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("SeccionArchivo_Remove", true, new customParameter[]
				{
					dbHelper.MP("@SeccionArchivoID", SqlDbType.Int, this.SeccionArchivoID.ToString())
				});
			}
		}
	}
}
