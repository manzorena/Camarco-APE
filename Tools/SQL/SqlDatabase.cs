using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Xml;

namespace Camarco.Tools.SQL
{
    public static class DatabaseFactory
    {
        public static SqlDatabase CreateDatabase()
        {
            try
            {
                return CreateDefault();
            }
            catch
            {
                throw new Exception("Agilis Data Factory: No hay disponible un Connection String");
            }
        }

        public static SqlDatabase CreateDatabase(string ConnectionStringName)
        {
            try
            {
                return CreateNamed(ConnectionStringName);
            }
            catch
            {
                throw new Exception("Agilis Data Factory: No hay disponible un Connection String");
            }
        }

        /// <summary>
        /// Busca el connectionstring definido en defaultConnectionString, si no existe, busca el connectionstring con un nombre que empiece con "sql", si no lo encuentra, toma el primero definido en la coleccion de connectionstrings
        /// </summary>
        /// <returns></returns>
        public static SqlDatabase CreateDefault()
        {
            if (System.Configuration.ConfigurationManager.ConnectionStrings.Count == 0)
                throw new Exception("Agilis Data Factory: No hay Connection Strings en el Web.Config de la aplicacion.");
            if (System.Configuration.ConfigurationManager.AppSettings["defaultConnectionString"] != null)
                return CreateNamed(System.Configuration.ConfigurationManager.AppSettings["defaultConnectionString"]);
            foreach (System.Configuration.ConnectionStringSettings cn in System.Configuration.ConfigurationManager.ConnectionStrings)
            {
                if (cn.Name.ToLower().StartsWith("sql"))
                    return CreateNamed(cn.Name);
            }
            return CreateNamed(System.Configuration.ConfigurationManager.ConnectionStrings[0].Name);
        }

        /// <summary>
        /// Crea un SqlDatabase en base al nombre de un Connection String.
        /// </summary>
        /// <param name="ConnectionStringName"></param>
        /// <returns></returns>
        public static SqlDatabase CreateNamed(string ConnectionStringName)
        {
            if (string.IsNullOrEmpty(ConnectionStringName)) throw new Exception("Agilis Data Factory CreateNamed: El nombre del Connection String no puede ser NULL o vacio.");
            if (System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringName] == null)
                throw new Exception("Agilis Data Factory: No se encuentra un Connection String bajo el nombre de " + ConnectionStringName);
            return new SqlDatabase(System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringName].ConnectionString);
        }
    }

	public class SqlDatabase
	{
		private string _cn = "";

		private DbProviderFactory _providerFactory = SqlClientFactory.Instance;

		public SqlDatabase(string ConnectionString)
		{
			this._cn = ConnectionString;
		}

		public DbCommand GetStoredProcCommand(string StoredProcedureName)
		{
			if (string.IsNullOrEmpty(StoredProcedureName))
			{
				throw new Exception("Agilis Data Factory GetStoredProcCommand: El nombre del Stored Procedure no puede ser NULL o vacio.");
			}
			return this.CreateCommand(CommandType.StoredProcedure, StoredProcedureName);
		}

		public DbCommand GetSqlStringCommand(string SqlString)
		{
			if (string.IsNullOrEmpty(SqlString))
			{
				throw new Exception("Agilis Data Factory GetSqlStringCommand: El SqlString no puede ser NULL o vacio.");
			}
			return this.CreateCommand(CommandType.Text, SqlString);
		}

		public DbConnection CreateConnection()
		{
			DbConnection newConnection = this._providerFactory.CreateConnection();
			newConnection.ConnectionString = this._cn;
			return newConnection;
		}

		public DbCommand CreateCommand(CommandType commandType, string commandText)
		{
			DbCommand command = this._providerFactory.CreateCommand();
			command.CommandType = commandType;
			command.CommandText = commandText;
			return command;
		}

		public void AddInParameter(DbCommand dbCommand, string Name, SqlDbType dbType, object Value)
		{
			dbCommand.Parameters.Add(this.CreateParameter(Name, dbType, Value, 0, ParameterDirection.Input));
		}

		public void AddOutParameter(DbCommand dbCommand, string Name, SqlDbType dbType, int Size)
		{
			dbCommand.Parameters.Add(this.CreateParameter(Name, dbType, string.Empty, Size, ParameterDirection.Output));
		}

		private SqlParameter CreateParameter(string Name, SqlDbType dbType, object Value, int Size, ParameterDirection direction)
		{
			SqlParameter dbParameter = (SqlParameter)this._providerFactory.CreateParameter();
			dbParameter.ParameterName = Name;
			if (Value != null)
			{
				dbParameter.Value = Value;
			}
			dbParameter.SqlDbType = dbType;
			dbParameter.Direction = direction;
			if (Size != 0)
			{
				dbParameter.Size = Size;
			}
			return dbParameter;
		}

		public object GetParameterValue(DbCommand dbCommand, string ParameterName)
		{
			if (dbCommand.Parameters[ParameterName].Direction != ParameterDirection.Output && dbCommand.Parameters[ParameterName].Direction != ParameterDirection.InputOutput)
			{
				throw new Exception("Agilis Data Factory GetParameterValue: El parametro no es de Salida.");
			}
			return dbCommand.Parameters[ParameterName].Value;
		}

		public void LoadDataSet(DbCommand dbCommand, DataSet dataSet, string TableName)
		{
			using (DbDataAdapter adapter = this._providerFactory.CreateDataAdapter())
			{
				((IDbDataAdapter)adapter).SelectCommand = dbCommand;
				DateTime startTime = DateTime.Now;
				adapter.TableMappings.Add("Table", TableName);
				adapter.Fill(dataSet);
			}
		}

		public void ExecuteNonQuery(DbCommand dbCommand)
		{
			if (dbCommand.Connection == null)
			{
				using (DbConnection aConn = this.CreateConnection())
				{
					aConn.Open();
					dbCommand.Connection = aConn;
					dbCommand.ExecuteNonQuery();
				}
			}
			else
			{
				dbCommand.ExecuteNonQuery();
			}
		}

		public void ExecuteNonQuery(DbCommand dbCommand, DbTransaction transaction)
		{
			if (dbCommand.Connection == null)
			{
				dbCommand.Transaction = transaction;
				dbCommand.Connection = transaction.Connection;
			}
			else
			{
				dbCommand.Transaction = transaction;
			}
			dbCommand.ExecuteNonQuery();
		}

		public XmlReader ExecuteXmlReader(SqlCommand dbCommand, DbTransaction transaction)
		{
			if (dbCommand.Connection == null)
			{
				dbCommand.Transaction = (SqlTransaction)transaction;
				dbCommand.Connection = ((SqlTransaction)transaction).Connection;
			}
			else
			{
				dbCommand.Transaction = (SqlTransaction)transaction;
			}
			return dbCommand.ExecuteXmlReader();
		}
	}
}
