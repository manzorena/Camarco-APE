using Camarco.Tools.SQL;
using System;
using System.Data;
using System.Xml;

namespace Camarco.Model
{
	public class File
	{
		public int FileID
		{
			get;
			set;
		}

		public string Filename
		{
			get;
			set;
		}

		public string Extension
		{
			get;
			set;
		}

		public string Filebinary
		{
			get;
			set;
		}

		public int Kb
		{
			get;
			set;
		}

		public File()
		{
			this.FileID = 0;
			this.Kb = 0;
		}

		public File(int pFileID) : this()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("File_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@FileID", SqlDbType.Int, pFileID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("File > Load : El ID de File no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Filename = (string)dR["Filename"];
					this.Extension = (string)dR["Extension"];
					this.Kb = (int)((short)dR["Kb"]);
					ds.Clear();
				}
				this.FileID = pFileID;
			}
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				this.FileID = dbHelper.RunSPReturnInteger("File_Save", true, new customParameter[]
				{
					dbHelper.MP("@Filename", SqlDbType.VarChar, this.Filename),
					dbHelper.MP("@Extension", SqlDbType.VarChar, this.Extension),
					dbHelper.MP("@Filebinary", SqlDbType.VarChar, this.Filebinary),
					dbHelper.MP("@Kb", SqlDbType.SmallInt, this.Kb)
				});
			}
		}

		public void Delete()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("File_Delete", true, new customParameter[]
				{
					dbHelper.MP("@FileID", SqlDbType.Int, this.FileID)
				});
			}
		}

		public void SetDownloaded()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("File_SetDownloaded", true, new customParameter[]
				{
					dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString())
				});
			}
		}

		public string GetHTTPContentType()
		{
			string text = this.Extension.ToLower();
			string result;
			switch (text)
			{
			case "doc":
			case "docx":
			case "rtf":
				result = "Application/msword";
				return result;
			case "jpg":
				result = "image/JPEG";
				return result;
			case "png":
				result = "image/PNG";
				return result;
			case "gif":
				result = "image/GIF";
				return result;
			case "pdf":
				result = "Application/pdf";
				return result;
			}
			result = "text/plain";
			return result;
		}

		public bool IsImage()
		{
			string text = this.Extension.ToLower();
			bool result;
			if (text != null)
			{
				if (text == "jpg" || text == "gif" || text == "png")
				{
					result = true;
					return result;
				}
			}
			result = false;
			return result;
		}

		public byte[] GetFile()
		{
			byte[] result;
			using (DBHelper dbHelper = new DBHelper())
			{
				XmlDocument xmlResponseDOM = new XmlDocument();
				xmlResponseDOM.LoadXml("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" + dbHelper.RunSPReturnReadedXmlReader("File_GetFile", false, new customParameter[]
				{
					dbHelper.MP("@FileID", SqlDbType.Int, this.FileID.ToString())
				}));
				result = Convert.FromBase64String(xmlResponseDOM.SelectSingleNode("row").Attributes.GetNamedItem("FileBinary").Value);
			}
			return result;
		}
	}
}
