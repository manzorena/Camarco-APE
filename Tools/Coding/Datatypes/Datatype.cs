using System;

namespace Camarco.Tools.Coding
{
	public class Datatype
	{
		protected TipoBase _Base;

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

		public virtual bool CheckTokenSize(string tokStream, int rcnt)
		{
			return true;
		}

		public virtual void CheckToken(string LicTempInp, string tokinp, char tok)
		{
		}

		public virtual string CreateStringRepresentation(int targetLength)
		{
			return "";
		}
	}
}
