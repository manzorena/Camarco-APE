using System;
using System.Collections.Generic;
using System.Text;

namespace Camarco.Model
{
	public class ValidationException : Exception
	{
		public List<string> InnerErrors
		{
			get;
			private set;
		}

		public ValidationException(string message) : base(message)
		{
		}

		public ValidationException(List<string> errors)
		{
			this.InnerErrors = errors;
		}

		public new string ToString()
		{
			StringBuilder retval = new StringBuilder();
			retval.Append("[");
			foreach (string e in this.InnerErrors)
			{
				retval.Append("'" + e + "',");
			}
			if (retval.Length > 1)
			{
				retval.Remove(retval.Length - 1, 1);
			}
			retval.Append("]");
			return retval.ToString();
		}
	}
}
