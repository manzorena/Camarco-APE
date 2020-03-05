using System;
using System.Text.RegularExpressions;

namespace Camarco.Tools.Coding
{
	public class Checksum
	{
		public enum ChecksumType
		{
			Type1,
			Type2
		}

		private Checksum.ChecksumType checksumType;

		private ushort r = 55665;

		private ushort c1 = 52845;

		private ushort c2 = 22719;

		private uint sum = 0u;

		public uint ChecksumNumber
		{
			get
			{
				return this.sum;
			}
		}

		public Checksum.ChecksumType ChecksumAlgorithm
		{
			get
			{
				return this.checksumType;
			}
			set
			{
				this.checksumType = value;
			}
		}

		private void Add(byte vvalue)
		{
            byte cipher = (byte)((ulong)((vvalue ^ (r >> 8))));
            r = (ushort)((cipher + r) * c1 + c2);
            sum += cipher;
		}

		private void Calcchk1(string buffer)
		{
			for (int i = 0; i < buffer.Length; i++)
			{
				byte ba = (byte)buffer[i];
				this.Add(ba);
			}
		}

		private void Calcchk2(string buffer)
		{
            string mystring;	// my local string incase the string is an odd length
            ushort word16a;	// short is an int16
            ushort word16b;	// short is an int16
            ushort word16;		// short is an int16
            uint sumtemp;
            int count;

            mystring = buffer;
            count = mystring.Length;
            mystring = mystring + "00";	// add one to the length

            for (int i = 0; i < count; i = i + 2)
            {
                word16a = (ushort)(((int)mystring[i] << 8) & 0xFF00);
                word16b = (ushort)((int)mystring[i + 1] & 0xFF);
                word16 = (ushort)(word16a + word16b);
                sum = sum + (uint)word16;
            }
            // take only 16 bits out of the 32 bit sum and add up the carries
            sumtemp = sum >> 16;
            while ((sumtemp) != 0)
            {
                sum = (sum & 0xFFFF) + (sum >> 16);
                sumtemp = sum >> 16;
            }

            // one's complement the result
            sum = ~sum;
		}

		private static string CleanInput(string strIn)
		{
			return Regex.Replace(strIn, "-", "");
		}

		public void CalculateChecksum(string licenseKey)
		{
			licenseKey = Checksum.CleanInput(licenseKey);
			switch (this.checksumType)
			{
			case Checksum.ChecksumType.Type1:
				this.Calcchk1(licenseKey);
				break;
			case Checksum.ChecksumType.Type2:
				this.Calcchk2(licenseKey);
				break;
			}
		}
	}
}
