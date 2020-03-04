using System;
using System.Net.Mail;

namespace Camarco.Tools.Validation
{
	public static class Email
	{
		public static bool EsValido(string mail)
		{
			bool result;
			try
			{
				MailAddress i = new MailAddress(mail);
				result = true;
			}
			catch
			{
				result = false;
			}
			return result;
		}
	}
}
