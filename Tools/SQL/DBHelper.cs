using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;
using System.Xml;

namespace Camarco.Tools.SQL
{
    public struct customParameter
    {
        public string name;
        public SqlDbType type;
        public object value;
    };
	public class DBHelper : IDisposable
	{
		public DataSet RunSPReturnDataSet(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			DataSet result;
			if (usesTransaction)
			{
				result = this.RunSPReturnDataSetWithTransaction(cSPName, commandParameters);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
				DataSet retval = new DataSet();
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						this.AddParameters(db, dbCommand, commandParameters);
						dbCommand.Connection = connection;
						retval.Locale = CultureInfo.InvariantCulture;
						db.LoadDataSet(dbCommand, retval, "Table");
						result = retval;
					}
					catch
					{
						throw;
					}
					finally
					{
						dbCommand.Dispose();
						connection.Close();
					}
				}
			}
			return result;
		}

		private DataSet RunSPReturnDataSetWithTransaction(string cSPName, params customParameter[] commandParameters)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
			DataSet result;
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					DataSet retval = null;
					this.AddParameters(db, dbCommand, commandParameters);
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					retval.Locale = CultureInfo.InvariantCulture;
					db.LoadDataSet(dbCommand, retval, "Table");
					transaction.Commit();
					result = retval;
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
			return result;
		}

		public int RunSPReturnInteger(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			int result;
			if (usesTransaction)
			{
				result = this.RunSPReturnIntegerWithTransaction(cSPName, commandParameters);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						this.AddParameters(db, dbCommand, commandParameters);
						db.AddOutParameter(dbCommand, "@retval", SqlDbType.Int, 4);
						dbCommand.Connection = connection;
						dbCommand.ExecuteNonQuery();
						int retval = int.Parse(db.GetParameterValue(dbCommand, "@retval").ToString());
						result = retval;
					}
					catch
					{
						throw;
					}
					finally
					{
						dbCommand.Dispose();
						connection.Close();
					}
				}
			}
			return result;
		}

		private int RunSPReturnIntegerWithTransaction(string cSPName, params customParameter[] commandParameters)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
			int result;
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					this.AddParameters(db, dbCommand, commandParameters);
					db.AddOutParameter(dbCommand, "@retval", SqlDbType.Int, 4);
					dbCommand.ExecuteNonQuery();
					int retval = int.Parse(db.GetParameterValue(dbCommand, "@retval").ToString());
					transaction.Commit();
					result = retval;
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
			return result;
		}

		private string RunSPReturnReadedXmlReaderWithTransaction(string cSPName, string strConnection, params customParameter[] commandParameters)
		{
			StringBuilder strB = new StringBuilder();
			SqlDatabase db;
			if (strConnection != "")
			{
				db = DatabaseFactory.CreateDatabase(strConnection);
			}
			else
			{
				db = DatabaseFactory.CreateDatabase();
			}
			DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					this.AddParameters(db, dbCommand, commandParameters);
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					SqlCommand sqlCommand = dbCommand as SqlCommand;
					XmlReader xml = sqlCommand.ExecuteXmlReader();
					transaction.Commit();
					xml.Read();
					while (xml.IsStartElement())
					{
						strB.Append(xml.ReadOuterXml());
					}
					xml.Close();
				}
				catch (Exception ex)
				{
					if (ex.InnerException == null || !(ex.InnerException.GetType().ToString() == "System.Data.SqlTypes.SqlNullValueException"))
					{
						throw ex;
					}
					strB.Append("");
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
			return strB.ToString();
		}

		public string RunSPReturnReadedXmlReader(string cSPName, bool usesTransaction, string strConnection, params customParameter[] commandParameters)
		{
			string result;
			if (usesTransaction)
			{
				result = this.RunSPReturnReadedXmlReaderWithTransaction(cSPName, strConnection, commandParameters);
			}
			else
			{
				StringBuilder strB = new StringBuilder();
				SqlDatabase db;
				if (strConnection != "")
				{
					db = DatabaseFactory.CreateDatabase(strConnection);
				}
				else
				{
					db = DatabaseFactory.CreateDatabase();
				}
				DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						this.AddParameters(db, dbCommand, commandParameters);
						dbCommand.Connection = connection;
						SqlCommand sqlCommand = dbCommand as SqlCommand;
						XmlReader xml = sqlCommand.ExecuteXmlReader();
						xml.Read();
						while (xml.IsStartElement())
						{
							strB.Append(xml.ReadOuterXml());
						}
						xml.Close();
					}
					catch (Exception ex)
					{
						if (ex.InnerException == null || !(ex.InnerException.GetType().ToString() == "System.Data.SqlTypes.SqlNullValueException"))
						{
							throw ex;
						}
						strB.Append("");
					}
					finally
					{
						dbCommand.Dispose();
						connection.Close();
					}
				}
				result = strB.ToString();
			}
			return result;
		}

		public string RunSPReturnReadedXmlReader(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			return this.RunSPReturnReadedXmlReader(cSPName, usesTransaction, "", commandParameters);
		}

		public void RunSP(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			if (usesTransaction)
			{
				this.RunSPWithTransaction(cSPName, commandParameters);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						this.AddParameters(db, dbCommand, commandParameters);
						dbCommand.Connection = connection;
						dbCommand.ExecuteNonQuery();
					}
					catch
					{
						throw;
					}
					finally
					{
						dbCommand.Dispose();
						connection.Close();
					}
				}
			}
		}

		private void RunSPWithTransaction(string cSPName, params customParameter[] commandParameters)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					this.AddParameters(db, dbCommand, commandParameters);
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					dbCommand.ExecuteNonQuery();
					transaction.Commit();
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
		}

		public string RunSPReturnString(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			string result;
			if (usesTransaction)
			{
				result = this.RunSPReturnStringWithTransaction(cSPName, commandParameters);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					this.AddParameters(db, dbCommand, commandParameters);
					db.AddOutParameter(dbCommand, "@retval", SqlDbType.VarChar, 8000);
					try
					{
						dbCommand.Connection = connection;
						dbCommand.ExecuteNonQuery();
						result = db.GetParameterValue(dbCommand, "@retval").ToString();
					}
					catch
					{
						throw;
					}
					finally
					{
						dbCommand.Dispose();
						connection.Close();
					}
				}
			}
			return result;
		}

		private string RunSPReturnStringWithTransaction(string cSPName, params customParameter[] commandParameters)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetStoredProcCommand(cSPName);
			string result;
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					StringBuilder retval = new StringBuilder();
					this.AddParameters(db, dbCommand, commandParameters);
					db.AddOutParameter(dbCommand, "@retval", SqlDbType.VarChar, 8000);
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					dbCommand.ExecuteNonQuery();
					retval.Append(db.GetParameterValue(dbCommand, "@retval").ToString());
					transaction.Commit();
					result = retval.ToString();
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
			return result;
		}

		public XmlDocument RunSPReturnXmlDocument(string cSPName, bool usesTransaction, params customParameter[] commandParameters)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			SqlCommand dbCommand = (SqlCommand)db.GetStoredProcCommand(cSPName);
			XmlDocument result;
			using (SqlConnection connection = (SqlConnection)db.CreateConnection())
			{
				connection.Open();
				this.AddParameters(db, dbCommand, commandParameters);
				try
				{
					dbCommand.Connection = connection;
					XmlDocument retval = new XmlDocument();
					XmlReader reader = dbCommand.ExecuteXmlReader();
					if (reader.Read())
					{
						retval.Load(reader);
					}
					result = retval;
				}
				catch
				{
					throw;
				}
				finally
				{
					dbCommand.Dispose();
					connection.Close();
				}
			}
			return result;
		}

		public void RunSQL(string sqlQuery, bool usesTransaction)
		{
			if (usesTransaction)
			{
				this.RunSQLWithTransaction(sqlQuery);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						dbCommand.Connection = connection;
						dbCommand.ExecuteNonQuery();
					}
					catch
					{
						throw;
					}
					finally
					{
						connection.Close();
					}
				}
			}
		}

		public void RunSQLWithTransaction(string sqlQuery)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					dbCommand.ExecuteNonQuery();
					transaction.Commit();
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					connection.Close();
				}
			}
		}

		public DataSet RunSQLReturnDataSet(string cSQLQuery, bool usesTransaction)
		{
			DataSet result;
			if (usesTransaction)
			{
				result = this.RunSQLReturnDataSetWithTransaction(cSQLQuery);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetSqlStringCommand(cSQLQuery);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						DataSet retval = new DataSet();
						dbCommand.Connection = connection;
						retval.Locale = CultureInfo.InvariantCulture;
						db.LoadDataSet(dbCommand, retval, "Table");
						result = retval;
					}
					catch
					{
						throw;
					}
					finally
					{
						connection.Close();
					}
				}
			}
			return result;
		}

		private DataSet RunSQLReturnDataSetWithTransaction(string cSQLQuery)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetSqlStringCommand(cSQLQuery);
			DataSet retval = null;
			DataSet result;
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					retval.Locale = CultureInfo.InvariantCulture;
					db.LoadDataSet(dbCommand, retval, "Table");
					transaction.Commit();
					result = retval;
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					connection.Close();
				}
			}
			return result;
		}

		public string RunSQLReturnString(string sqlQuery, bool usesTransaction)
		{
			string result;
			if (usesTransaction)
			{
				result = this.RunSQLReturnStringWithTransaction(sqlQuery);
			}
			else
			{
				SqlDatabase db = DatabaseFactory.CreateDatabase();
				DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						dbCommand.Connection = connection;
						result = dbCommand.ExecuteScalar().ToString();
					}
					catch
					{
						throw;
					}
					finally
					{
						connection.Close();
					}
				}
			}
			return result;
		}

		private string RunSQLReturnStringWithTransaction(string sqlQuery)
		{
			SqlDatabase db = DatabaseFactory.CreateDatabase();
			DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
			string result;
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					string retval = dbCommand.ExecuteScalar().ToString();
					transaction.Commit();
					result = retval;
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					connection.Close();
				}
			}
			return result;
		}

		private string RunSQLReturnReadedXmlReaderWithTransaction(string sqlQuery, string strConnection)
		{
			StringBuilder strB = new StringBuilder();
			SqlDatabase db;
			if (strConnection != "")
			{
				db = DatabaseFactory.CreateDatabase(strConnection);
			}
			else
			{
				db = DatabaseFactory.CreateDatabase();
			}
			using (DbConnection connection = db.CreateConnection())
			{
				connection.Open();
				DbTransaction transaction = connection.BeginTransaction();
				try
				{
					DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
					dbCommand.Connection = connection;
					dbCommand.Transaction = transaction;
					SqlCommand sqlCommand = dbCommand as SqlCommand;
					XmlReader xml = sqlCommand.ExecuteXmlReader();
					transaction.Commit();
					xml.Read();
					while (xml.IsStartElement())
					{
						strB.Append(xml.ReadOuterXml());
					}
					xml.Close();
				}
				catch
				{
					transaction.Rollback();
					throw;
				}
				finally
				{
					connection.Close();
				}
			}
			return strB.ToString();
		}

		public string RunSQLReturnReadedXmlReader(string sqlQuery, bool usesTransaction, string strConnection)
		{
			string result;
			if (usesTransaction)
			{
				result = this.RunSQLReturnReadedXmlReaderWithTransaction(sqlQuery, strConnection);
			}
			else
			{
				StringBuilder strB = new StringBuilder();
				SqlDatabase db;
				if (strConnection != "")
				{
					db = DatabaseFactory.CreateDatabase(strConnection);
				}
				else
				{
					db = DatabaseFactory.CreateDatabase();
				}
				using (DbConnection connection = db.CreateConnection())
				{
					connection.Open();
					try
					{
						DbCommand dbCommand = db.GetSqlStringCommand(sqlQuery);
						dbCommand.Connection = connection;
						SqlCommand sqlCommand = dbCommand as SqlCommand;
						XmlReader xml = sqlCommand.ExecuteXmlReader();
						xml.Read();
						while (xml.IsStartElement())
						{
							strB.Append(xml.ReadOuterXml());
						}
						xml.Close();
					}
					catch
					{
						throw;
					}
					finally
					{
						connection.Close();
					}
				}
				result = strB.ToString();
			}
			return result;
		}

		public string RunSQLReturnReadedXmlReader(string sqlQuery, bool usesTransaction)
		{
			return this.RunSQLReturnReadedXmlReader(sqlQuery, usesTransaction, "");
		}

		private void AddParameters(SqlDatabase db, DbCommand dbCommand, customParameter[] commandParameters)
		{
			for (int i = 0; i < commandParameters.Length; i++)
			{
				customParameter cP = commandParameters[i];
				db.AddInParameter(dbCommand, cP.name, cP.type, cP.value);
			}
		}

		public customParameter MP(string name, SqlDbType type, object value)
		{
			customParameter cp;
			cp.name = name;
			cp.type = type;
			cp.value = value;
			return cp;
		}

		void IDisposable.Dispose()
		{
			GC.SuppressFinalize(this);
		}
	}
}
