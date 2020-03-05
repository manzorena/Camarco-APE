using Camarco.Tools.CRM;
using Camarco.Tools.SQL;
using Microsoft.Crm.Sdk;
using Microsoft.Crm.SdkTypeProxy;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class Cursos
	{
		public static List<Curso> GetProximos(int pagina)
		{
			List<Curso> result;
			using (new CRMHelper())
			{
				RetrieveMultipleResponse respuestas = CRMHelper.GetProximosCinco(pagina);
				List<Curso> retval = new List<Curso>();
				using (List<BusinessEntity>.Enumerator enumerator = respuestas.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						retval.Add(new Curso(((Key)item["campaignid"]).Value.ToString()));
					}
				}
				result = retval;
			}
			return result;
		}

		public static List<Curso> GetPasadosCRM(int cantidad)
		{
			List<Curso> result;
			using (new CRMHelper())
			{
				RetrieveMultipleResponse respuestas = CRMHelper.MonstrarTodos(cantidad);
				List<Curso> retval = new List<Curso>();
				using (List<BusinessEntity>.Enumerator enumerator = respuestas.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						retval.Add(new Curso(((Key)item["campaignid"]).Value.ToString()));
					}
				}
				result = retval;
			}
			return result;
		}

		public static List<Curso> GetProximosFiltered(string query)
		{
			List<Curso> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Curso> retval = new List<Curso>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Cursos_ProximosFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Query", SqlDbType.VarChar, query)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Curso(dR["CursoID"].ToString()));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<Curso> GetPasadosFiltered(string query)
		{
			List<Curso> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Curso> retval = new List<Curso>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Cursos_PasadosFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Query", SqlDbType.VarChar, query)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Curso(dR["CursoID"].ToString()));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static Curso GetByCRMCampaignId(string CampaignId)
		{
			return new Curso(CampaignId);
		}

		public static Curso GetByCRMDNI(string dni)
		{
			return new Curso(dni);
		}

		public static Curso GetByResource(int ResourceID)
		{
			Curso result;
			using (DBHelper dbHelper = new DBHelper())
			{
				int CursoID = dbHelper.RunSPReturnInteger("Curso_GetByResource", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, ResourceID.ToString())
				});
				if (CursoID == -1)
				{
					result = null;
				}
				else
				{
					DataSet ds = dbHelper.RunSPReturnDataSet("Curso_GetByID", false, new customParameter[]
					{
						dbHelper.MP("@CursoID", SqlDbType.Int, CursoID.ToString())
					});
					DataRow dR = ds.Tables[0].Rows[0];
					string cursoID2 = dR["CampaignID"].ToString();
					Curso d = new Curso(cursoID2.ToString());
					result = d;
				}
			}
			return result;
		}

		public static void ClearCursos()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				dbHelper.RunSP("Cursos_Clear", true, new customParameter[0]);
			}
		}

		public static Curso GetByCampaign(Guid campaign)
		{
			Curso result;
			using (new CRMHelper())
			{
				DynamicEntity entidad = CRMHelper.Retrieve(campaign.ToString());
				Curso d = new Curso(((Key)entidad["campaignid"]).Value.ToString());
				result = d;
			}
			return result;
		}
	}
}
