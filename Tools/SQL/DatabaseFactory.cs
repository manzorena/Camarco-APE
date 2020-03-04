using System;
using System.Configuration;

namespace Camarco.Tools.SQL
{
	public static class DatabaseFactory
	{
		public static SqlDatabase CreateDatabase()
		{
			SqlDatabase result;
			try
			{
				result = DatabaseFactory.CreateDefault();
			}
			catch
			{
				throw new Exception("Agilis Data Factory: No hay disponible un Connection String");
			}
			return result;
		}

		public static SqlDatabase CreateDatabase(string ConnectionStringName)
		{
			SqlDatabase result;
			try
			{
				result = DatabaseFactory.CreateNamed(ConnectionStringName);
			}
			catch
			{
				throw new Exception("Agilis Data Factory: No hay disponible un Connection String");
			}
			return result;
		}

		public static SqlDatabase CreateDefault()
		{
			if (ConfigurationManager.ConnectionStrings.Count == 0)
			{
				throw new Exception("Agilis Data Factory: No hay Connection Strings en el Web.Config de la aplicacion.");
			}
			SqlDatabase result;
			if (ConfigurationManager.AppSettings["defaultConnectionString"] != null)
			{
				result = DatabaseFactory.CreateNamed(ConfigurationManager.AppSettings["defaultConnectionString"]);
			}
			else
			{
				foreach (ConnectionStringSettings cn in ConfigurationManager.ConnectionStrings)
				{
					if (cn.Name.ToLower().StartsWith("sql"))
					{
						result = DatabaseFactory.CreateNamed(cn.Name);
						return result;
					}
				}
				result = DatabaseFactory.CreateNamed(ConfigurationManager.ConnectionStrings[0].Name);
			}
			return result;
		}

		public static SqlDatabase CreateNamed(string ConnectionStringName)
		{
			if (string.IsNullOrEmpty(ConnectionStringName))
			{
				throw new Exception("Agilis Data Factory CreateNamed: El nombre del Connection String no puede ser NULL o vacio.");
			}
			if (ConfigurationManager.ConnectionStrings[ConnectionStringName] == null)
			{
				throw new Exception("Agilis Data Factory: No se encuentra un Connection String bajo el nombre de " + ConnectionStringName);
			}
			return new SqlDatabase(ConfigurationManager.ConnectionStrings[ConnectionStringName].ConnectionString);
		}
	}
}
