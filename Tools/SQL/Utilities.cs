using System;
using System.Text;
using System.Xml;

namespace Camarco.Tools.SQL
{
	public static class Utilities
	{
		public static string ReadXMLReaderToEnd(XmlReader xml)
		{
			StringBuilder strB = new StringBuilder();
			xml.Read();
			while (xml.IsStartElement())
			{
				strB.Append(xml.ReadOuterXml());
			}
			xml.Close();
			xml = null;
			return strB.ToString();
		}
	}
}
