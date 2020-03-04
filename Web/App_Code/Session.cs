using Camarco.Tools.Coding;
using System;
using System.Web;

namespace Camarco.Session
{
	public class Session
	{
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

		public Session()
		{
			HttpCookie huid = HttpContext.Current.Request.Cookies["HUID"];
			if (huid == null)
			{
				throw new SessionException();
			}
			try
			{
				this.UsuarioID = int.Parse(new GenerateKey
				{
					Base = TipoBase.BASE_26,
					ChecksumAlgorithm = Checksum.ChecksumType.Type1,
					LicenseTemplate = "uuuuuurrrrrrcccccc"
				}.DisassembleKey(huid.Value, "u", GenerateKey.TokenTypes.NUMBER));
				huid.Expires = DateTime.Now.AddMinutes(60.0);
				HttpContext.Current.Response.Cookies.Add(huid);
			}
			catch
			{
				throw new SessionException();
			}
		}

		public void LogOut()
		{
			HttpCookie myCookie = new HttpCookie("HUID");
			myCookie.Expires = DateTime.Now.AddDays(-1.0);
			HttpContext.Current.Response.Cookies.Add(myCookie);
		}
	}
    public class SessionException : Exception
    {
        public SessionException() { }
    }
    public class UnauthorizedException : Exception
    {
        public UnauthorizedException() { }
    }
}
