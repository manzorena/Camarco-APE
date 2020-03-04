using System;
using System.Globalization;
using System.Text.RegularExpressions;

namespace Camarco.Tools.Validation
{
	public static class Text
	{
		public static string Truncate(string value, int max)
		{
			if (value==null || value.Length <= max) return value;
			return value.Substring(0, max);
		}
		public static string SQLQueryAcentos(string value)
		{
			value = value.ToLower();
			value = (new Regex("[aá]")).Replace(value,"[aá]");
			value = (new Regex("[eé]")).Replace(value, "[eé]");
			value = (new Regex("[ií]")).Replace(value, "[ií]");
			value = (new Regex("[oó]")).Replace(value, "[oó]");
			value = (new Regex("[uú]")).Replace(value, "[uú]");
			return value;
		}
	}
	/*public class Email
	{
		bool invalid = false;

		public bool IsValidEmail(string strIn)
		{
			invalid = false;
			if (String.IsNullOrEmpty(strIn))
				return false;

			// Use IdnMapping class to convert Unicode domain names.
			strIn = Regex.Replace(strIn, @"(@)(.+)$", this.DomainMapper);
			if (invalid)
				return false;

			// Return true if strIn is in valid e-mail format.
			return Regex.IsMatch(strIn,
				   @"^(?("")(""[^""]+?""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
				   @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9]{2,17}))$",
				   RegexOptions.IgnoreCase);
		}

		private string DomainMapper(Match match)
		{
			// IdnMapping class with default property values.
			IdnMapping idn = new IdnMapping();

			string domainName = match.Groups[2].Value;
			try
			{
				domainName = idn.GetAscii(domainName);
			}
			catch (ArgumentException)
			{
				invalid = true;
			}
			return match.Groups[1].Value + domainName;
		}
	}*/
	public static class Email
	{
		public static bool EsValido(string mail)
		{
			try
			{
				System.Net.Mail.MailAddress m = new System.Net.Mail.MailAddress(mail);
				return true;
			}
			catch
			{
				return false;
			}
		}

	}
	public static class CUIT{
		public static bool ValidaCuit(string cuit)
		{
			if (cuit == null)
			{
				return false;
			}
			cuit = cuit.Replace("-", string.Empty);
			if (cuit.Length != 11)
			{
				return false;
			}
			else
			{
				int calculado = CalcularDigitoCuit(cuit);
				int digito = int.Parse(cuit.Substring(10));
				return calculado == digito;
			}
		}
		public static int CalcularDigitoCuit(string cuit)

  {

  int[] mult = new[] { 5, 4, 3, 2, 7, 6, 5, 4, 3, 2 };

  char[] nums = cuit.ToCharArray();

  int total = 0;

  for (int i = 0; i < mult.Length; i++)

  {

  total += int.Parse(nums[i].ToString()) * mult[i];

  }

  var resto = total % 11;

  return resto == 0 ? 0 : resto == 1 ? 9 : 11 - resto;

  }
		}
}
