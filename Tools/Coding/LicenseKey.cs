
using System;
using System.Text.RegularExpressions;


namespace Camarco.Tools.Coding
{
	/// <summary>
	/// A Summary description for GenerateKey.
	/// </summary>
	/// <remarks>
	/// This is the License Key class for generating License keys.
	/// It provides implementations of all License key operations. 
	/// </remarks>
	public class GenerateKey
	{
		/// <summary>
		/// Enumerated data types.
		/// </summary>
		public enum TokenTypes 
		{
			/// <summary>
			/// The data type is Numeric.
			/// </summary>
			NUMBER,
			/// <summary>
			/// The data type is Character.
			/// </summary>
			CHARACTER
		};

		/// <summary>
		/// Internal structure for the tokens.
		/// </summary>
		internal struct Tokens 
		{
			/// <summary>
			/// The data type
			/// </summary>
			TokenTypes	tokenType;

			/// <summary>
			/// The character token
			/// </summary>
			char	characterToken;

			/// <summary>
			/// The value of the item
			/// </summary>
			string	initialValue;

			/// <summary>
			/// 
			/// </summary>
			public Datatype	datatype;

			/// <summary>
			/// Add a token into the collection.
			/// </summary>
			/// <param name="characterTokenAdd">The character token.</param>
			/// <param name="tokenTypeAdd">The data type.</param>
			/// <param name="dataValue">The data value.</param>
            public void Add(char characterTokenAdd, TokenTypes tokenTypeAdd, string dataValue, Camarco.Tools.Coding.TipoBase aBase)
			{
				characterToken = characterTokenAdd;
				tokenType = tokenTypeAdd;
				initialValue = dataValue;

				switch(tokenTypeAdd) 
				{
					case TokenTypes.NUMBER:
                        datatype = new NumberDatatype(aBase);
						break;
					case TokenTypes.CHARACTER:
						datatype = new CharacterDatatype();
						break;
				}
			}


			/// <summary>
			/// Property to set/get the character token.
			/// </summary>		
			public char CharacterToken
			{
				get { return characterToken; }
				set	
				{
					characterToken = value;
				}
			}


			/// <summary>
			/// Property to set/get the character token.
			/// </summary>		
			public TokenTypes TokenType
			{
				get { return tokenType; }
				set	
				{
					tokenType = value;
				}
			}


			/// <summary>
			/// Property to set/get the current value.
			/// </summary>		
			public string InitialValue
			{
				get { return initialValue; }
				set	
				{
					initialValue = value;
				}
			}
		}
        TipoBase _Base;
		Tokens [] tokens;		// the list of tokens that can be used in the lciense string. 
        int maxTokens;
		string	licenseTemplate;// the template string that will be used to create the license key
		string	generatedLicensekey;	// the final license key that was made. 
		Checksum.ChecksumType	chktype;	// Checksum Algorithm type

		/// <summary>
		/// Find the token in the array. return the offset otherwise return a -1.
		/// </summary>
		/// <param name="tokenToFind">Token to find in the array structre.</param>
		/// <returns>Offset otherwise a -1</returns>
		private int	FindToken(char tokenToFind)
		{
			int		retoff=-1; 
			int		lop;

			// for each entry find the token in question. 
            if (tokens != null)
            {
                for (lop = 0; lop < tokens.Length; lop++)
                {
                    // Is this the token we are looking for? 
                    if (tokens[lop].CharacterToken == tokenToFind)
                    {
                        retoff = lop;
                        break;
                    }
                }
            }
			return(retoff);
		}


		/// <summary>
		/// GenerateKey constructor.
		/// </summary>
		public GenerateKey()
		{
			
			// initialzie the license key
			generatedLicensekey = "";
		}


		/// <summary>
		/// Method used to get the final license key.
		/// </summary>
		/// <example>
		/// <code>
		/// finalkey = gkey.GetLicenseKey(); 
		/// </code>
		/// </example>
		/// <returns>The license key.</returns>
		public string GetLicenseKey()
		{
			return(generatedLicensekey);
		}

        /// <summary>
		/// Tipo de Base de la Key
		/// </summary>
		/// <example>
		/// </example>
		public TipoBase Base
		{
			get { return this._Base; }
			set	
			{
				this._Base = (TipoBase)value;
			}
		}


		/// <summary>
		/// Algoritmo de Checksum
		/// </summary>
		/// <example>
		/// <code>
		/// gkey.CheckSumAlgorithm = ChecksumType.Type1; 
		/// </code>
		/// </example>
		public Checksum.ChecksumType ChecksumAlgorithm
		{
			get { return chktype; }
			set	
			{
				chktype = value;
			}
		}

        /// <summary>
		/// Template de License Key
		/// </summary>
		/// <example>
		/// <code>
		/// gkey.LicenseTemplate = "xxvv-xxxxxxxx-xxxxxxxx-ppxx"; 
		/// </code>
		/// </example>
		public string LicenseTemplate
		{
			get { return licenseTemplate; }
			set	
			{
				licenseTemplate = value;
			}
		}

        /// <summary>
        /// Maxima cantidad de Tokens
        /// </summary>
        /// <example>
        /// <code>
        /// gkey.MaxTokens = 3; 
        /// </code>
        /// </example>
        public int MaxTokens
        {
            get { return maxTokens; }
            set
            {
                tokens = new Tokens[value];
                maxTokens = value;
            }
        }

		/// <summary>
		/// Agrega un Token
		/// </summary>
		/// <param name="location">Numeral de la ubicacion del Token.</param>
		/// <param name="characterToken">Caracter del Token.</param>
		/// <param name="tokenTypeAdd">Tipo de Token.</param>
		/// <param name="initialValue">The initial value of the data.</param>
		/// <example>
		/// <code>
		/// gkey.AddToken(0, "v", LicenseKey.GenerateKey.TokenTypes.NUMBER, "1"); 
		/// </code>
		/// </example>
		/// <exception cref="System.ApplicationException">Thrown when the location is out of bounds</exception>
		/// <returns>None</returns>
		public void AddToken(int location, string characterToken, TokenTypes tokenTypeAdd, string initialValue)
		{
			tokens[location].Add(Convert.ToChar(characterToken), tokenTypeAdd, initialValue, this._Base);
		}


		/// <summary>
		/// Genera un Numero Random para la Licencia en la Base utilizada
		/// </summary>
		/// <param name="numberLength">The size of the field.</param>
		private void GetRandomNumber(int numberLength)
		{
			
            RandomNumber rN = new RandomNumber();
            generatedLicensekey += rN.GetRandomFromBase(this._Base, numberLength);
			return;
		}

		/// <summary>
		/// Genera un Numero de CheckSum
		/// </summary>
		/// <param name="Licensekey">License Key.</param>
		/// <param name="numberLength">Tamaño del Campo de Checksum.</param>
		/// <param name="includeLicensekey">Incluye el License Key original .</param>
		private string  GetChecksumNumber(string Licensekey, int numberLength, bool includeLicensekey)
		{
			Checksum	chk = new Checksum();
			chk.ChecksumAlgorithm = chktype;
			chk.CalculateChecksum(Licensekey);
			if ( includeLicensekey ) 
			{
				uint	csum = chk.ChecksumNumber;
				Licensekey = Licensekey + LanguageConvertor.Instance.ConvertTo((long)csum, this._Base, numberLength);
			}
			else 
			{
				uint	csum = chk.ChecksumNumber;
				Licensekey = LanguageConvertor.Instance.ConvertTo((long)csum, this._Base, numberLength);
			}
			return (Licensekey);
		}



		/// <summary>
		/// Crea la License Key
		/// </summary>
		/// <example>
		/// <code>
		/// gkey = new GenerateKey();
		/// gkey.LicenseTemplate = "vpxx-wwxx-xxxx-xxxx-xxxx";
		/// gkey.MaxTokens = 3;
		/// gkey.AddToken(0, "v", LicenseKey.GenerateKey.TokenTypes.NUMBER, "1");
		/// gkey.AddToken(1, "p", LicenseKey.GenerateKey.TokenTypes.NUMBER, "2");
		/// gkey.AddToken(2, "w", LicenseKey.GenerateKey.TokenTypes.CHARACTER, "QR");
		/// gkey.Base = LicenseNumber.TipoBase.BASE_10;
		/// gkey.<b>CreateKey</b>();
		/// finalkey = gkey.GetLicenseKey();
		/// </code>
		/// </example>
		public void CreateKey()
		{
			int		lop;
			int		slen;
			char	slast;
			char	stok;
			int		scnt;
			int		i;
			int		retoff;
			//
			// Initialize the finalkey so we do not reuse it. 
			//
			this.generatedLicensekey = "";
			//
			// Check the length of the template string 
			//
			slen = licenseTemplate.Length;
			if ( slen == 0 ) 
			{
				// throw a exception that the user can understand. 
				throw new ApplicationException("Enter a key template");
			}
			//
			// if a token is in the license string then make sure it fits into it's field for size.
			// make sure it is as large as what is entered in the tempate string
			//
            if (tokens != null)
            {
                for (lop = 0; lop < tokens.Length; lop++)
                {
                    try
                    {
                        tokens[lop].datatype.CheckToken(licenseTemplate, tokens[lop].InitialValue, tokens[lop].CharacterToken);
                    }
                    catch (System.Exception ex)
                    {
                        throw ex;
                    }
                }
            }
			// initialize the variables. 
			slast = '\0';
			scnt = 0; 
			// now go through the license template to see what tokens are found. 
			// fill in the license key string now that we know everything will fit. 
			for (i = 0; i < slen; i++)
			{
				stok = licenseTemplate[i];
				if ( stok != slast ) 
				{
					if ( scnt != 0 ) 
					{
						// find the token in the token class
						retoff = FindToken(slast);
						if ( retoff == -1) 
						{
							// we will not see a x in the list so if it is an
							// x then handle it here. 
							switch(slast) 
							{
								case 'x':
									try 
									{
										GetRandomNumber(scnt);
									}
									catch 
									{
										throw;
									}
									break;
								case 'c':
									try 
									{
										generatedLicensekey = GetChecksumNumber(generatedLicensekey, scnt, true);
									}
                                    catch 
									{
										throw;
									}
									break;
								case '-':
									generatedLicensekey = generatedLicensekey + "-";
									break;
								default:
									// we could not find the token so this is illegal
									throw new ApplicationException("Token not found in input list");
							}
						}
						else 
						{
							generatedLicensekey = generatedLicensekey + tokens[retoff].datatype.CreateStringRepresentation(scnt);
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
			//
			// handle anything that was left over. 
			//
			if ( scnt != 0 ) 
			{
				// find the token in the token class
				retoff = FindToken(slast);
				if ( retoff == -1) 
				{
					// we will not see a x in the list so if it is an
					// x then handle it here. 
					switch(slast) 
					{
						case 'x':
							try 
							{
								GetRandomNumber(scnt);
							}
                            catch 
							{
								throw;
							}
							break;
						case 'c':
							try 
							{
								generatedLicensekey = GetChecksumNumber(generatedLicensekey, scnt, true);
							}
                            catch 
							{
								throw;
							}
							break;
						case '-':
							generatedLicensekey = generatedLicensekey + "-";
							break;
						default:
							// we could not find the token so this is illegal
							throw new ApplicationException("Token not found in input list");
					}
				}
				else 
				{
					generatedLicensekey = generatedLicensekey + tokens[retoff].datatype.CreateStringRepresentation(scnt);
				}
			}
			return;
		}

		/// <summary>
		/// See if the input string has a checksum character.
		/// </summary>
		/// <param name="strIn">The input string to check.</param>
		/// <returns>bool flag.</returns>
		static bool MatchInput(string strIn)
		{
			bool	bans;
			// Replace invalid characters with empty strings.
			// such as the dash that we have in the string
			Match m = Regex.Match(strIn, @"c", RegexOptions.IgnoreCase); 
			if ( m.Success ) 
			{
				bans = true;
			}
			else 
			{
				bans = false;
			}
			return(bans);
		}

		/// <summary>
		/// Clean the input string of any unwanted characters.
		/// </summary>
		/// <param name="strIn">The input string to clean unwanted characters.</param>
		/// <returns>The cleaned string.</returns>
		static string CleanInput(string strIn)
		{
			// Replace invalid characters with empty strings.
			// such as the dash that we have in the string
			return Regex.Replace(strIn, @"-", ""); 
		}

		private int GetChecksumToklength(string	lickey)
		{
			int	cnt = 0;
            bool foundCheckSum = false; 

			foreach(char aChar in lickey)
			{

				if ( aChar == 'c' ) 
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

		
		/// <summary>
		/// Check the legal input for byte templates.
		/// </summary>
		/// <param name="lictemp">The license Template.</param>
		/// <param name="lickey">The license Key.</param>
		/// <returns></returns>
        private bool CheckInputLegalByte(string lictemp, string lickey)
		{
			bool	answer = true;
			int		slen;
			int		i;
			int		j;
			char	tokTem;
			char	tokLic;
			char	tokJunk;
			string	chkLicString;
			string	chkTemString;
			string	chktemp1;
			string	chktemp2;

			// initialize the string
			chkLicString = "";
			chkTemString = "";

			// determine the length of the template
			slen = lictemp.Length;

			// now go through the license template to see what tokens are found. 
			// fill in the license key string now that we know everything will fit. 
			for (i = 0; i < slen; i++)
			{
				tokTem = lictemp[i];
				tokLic = lickey[i];
				if ( tokTem == 'c' ) 
				{
					int	toklen = GetChecksumToklength(lictemp);
					// put together the checksum from the license key
					chktemp1 = "";
					for (j = 0; j < toklen; j++)
					{
						tokJunk = lickey[i + j];
						chktemp1 = chktemp1 + tokJunk.ToString();
					}
					// get the calculated checksum
					chktemp2 = GetChecksumNumber(chkLicString, toklen, false);
					// now see if they are equal
					if ( chktemp1 != chktemp2 ) 
					{
						answer = false;
					}
					break;
				}
				// add to the checksum string. 
				chkTemString = chkTemString + tokTem.ToString();
				chkLicString = chkLicString + tokLic.ToString();
			}
			return(answer);
		}

		/// <summary>
		/// Check the legal input for all templates.
		/// </summary>
		/// <param name="lictemp">The license Template.</param>
		/// <param name="lickey">The license Key.</param>
		/// <returns></returns>
        private bool CheckInputLegal(string lictemp, string lickey)
		{
			bool	answer;
			answer = CheckInputLegalByte(lictemp, lickey);
			return(answer);
		}

        /// <summary>
		/// Disassemble the Key for the Bytes mode.
		/// </summary>
		/// <param name="token">What token to search and dissemble for.</param>
		/// <returns>The string with the result.</returns>
        string DisassembleKeyBytes(string aLicenseKey, string token)
        {
            return this.DisassembleKeyBytes(aLicenseKey, token, false);
        }

		/// <summary>
		/// Disassemble the Key for the Bytes mode.
		/// </summary>
		/// <param name="token">What token to search and dissemble for.</param>
		/// <returns>The string with the result.</returns>
        string DisassembleKeyBytes(string aLicenseKey, string token,bool allowDashes)
		{
			string	localLicenseTemplate;	// the template that will be used to create the license key
			string	localLicensekey;		// the final license key that was made. 
			string	result;
			string	LicTokenvalue="";
			string	TemTokenvalue="";
			char	tokTem;
			char	tokLic;
			int		slen;
			int		i;
			bool	hasChecksum;
			bool	answer;


			// use local variable so we can strip the dashes
			localLicenseTemplate = this.licenseTemplate;
            localLicensekey = aLicenseKey;

			// clean the input of the dashes
            if (!allowDashes)
            {
                localLicenseTemplate = CleanInput(localLicenseTemplate);
                localLicensekey = CleanInput(localLicensekey);
            }
			// determine the length of the template
			slen = localLicenseTemplate.Length;

			// check to see if any checksum
			hasChecksum = MatchInput(localLicenseTemplate);
			if ( hasChecksum ) 
			{
				answer = CheckInputLegal(localLicenseTemplate, localLicensekey);
				if ( !answer ) 
				{
					// we could not find the token so this is illegal
					throw new ApplicationException("Checksum invalido.");
				}
			}

			// now go through the license template to see what tokens are found. 
			// fill in the license key string now that we know everything will fit. 
			for (i = 0; i < slen; i++)
			{
				tokTem = localLicenseTemplate[i];
				tokLic = localLicensekey[i];
				if ( tokTem == token[0] ) 
				{
					LicTokenvalue = LicTokenvalue + tokLic.ToString();
					TemTokenvalue = TemTokenvalue + tokTem.ToString();
				}
			}
			result = LicTokenvalue;
			return(result);
		}



		/// <summary>
		/// Dissassemble the license key based on the template.
		/// </summary>
		/// <param name="token">The token that you want disassembled.</param>
		/// <example>
		/// <code>
		/// result = gkey.DisassembleKey("p"); 
		/// </code>
		/// </example>
		/// <exception cref="System.ApplicationException">Thrown when the Licensekey Is Empty</exception>
		/// <exception cref="System.ApplicationException">Thrown when the Licensekey Template Is Empty</exception>
		/// <returns>The token value represented as a string.</returns>
        public string DisassembleKey(string aLicenseKey, string token, Camarco.Tools.Coding.GenerateKey.TokenTypes tokenType)
        {
            return this.DisassembleKey(aLicenseKey, token, tokenType, false);
        }

		/// <summary>
		/// Dissassemble the license key based on the template.
		/// </summary>
		/// <param name="token">The token that you want disassembled.</param>
		/// <example>
		/// <code>
		/// result = gkey.DisassembleKey("p"); 
		/// </code>
		/// </example>
		/// <exception cref="System.ApplicationException">Thrown when the Licensekey Is Empty</exception>
		/// <exception cref="System.ApplicationException">Thrown when the Licensekey Template Is Empty</exception>
		/// <returns>The token value represented as a string.</returns>
		public string DisassembleKey(string aLicenseKey,string token, Camarco.Tools.Coding.GenerateKey.TokenTypes tokenType, bool allowDashes)
		{
			string	result;
			int		slen;
			//
			// If the final License key is empty then error.  
			//
            if (aLicenseKey.Length == 0) 
			{
				// we could not find the token so this is illegal
				throw new ApplicationException("License key Is Empty");
			}
			//
			// If the final License key is empty then error.  
			//
			slen = licenseTemplate.Length;
			if ( slen == 0 ) 
			{
				// we could not find the token so this is illegal
				throw new ApplicationException("License key Template Is Empty");
			}

            result = DisassembleKeyBytes(aLicenseKey, token, allowDashes);	// disassemble the license key for bytes

            //SI EL TOKEN ES UN STRING SE DEVUELVE SIN MODIFICAR
            if (tokenType == TokenTypes.CHARACTER)
                return result;

            //SI ES UN NUMERO SE CONVIERTE A BASE 10
            return LanguageConvertor.Instance.ConvertFrom(result, this.Base).ToString();
			
		}
	}
}
