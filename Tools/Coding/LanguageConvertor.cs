using System;

namespace Camarco.Tools.Coding
{
	public sealed class LanguageConvertor
	{
		public static readonly LanguageConvertor Instance = new LanguageConvertor();

		private LanguageConvertor()
		{
		}

		public string Base_Digitos(TipoBase _tipoBase)
		{
			string result;
			switch (_tipoBase)
			{
			case TipoBase.BASE_10:
				result = "0123456789";
				break;
			case TipoBase.BASE_16:
				result = "0123456789ABCDEF";
				break;
			case TipoBase.BASE_26:
				result = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
				break;
			case TipoBase.BASE_26_NUM:
				result = "0123456789ABCDEFGHIJKLMNOP";
				break;
			case TipoBase.BASE_2:
				result = "01";
				break;
			default:
				result = "";
				break;
			}
			return result;
		}

		public string ConvertTo(long base10Number, TipoBase aBase, int ConversionLength)
		{
			string retval = "";
			string baseDigitos = this.Base_Digitos(aBase);
			long dividendo = base10Number;
			while (dividendo >= (long)baseDigitos.Length)
			{
				long resto;
				dividendo = Math.DivRem(dividendo, (long)baseDigitos.Length, out resto);
				retval = baseDigitos[(int)resto] + retval;
			}
			retval = baseDigitos[(int)dividendo] + retval;
			if (ConversionLength > 0 && retval.Length < ConversionLength)
			{
				retval = retval.PadLeft(ConversionLength, baseDigitos[0]);
			}
			string result;
			if (ConversionLength > 0 && retval.Length > ConversionLength)
			{
				long maxValue = (long)Math.Pow((double)baseDigitos.Length, (double)ConversionLength);
				while (base10Number >= maxValue)
				{
					base10Number -= maxValue;
				}
				result = this.ConvertTo(base10Number, aBase, ConversionLength);
			}
			else
			{
				result = retval;
			}
			return result;
		}

		public string ConvertTo(long base10Number, TipoBase aBase)
		{
			return this.ConvertTo(base10Number, aBase, 0);
		}

		public long ConvertFrom(string baseXNumber, TipoBase aBase)
		{
			string baseDigitos = this.Base_Digitos(aBase);
			long retval = 0L;
			for (int i = 0; i < baseXNumber.Length; i++)
			{
				retval += (long)Math.Pow((double)baseDigitos.Length, (double)(baseXNumber.Length - 1 - i)) * (long)baseDigitos.IndexOf(baseXNumber[i]);
			}
			return retval;
		}
	}
}
