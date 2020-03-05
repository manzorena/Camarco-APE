using Camarco.Tools;
using Camarco.Tools.Coding;
using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public class Usuario
	{
		public bool ModelValidated = false;

		public int UsuarioID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public string UserName
		{
			get;
			set;
		}

		public string Password
		{
			get;
			set;
		}

		public string Email
		{
			get;
			set;
		}

		public Usuario(int pUID)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Usuario_GetByID", false, new customParameter[]
				{
					dbHelper.MP("@UsuarioID", SqlDbType.Int, pUID.ToString())
				}))
				{
					if (ds.Tables[0].Rows.Count == 0)
					{
						throw new Exception("Usuario > Load : El ID de Usuario no existe.");
					}
					DataRow dR = ds.Tables[0].Rows[0];
					this.Nombre = (string)dR["Nombre"];
					this.UserName = (string)dR["UserName"];
					this.Email = (string)dR["Email"];
					ds.Clear();
				}
			}
			this.UsuarioID = pUID;
		}

		public bool ValidateModel()
		{
			List<string> Errors = new List<string>();
			if (this.Nombre.Length == 0)
			{
				Errors.Add("Debe ingresar el Nombre Completo.");
			}
			if (this.UsuarioID == 0 && this.UserName.Length == 0)
			{
				Errors.Add("Debe ingresar el Codigo del Usuario.");
			}
			if (this.UsuarioID == 0 && this.Password.Length == 0)
			{
				Errors.Add("Debe ingresar el Password del Usuario.");
			}
			if (this.UsuarioID == 0)
			{
				using (DBHelper dbHelper = new DBHelper())
				{
					int num = dbHelper.RunSPReturnInteger("Usuario_ValidateCredentials", false, new customParameter[]
					{
						dbHelper.MP("@UserName", SqlDbType.VarChar, this.UserName)
					});
					if (num == 1)
					{
						Errors.Add("Existe otro Usuario creado con el mismo Codigo, elija otro por favor.");
					}
				}
			}
			if (Errors.Count > 0)
			{
				throw new ValidationException(Errors);
			}
			this.ModelValidated = true;
			return true;
		}

		public string GetCookie()
		{
			GenerateKey gK = new GenerateKey();
			gK.Base = TipoBase.BASE_26;
			gK.ChecksumAlgorithm = Checksum.ChecksumType.Type1;
			gK.LicenseTemplate = "uuuuuurrrrrrcccccc";
			gK.MaxTokens = 2;
			gK.AddToken(0, "u", GenerateKey.TokenTypes.NUMBER, this.UsuarioID.ToString());
			gK.AddToken(1, "r", GenerateKey.TokenTypes.NUMBER, new Random(DateTime.Now.Second).Next(308915776).ToString());
			gK.CreateKey();
			return gK.GetLicenseKey();
		}

		public void ChangePassword(string oldpass, string password)
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Usuario_ChangePassword", true, new customParameter[]
				{
					dbHelper.MP("@UsuarioID", SqlDbType.Int, this.UsuarioID.ToString()),
					dbHelper.MP("@OldPassword", SqlDbType.VarChar, Encryption.SHAEncrypt(oldpass)),
					dbHelper.MP("@Password", SqlDbType.VarChar, Encryption.SHAEncrypt(password))
				});
			}
		}
	}
}
