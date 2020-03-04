using System;
using System.Security.Cryptography;
using System.Text;

namespace Camarco.Tools
{
	public static class Encryption
	{
		public static string SHAEncrypt(string text)
		{
			UTF8Encoding encoder = new UTF8Encoding();
			SHA256Managed sha256hasher = new SHA256Managed();
			byte[] hashedDataBytes = sha256hasher.ComputeHash(encoder.GetBytes(text));
			return Encryption.byteArrayToString(hashedDataBytes);
		}

		public static string byteArrayToString(byte[] inputArray)
		{
			StringBuilder output = new StringBuilder("");
			for (int i = 0; i < inputArray.Length; i++)
			{
				output.Append(inputArray[i].ToString("X2"));
			}
			return output.ToString();
		}
	}
}
