using System;

namespace Camarco.Tools.Coding
{
	public class NumberDatatype : Datatype
	{
		private long dataValue;

		public NumberDatatype(TipoBase aBase)
		{
			this._Base = aBase;
		}

		public override bool CheckTokenSize(string tokStream, int rcnt)
		{
			long tokvalue = Convert.ToInt64(tokStream);
			string tokConverted;
			try
			{
				tokConverted = LanguageConvertor.Instance.ConvertTo(tokvalue, this._Base);
			}
			catch
			{
				throw new ApplicationException("Enter a number on Base 10.");
			}
			bool result;
			if (tokConverted.Length <= rcnt)
			{
				this.dataValue = tokvalue;
				result = true;
			}
			else
			{
				result = false;
			}
			return result;
		}

		public override void CheckToken(string LicTempInp, string tokinp, char tok)
		{
			if (LicTempInp.Length > 0)
			{
				if (LicTempInp.IndexOf(tok) < 0)
				{
					throw new ApplicationException("If you enter a token you must also have an entry in the template string");
				}
				if (tok == 'c' || tok == 'x')
				{
					throw new ApplicationException("Reserved token name.");
				}
				int slen = LicTempInp.Length;
				int rcnt = 0;
				bool flgfound = false;
				for (int i = 0; i < slen; i++)
				{
					char stok = LicTempInp[i];
					if (stok == tok)
					{
						rcnt++;
					}
					else
					{
						if (rcnt != 0)
						{
							if (flgfound)
							{
								throw new ApplicationException("You can not specify more than one of the same token");
							}
							if (!this.CheckTokenSize(tokinp, rcnt))
							{
								throw new ApplicationException("Please enter a token that will fit into the size to the specified token");
							}
							flgfound = true;
						}
						rcnt = 0;
					}
				}
				if (rcnt != 0)
				{
					if (!this.CheckTokenSize(tokinp, rcnt))
					{
						throw new ApplicationException("Please enter a token that will fit into the size to the specified token");
					}
				}
			}
		}

		public override string CreateStringRepresentation(int targetLength)
		{
			return LanguageConvertor.Instance.ConvertTo(this.dataValue, this._Base, targetLength);
		}
	}
}
