using System;
using System.Collections.Generic;
using System.Text;

namespace Camarco.Tools.Coding
{
    public class RandomNumber
    {
        System.Security.Cryptography.RNGCryptoServiceProvider _Random = new System.Security.Cryptography.RNGCryptoServiceProvider();
        public RandomNumber()
        {
          
        }
        /// <summary>
        /// Genera un Número Random de N digitos en una Base
        /// </summary>
        /// <param name="Base">Base del Numero Random</param>
        /// <param name="ConversionLength">Cantidad de Digitos del Numero Random</param>
        /// <returns></returns>
        public string GetRandomFromBase(TipoBase Base, int ConversionLength)
        {
            long maxValue = (long)Math.Pow(LanguageConvertor.Instance.Base_Digitos(Base).Length, ConversionLength);
            return LanguageConvertor.Instance.ConvertTo(this.GetNextInt64(maxValue), Base, ConversionLength);

        }

        /// <summary>
        /// Genera un Random del Tipo Long usando RNGCryptoServiceProvider
        /// </summary>
        /// <param name="maxValue">Máximo Valor a generar</param>
        /// <returns></returns>
        private long GetNextInt64(long maxValue)
        {
            byte[] _uint64Buffer = new byte[12];
            _Random.GetBytes(_uint64Buffer);
            long rand = Math.Abs(BitConverter.ToInt64(_uint64Buffer, 0));
            return (long)(rand % maxValue);
        }

    }
}
