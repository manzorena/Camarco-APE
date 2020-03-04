using System;

namespace Camarco.Tools.Validation
{
	public static class CUIT
	{
		public static bool ValidaCuit(string cuit)
		{
			bool result;
			if (cuit == null)
			{
				result = false;
			}
			else
			{
				cuit = cuit.Replace("-", string.Empty);
				if (cuit.Length != 11)
				{
					result = false;
				}
				else
				{
					int calculado = CUIT.CalcularDigitoCuit(cuit);
					int digito = int.Parse(cuit.Substring(10));
					result = (calculado == digito);
				}
			}
			return result;
		}

		public static int CalcularDigitoCuit(string cuit)
		{
			int[] mult = new int[]
			{
				5,
				4,
				3,
				2,
				7,
				6,
				5,
				4,
				3,
				2
			};
			char[] nums = cuit.ToCharArray();
			int total = 0;
			for (int i = 0; i < mult.Length; i++)
			{
				total += int.Parse(nums[i].ToString()) * mult[i];
			}
			int resto = total % 11;
			return (resto == 0) ? 0 : ((resto == 1) ? 9 : (11 - resto));
		}
	}
}
