using System;
using System.Text;

namespace Camarco.Tools
{
	public static class Slug
	{
		public static string Create(bool toLower, params string[] values)
		{
			return Slug.Create(toLower, string.Join("-", values));
		}

		public static string Create(bool toLower, string value)
		{
			string result;
			if (value == null)
			{
				result = "";
			}
			else
			{
				string normalised = value.Normalize(NormalizationForm.FormKD);
				int len = normalised.Length;
				bool prevDash = false;
				StringBuilder sb = new StringBuilder(len);
				for (int i = 0; i < len; i++)
				{
					char c = normalised[i];
					if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
					{
						if (prevDash)
						{
							sb.Append('-');
							prevDash = false;
						}
						sb.Append(c);
					}
					else if (c >= 'A' && c <= 'Z')
					{
						if (prevDash)
						{
							sb.Append('-');
							prevDash = false;
						}
						if (toLower)
						{
							sb.Append(c | ' ');
						}
						else
						{
							sb.Append(c);
						}
					}
					else if (c == ' ' || c == ',' || c == '.' || c == '/' || c == '\\' || c == '-' || c == '_' || c == '=')
					{
						if (!prevDash && sb.Length > 0)
						{
							prevDash = true;
						}
					}
					else
					{
						string swap = Slug.ConvertEdgeCases(c, toLower);
						if (swap != null)
						{
							if (prevDash)
							{
								sb.Append('-');
								prevDash = false;
							}
							sb.Append(swap);
						}
					}
					if (sb.Length == 80)
					{
						break;
					}
				}
				result = sb.ToString();
			}
			return result;
		}

		private static string ConvertEdgeCases(char c, bool toLower)
		{
			string swap = null;
			if (c <= 'ø')
			{
				switch (c)
				{
				case 'Þ':
					swap = "th";
					break;
				case 'ß':
					swap = "ss";
					break;
				default:
					if (c == 'ø')
					{
						swap = "o";
					}
					break;
				}
			}
			else if (c != 'đ')
			{
				if (c != 'ı')
				{
					switch (c)
					{
					case 'Ł':
						swap = (toLower ? "l" : "L");
						break;
					case 'ł':
						swap = "l";
						break;
					}
				}
				else
				{
					swap = "i";
				}
			}
			else
			{
				swap = "d";
			}
			return swap;
		}
	}
}
