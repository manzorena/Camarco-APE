using System;
using System.Text.RegularExpressions;

namespace Camarco.Tools.Validation
{
	public static class Text
	{
		public static string Truncate(string value, int max)
		{
			string result;
			if (value == null || value.Length <= max)
			{
				result = value;
			}
			else
			{
				result = value.Substring(0, max);
			}
			return result;
		}

		public static string SQLQueryAcentos(string value)
		{
			value = value.ToLower();
			value = new Regex("[aá]").Replace(value, "[aá]");
			value = new Regex("[eé]").Replace(value, "[eé]");
			value = new Regex("[ií]").Replace(value, "[ií]");
			value = new Regex("[oó]").Replace(value, "[oó]");
			value = new Regex("[uú]").Replace(value, "[uú]");
			return value;
		}
	}
}
