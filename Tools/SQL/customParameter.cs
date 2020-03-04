using System;
using System.Data;

namespace Camarco.Tools.SQL
{
	public struct customParameter
	{
		public string name;

		public SqlDbType type;

		public object value;
	}
}
