using System;
using System.Text.RegularExpressions;

namespace Camarco.Tools.Coding
{
	public class GenerateKey
	{
		public enum TokenTypes
		{
			NUMBER,
			CHARACTER
		}

		internal struct Tokens
		{
			private GenerateKey.TokenTypes tokenType;

			private char characterToken;

			private string initialValue;

			public Datatype datatype;

			public char CharacterToken
			{
				get
				{
					return this.characterToken;
				}
				set
				{
					this.characterToken = value;
				}
			}

			public GenerateKey.TokenTypes TokenType
			{
				get
				{
					return this.tokenType;
				}
				set
				{
					this.tokenType = value;
				}
			}

			public string InitialValue
			{
				get
				{
					return this.initialValue;
				}
				set
				{
					this.initialValue = value;
				}
			}

			public void Add(char characterTokenAdd, GenerateKey.TokenTypes tokenTypeAdd, string dataValue, TipoBase aBase)
			{
				this.characterToken = characterTokenAdd;
				this.tokenType = tokenTypeAdd;
				this.initialValue = dataValue;
				switch (tokenTypeAdd)
				{
				case GenerateKey.TokenTypes.NUMBER:
					this.datatype = new NumberDatatype(aBase);
					break;
				case GenerateKey.TokenTypes.CHARACTER:
					this.datatype = new CharacterDatatype();
					break;
				}
			}
		}

		private TipoBase _Base;

		private GenerateKey.Tokens[] tokens;

		private int maxTokens;

		private string licenseTemplate;

		private string generatedLicensekey;

		private Checksum.ChecksumType chktype;

		public TipoBase Base
		{
			get
			{
				return this._Base;
			}
			set
			{
				this._Base = value;
			}
		}

		public Checksum.ChecksumType ChecksumAlgorithm
		{
			get
			{
				return this.chktype;
			}
			set
			{
				this.chktype = value;
			}
		}

		public string LicenseTemplate
		{
			get
			{
				return this.licenseTemplate;
			}
			set
			{
				this.licenseTemplate = value;
			}
		}

		public int MaxTokens
		{
			get
			{
				return this.maxTokens;
			}
			set
			{
				this.tokens = new GenerateKey.Tokens[value];
				this.maxTokens = value;
			}
		}

		private int FindToken(char tokenToFind)
		{
			int retoff = -1;
			if (this.tokens != null)
			{
				for (int lop = 0; lop < this.tokens.Length; lop++)
				{
					if (this.tokens[lop].CharacterToken == tokenToFind)
					{
						retoff = lop;
						break;
					}
				}
			}
			return retoff;
		}

		public GenerateKey()
		{
			this.generatedLicensekey = "";
		}

		public string GetLicenseKey()
		{
			return this.generatedLicensekey;
		}

		public void AddToken(int location, string characterToken, GenerateKey.TokenTypes tokenTypeAdd, string initialValue)
		{
			this.tokens[location].Add(Convert.ToChar(characterToken), tokenTypeAdd, initialValue, this._Base);
		}

		private void GetRandomNumber(int numberLength)
		{
			RandomNumber rN = new RandomNumber();
			this.generatedLicensekey += rN.GetRandomFromBase(this._Base, numberLength);
		}

		private string GetChecksumNumber(string Licensekey, int numberLength, bool includeLicensekey)
		{
			Checksum chk = new Checksum();
			chk.ChecksumAlgorithm = this.chktype;
			chk.CalculateChecksum(Licensekey);
			if (includeLicensekey)
			{
				uint csum = chk.ChecksumNumber;
				Licensekey += LanguageConvertor.Instance.ConvertTo((long)((ulong)csum), this._Base, numberLength);
			}
			else
			{
				uint csum = chk.ChecksumNumber;
				Licensekey = LanguageConvertor.Instance.ConvertTo((long)((ulong)csum), this._Base, numberLength);
			}
			return Licensekey;
		}

		public void CreateKey()
		{
			this.generatedLicensekey = "";
			int slen = this.licenseTemplate.Length;
			if (slen == 0)
			{
				throw new ApplicationException("Enter a key template");
			}
			if (this.tokens != null)
			{
				for (int lop = 0; lop < this.tokens.Length; lop++)
				{
					try
					{
						this.tokens[lop].datatype.CheckToken(this.licenseTemplate, this.tokens[lop].InitialValue, this.tokens[lop].CharacterToken);
					}
					catch (Exception ex)
					{
						throw ex;
					}
				}
			}
			char slast = '\0';
			int scnt = 0;
			for (int i = 0; i < slen; i++)
			{
				char stok = this.licenseTemplate[i];
				if (stok != slast)
				{
					if (scnt != 0)
					{
						int retoff = this.FindToken(slast);
						if (retoff == -1)
						{
							char c = slast;
							if (c != '-')
							{
								if (c != 'c')
								{
									if (c != 'x')
									{
										throw new ApplicationException("Token not found in input list");
									}
									try
									{
										this.GetRandomNumber(scnt);
									}
									catch
									{
										throw;
									}
								}
								else
								{
									try
									{
										this.generatedLicensekey = this.GetChecksumNumber(this.generatedLicensekey, scnt, true);
									}
									catch
									{
										throw;
									}
								}
							}
							else
							{
								this.generatedLicensekey += "-";
							}
						}
						else
						{
							this.generatedLicensekey += this.tokens[retoff].datatype.CreateStringRepresentation(scnt);
						}
						scnt = 1;
					}
					else
					{
						scnt++;
					}
				}
				else
				{
					scnt++;
				}
				slast = stok;
			}
			if (scnt != 0)
			{
				int retoff = this.FindToken(slast);
				if (retoff == -1)
				{
					char c = slast;
					if (c != '-')
					{
						if (c != 'c')
						{
							if (c != 'x')
							{
								throw new ApplicationException("Token not found in input list");
							}
							try
							{
								this.GetRandomNumber(scnt);
							}
							catch
							{
								throw;
							}
						}
						else
						{
							try
							{
								this.generatedLicensekey = this.GetChecksumNumber(this.generatedLicensekey, scnt, true);
							}
							catch
							{
								throw;
							}
						}
					}
					else
					{
						this.generatedLicensekey += "-";
					}
				}
				else
				{
					this.generatedLicensekey += this.tokens[retoff].datatype.CreateStringRepresentation(scnt);
				}
			}
		}

		private static bool MatchInput(string strIn)
		{
			Match i = Regex.Match(strIn, "c", RegexOptions.IgnoreCase);
			return i.Success;
		}

		private static string CleanInput(string strIn)
		{
			return Regex.Replace(strIn, "-", "");
		}

		private int GetChecksumToklength(string lickey)
		{
			int cnt = 0;
			bool foundCheckSum = false;
			for (int i = 0; i < lickey.Length; i++)
			{
				char aChar = lickey[i];
				if (aChar == 'c')
				{
					foundCheckSum = true;
					cnt++;
				}
				else if (foundCheckSum)
				{
					break;
				}
			}
			return cnt;
		}

		private bool CheckInputLegalByte(string lictemp, string lickey)
		{
			bool answer = true;
			string chkLicString = "";
			string chkTemString = "";
			int slen = lictemp.Length;
			for (int i = 0; i < slen; i++)
			{
				char tokTem = lictemp[i];
				char tokLic = lickey[i];
				if (tokTem == 'c')
				{
					int toklen = this.GetChecksumToklength(lictemp);
					string chktemp = "";
					for (int j = 0; j < toklen; j++)
					{
						chktemp += lickey[i + j].ToString();
					}
					string chktemp2 = this.GetChecksumNumber(chkLicString, toklen, false);
					if (chktemp != chktemp2)
					{
						answer = false;
					}
					break;
				}
				chkTemString += tokTem.ToString();
				chkLicString += tokLic.ToString();
			}
			return answer;
		}

		private bool CheckInputLegal(string lictemp, string lickey)
		{
			return this.CheckInputLegalByte(lictemp, lickey);
		}

		private string DisassembleKeyBytes(string aLicenseKey, string token)
		{
			return this.DisassembleKeyBytes(aLicenseKey, token, false);
		}

		private string DisassembleKeyBytes(string aLicenseKey, string token, bool allowDashes)
		{
			string LicTokenvalue = "";
			string TemTokenvalue = "";
			string localLicenseTemplate = this.licenseTemplate;
			string localLicensekey = aLicenseKey;
			if (!allowDashes)
			{
				localLicenseTemplate = GenerateKey.CleanInput(localLicenseTemplate);
				localLicensekey = GenerateKey.CleanInput(localLicensekey);
			}
			int slen = localLicenseTemplate.Length;
			bool hasChecksum = GenerateKey.MatchInput(localLicenseTemplate);
			if (hasChecksum)
			{
				if (!this.CheckInputLegal(localLicenseTemplate, localLicensekey))
				{
					throw new ApplicationException("Checksum invalido.");
				}
			}
			for (int i = 0; i < slen; i++)
			{
				char tokTem = localLicenseTemplate[i];
				char tokLic = localLicensekey[i];
				if (tokTem == token[0])
				{
					LicTokenvalue += tokLic.ToString();
					TemTokenvalue += tokTem.ToString();
				}
			}
			return LicTokenvalue;
		}

		public string DisassembleKey(string aLicenseKey, string token, GenerateKey.TokenTypes tokenType)
		{
			return this.DisassembleKey(aLicenseKey, token, tokenType, false);
		}

		public string DisassembleKey(string aLicenseKey, string token, GenerateKey.TokenTypes tokenType, bool allowDashes)
		{
			if (aLicenseKey.Length == 0)
			{
				throw new ApplicationException("License key Is Empty");
			}
			int slen = this.licenseTemplate.Length;
			if (slen == 0)
			{
				throw new ApplicationException("License key Template Is Empty");
			}
			string result = this.DisassembleKeyBytes(aLicenseKey, token, allowDashes);
			string result2;
			if (tokenType == GenerateKey.TokenTypes.CHARACTER)
			{
				result2 = result;
			}
			else
			{
				result2 = LanguageConvertor.Instance.ConvertFrom(result, this.Base).ToString();
			}
			return result2;
		}
	}
}
