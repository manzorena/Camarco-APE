using Camarco.Tools;
using Camarco.Tools.SQL;
using System;
using System.Data;

namespace Camarco.Model
{
	public static class Login
	{
		public static Usuario ValidateCredentials(string UserName, string Password)
		{
			int UsuarioID = 0;
			using (DBHelper dbHelper = new DBHelper())
			{
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Login_ValidateCredentials", false, new customParameter[]
				{
					dbHelper.MP("@UserName", SqlDbType.VarChar, UserName),
					dbHelper.MP("@Password", SqlDbType.VarChar, Encryption.SHAEncrypt(Password))
				}))
				{
					if (ds.Tables[0].Rows.Count > 0)
					{
						UsuarioID = (int)ds.Tables[0].Rows[0]["UsuarioID"];
					}
					ds.Clear();
				}
			}
			if (UsuarioID == 0)
			{
				throw new Exception("Las credenciales no corresponden a ningun Usuario existente.");
			}
			return new Usuario(UsuarioID);
		}
	}
}
