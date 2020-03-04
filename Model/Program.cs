using Microsoft.Crm.Sdk;
using Microsoft.Crm.Sdk.Query;
using Microsoft.Crm.SdkTypeProxy;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Xml;

namespace BorrarMAsivoConsolaCRM
{
	internal class Program
	{
		private static CrmService oService;

		private static XmlDocument oConfigDoc = new XmlDocument();

		private static void Main(string[] args)
		{
			try
			{
				if (Program.ReadConfig())
				{
					XmlNodeList oEntityNodes = Program.oConfigDoc.SelectNodes("//Entities/Entity");
					foreach (XmlNode oEntityNode in oEntityNodes)
					{
						string sEntityName = oEntityNode.InnerText;
						Program.RetrieveByUsingRetrieveMultipleRequest(sEntityName);
					}
				}
				Console.WriteLine("Bulk Deletion Jobs Created.");
				Console.ReadLine();
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				Console.ReadLine();
			}
		}

		private static bool ReadConfig()
		{
			bool result;
			try
			{
				Console.WriteLine("Reading configuration from file.");
				Program.oConfigDoc.Load("Config.xml");
				XmlNode oConfigNode = Program.oConfigDoc.SelectSingleNode("//CrmServer");
				string sServiceUrl = oConfigNode.Attributes["ServiceUrl"].Value;
				string sOrganization = oConfigNode.Attributes["Organization"].Value;
				Console.WriteLine("Setting up CrmService.");
				Program.oService = new CrmService();
				CrmAuthenticationToken token = new CrmAuthenticationToken();
				token.AuthenticationType = 0;
				token.OrganizationName = sOrganization;
				Program.oService.Url = sServiceUrl;
				Program.oService.CrmAuthenticationTokenValue = token;
				Program.oService.PreAuthenticate = true;
				Program.oService.Credentials = CredentialCache.DefaultCredentials;
				result = true;
			}
			catch (Exception ex)
			{
				string sMsg = "Error reading configuration: " + ex.Message;
				throw new Exception(sMsg, ex);
			}
			return result;
		}

		private static void DeleteEntity(string sEntityName)
		{
			try
			{
				Console.WriteLine("Creating bulk deletion job for entity: " + sEntityName);
				QueryExpression qry = new QueryExpression();
				qry.EntityName = sEntityName;
				qry.ColumnSet = new AllColumns();
				BulkDeleteRequest request = new BulkDeleteRequest();
				request.JobName = "Delete all " + sEntityName + " records";
				request.QuerySet = new QueryBase[]
				{
					qry
				};
				request.SendEmailNotification = false;
				request.ToRecipients = new Guid[0];
				request.CCRecipients = new Guid[0];
				request.RecurrencePattern = string.Empty;
				request.StartDateTime = new CrmDateTime();
				request.StartDateTime.Value = DateTime.Now.ToString();
				Console.WriteLine("Valor de la fecha");
				BulkDeleteResponse response = (BulkDeleteResponse)Program.oService.Execute(request);
				Console.WriteLine("Ejecución de la consulta");
				Console.WriteLine("Job Id: " + response.JobId.ToString());
			}
			catch (Exception ex)
			{
				string sMsg = "Error creating deletion job for " + sEntityName + ": " + ex.Message;
				throw new Exception(sMsg, ex);
			}
		}

		private static void Delete(string sEntityName)
		{
			try
			{
				QueryByAttribute query = new QueryByAttribute();
				query.Attributes = new string[]
				{
					"new_name"
				};
				query.ColumnSet = new AllColumns();
				query.EntityName = sEntityName;
				RetrieveMultipleRequest request = new RetrieveMultipleRequest();
				request.Query = query;
				request.ReturnDynamicEntities = true;
				List<BusinessEntity> abcs = ((RetrieveMultipleResponse)Program.oService.Execute(request)).BusinessEntityCollection.BusinessEntities;
				using (List<BusinessEntity>.Enumerator enumerator = abcs.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity de = (DynamicEntity)enumerator.Current;
						Guid nombre = ((Key)de["new_name"]).Value;
					}
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.ToString());
			}
		}

		private static void RetrieveByUsingRetrieveMultipleRequest(string entidad)
		{
			int total = 0;
			QueryExpression query = new QueryExpression();
			query.EntityName = entidad;
			query.PageInfo = new PagingInfo();
			query.PageInfo.Count = 200;
			query.PageInfo.PageNumber = 1;
			query.ColumnSet = new AllColumns();
			RetrieveMultipleRequest request = new RetrieveMultipleRequest();
			request.Query = query;
			request.ReturnDynamicEntities = true;
			RetrieveMultipleResponse response = (RetrieveMultipleResponse)Program.oService.Execute(request);
			Program.Log("Cantidad: " + response.BusinessEntityCollection.BusinessEntities.Count);
			int cantidad = 0;
			using (List<BusinessEntity>.Enumerator enumerator = response.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					string[] arrCols = new string[]
					{
						"msa_publisheventdetailsonweb",
						"campaignid"
					};
					ColumnSet cols = new ColumnSet(arrCols);
					string tipoEvento = ((Picklist)item["msa_eventtype"]).name;
					Guid idItem = new Guid(((Key)item["campaignid"]).Value.ToString());
					BusinessEntity resultado = Program.oService.Retrieve(entidad, idItem, cols);
					cantidad++;
					total++;
				}
			}
			Program.Log(total + " de correos serían eliminados en total");
		}

		public static void Log(string logMessage)
		{
			using (StreamWriter sw = new StreamWriter("C:\\LogsCRM\\LogConsultaConsola - " + DateTime.Now.ToString("dd-MM-yyyy") + ".txt", true))
			{
				sw.Write("\r\nLog Entry : ");
				sw.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString());
				sw.WriteLine("{0}", logMessage);
				sw.WriteLine("-------------------------------");
			}
		}
	}
}
