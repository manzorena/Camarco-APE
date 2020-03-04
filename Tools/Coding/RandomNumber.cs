using System;
using System.Security.Cryptography;

namespace Camarco.Tools.Coding
{
	public class RandomNumber
	{
		private RNGCryptoServiceProvider _Random = new RNGCryptoServiceProvider();

		public string GetRandomFromBase(TipoBase Base, int ConversionLength)
		{
			long maxValue = (long)Math.Pow((double)LanguageConvertor.Instance.Base_Digitos(Base).Length, (double)ConversionLength);
			return LanguageConvertor.Instance.ConvertTo(this.GetNextInt64(maxValue), Base, ConversionLength);
		}

		private long GetNextInt64(long maxValue)
		{
			byte[] _uint64Buffer = new byte[12];
			this._Random.GetBytes(_uint64Buffer);
			long rand = Math.Abs(BitConverter.ToInt64(_uint64Buffer, 0));
			return rand % maxValue;
		}
	}
}
