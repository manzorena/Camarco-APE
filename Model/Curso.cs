using Camarco.Tools.CRM;
using Camarco.Tools.SQL;
using Microsoft.Crm.Sdk;
using System;
using System.Data;

namespace Camarco.Model
{
	public class Curso
	{
		public string CursoID
		{
			get;
			set;
		}

		public Guid CampaignID
		{
			get;
			set;
		}

		public int ResourceID
		{
			get;
			set;
		}

		public Resource Resource
		{
			get;
			set;
		}

		public string TipoEvento
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public string Copete
		{
			get;
			set;
		}

		public string Docentes
		{
			get;
			set;
		}

		public string DisponibleEn
		{
			get;
			set;
		}

		public decimal Arancel
		{
			get;
			set;
		}

		public decimal CostoSocioBsAs
		{
			get;
			set;
		}

		public decimal CostoSocioInterior
		{
			get;
			set;
		}

		public decimal CostoNoSocio
		{
			get;
			set;
		}

		public decimal CostoEstudiante
		{
			get;
			set;
		}

		public decimal CostoColegio
		{
			get;
			set;
		}

		public DateTime CronogramaInicio
		{
			get;
			set;
		}

		public DateTime CronogramaFin
		{
			get;
			set;
		}

		public string Descripcion
		{
			get;
			set;
		}

		public string DiasSemanaCantidad
		{
			get;
			set;
		}

		public DateTime CronogramaHorarioInicio
		{
			get;
			set;
		}

		public DateTime CronogramaHorarioFin
		{
			get;
			set;
		}

		public string CronogramaStringHorarioInicio
		{
			get;
			set;
		}

		public string urlImagen
		{
			get;
			set;
		}

		public string CronogramaStringHorarioFin
		{
			get;
			set;
		}

		public int CronogramaClases
		{
			get;
			set;
		}

		public string Modalidad
		{
			get;
			set;
		}

		public string Duracion
		{
			get;
			set;
		}

		public string DirigidoA
		{
			get;
			set;
		}

		public string BrochureUrl
		{
			get;
			set;
		}

		public int ImagenID
		{
			get;
			set;
		}

        //PRUEBA
        public String PermiteInscripcion 
        { 
            get;
            set;
        }
        //FIN

		public Curso()
		{
			this.ImagenID = 0;
		}

		public Curso(string cid)
		{
			Guid idEvento = default(Guid);
			using (new CRMHelper())
			{
				DynamicEntity entity = CRMHelper.Retrieve(cid);
				this.TipoEvento = Curso.DevolverTextoPickList(entity, "msa_eventtype");
				this.Titulo = Curso.CompletarString(entity, "msa_eventname");
				this.Copete = Curso.CompletarString(entity, "msa_eventdetails");
				this.Docentes = Curso.CompletarString(entity, "new_docente1");

                //PRUEBA
                this.PermiteInscripcion = Curso.CompletarBoolCRM(entity, "msa_publisheventdetailsonweb");
				//FIN

                if (Curso.CompletarString(entity, "new_docente2") != "")
				{
					this.Docentes = this.Docentes + ", " + Curso.CompletarString(entity, "new_docente2");
				}
				if (Curso.CompletarString(entity, "new_docente3") != "")
				{
					this.Docentes = this.Docentes + ", " + Curso.CompletarString(entity, "new_docente3");
				}
				if (Curso.CompletarString(entity, "new_docente4") != "")
				{
					this.Docentes = this.Docentes + ", " + Curso.CompletarString(entity, "new_docente4");
				}
				if (Curso.CompletarString(entity, "new_docente5") != "")
				{
					this.Docentes = this.Docentes + ", " + Curso.CompletarString(entity, "new_docente5");
				}
				this.Descripcion = Curso.CompletarString(entity, "objective");
				this.DirigidoA = Curso.CompletarString(entity, "new_dirigidoa");
				this.DiasSemanaCantidad = Curso.CompletarString(entity, "new_diassemanacantidad");
				this.Modalidad = Curso.CompletarString(entity, "new_modalidad");
				this.DisponibleEn = Curso.DevolverTextoLookUp(entity, "new_delegacioncentralid");
				if (Curso.DevolverTextoLookUp(entity, "new_delegacion1id") != "")
				{
					this.DisponibleEn = this.DisponibleEn + ", " + Curso.DevolverTextoLookUp(entity, "new_delegacion1id");
				}
				if (Curso.DevolverTextoLookUp(entity, "new_delegacion2id") != "")
				{
					this.DisponibleEn = this.DisponibleEn + ", " + Curso.DevolverTextoLookUp(entity, "new_delegacion2id");
				}
				if (Curso.DevolverTextoLookUp(entity, "new_delegacion3id") != "")
				{
					this.DisponibleEn = this.DisponibleEn + ", " + Curso.DevolverTextoLookUp(entity, "new_delegacion3id");
				}
				if (Curso.DevolverTextoLookUp(entity, "new_delegacion4id") != "")
				{
					this.DisponibleEn = this.DisponibleEn + ", " + Curso.DevolverTextoLookUp(entity, "new_delegacion4id");
				}
				if (Curso.DevolverTextoLookUp(entity, "new_delegacion5id") != "")
				{
					this.DisponibleEn = this.DisponibleEn + ", " + Curso.DevolverTextoLookUp(entity, "new_delegacion5id");
				}
				try
				{
					this.CronogramaClases = ((entity["new_cantidaddeclases"] != null) ? ((CrmNumber)entity["new_cantidaddeclases"]).Value : 0);
				}
				catch (Exception)
				{
					this.CronogramaClases = 0;
				}
				this.Duracion = Curso.CompletarString(entity, "new_duracion");
				this.CampaignID = ((Key)entity["campaignid"]).Value;
				idEvento = ((Key)entity["campaignid"]).Value;
				this.Arancel = Curso.CompletarDecimalCRM(entity, "new_arancel");
				this.CostoSocioBsAs = Curso.CompletarDecimal(entity, "msa_costofadmission");
				this.CostoSocioInterior = Curso.CompletarDecimal(entity, "huddle_costosociointerior");
				this.CostoNoSocio = Curso.CompletarDecimal(entity, "huddle_costonosocio");
				this.CostoEstudiante = Curso.CompletarDecimal(entity, "new_costoestudiante");
				this.CostoColegio = Curso.CompletarDecimal(entity, "new_costocolegioprof");
				this.CronogramaInicio = Curso.CompletarDate(entity, "msa_startdatetime");
				this.CronogramaFin = Curso.CompletarDate(entity, "msa_enddatetime");
				this.CronogramaStringHorarioInicio = Curso.CompletarString(entity, "huddle_horarioinicio");
				this.CronogramaStringHorarioFin = Curso.CompletarString(entity, "huddle_horariofin");
				this.BrochureUrl = Curso.CompletarString(entity, "msa_eventbrochureurl");
				this.urlImagen = Curso.CompletarString(entity, "new_urlimagen");
				if (this.urlImagen == "")
				{
					this.urlImagen = "/Content/CSS/Front/imagenes/Curso-Empty.jpg";
				}
				this.CursoID = cid;
			}
		}

		public static string DevolverTextoLookUp(DynamicEntity entity, string columna)
		{
			string result;
			try
			{
				result = ((entity[columna] != null) ? ((Lookup)entity[columna]).name : "");
			}
			catch (Exception)
			{
				result = "";
			}
			return result;
		}

		public static string DevolverTextoPickList(DynamicEntity entity, string columna)
		{
			string result;
			try
			{
				result = ((entity[columna] != null) ? ((Picklist)entity[columna]).name : "");
			}
			catch (Exception)
			{
				result = "";
			}
			return result;
		}

		public static string CompletarString(DynamicEntity entity, string columna)
		{
			string result;
			try
			{
				result = ((entity[columna] != null) ? entity[columna].ToString() : "");
			}
			catch (Exception)
			{
				result = "";
			}
			return result;
		}

		public static string CompletarCustomer(DynamicEntity entity, string columna)
		{
			string result;
			try
			{
				result = ((entity[columna] != null) ? ((Customer)entity[columna]).Value.ToString() : "");
			}
			catch (Exception)
			{
				result = "";
			}
			return result;
		}

		public static decimal CompletarDecimal(DynamicEntity entity, string columna)
		{
			decimal result;
			try
			{
				result = ((entity[columna] != null) ? Convert.ToDecimal(entity[columna]) : 0m);
			}
			catch (Exception)
			{
				result = 0m;
			}
			return result;
		}

		public static decimal CompletarDecimalCRM(DynamicEntity entity, string columna)
		{
			decimal result;
			try
			{
				result = ((entity[columna] != null) ? ((CrmDecimal)entity[columna]).Value : 0m);
			}
			catch (Exception)
			{
				result = 0m;
			}
			return result;
		}

		public static decimal CompletarNumberCRM(DynamicEntity entity, string columna)
		{
			decimal result;
			try
			{
				result = ((entity[columna] != null) ? ((CrmNumber)entity[columna]).Value : 0);
			}
			catch (Exception)
			{
				result = 0m;
			}
			return result;
		}

		public static string CompletarBoolCRM(DynamicEntity entity, string columna)
		{
			string result;
			try
			{
				result = ((entity[columna] != null) ? ((CrmBoolean)entity[columna]).Value.ToString() : "False");
			}
			catch (Exception)
			{
				result = "False";
			}
			return result;
		}

		public static DateTime CompletarDate(DynamicEntity entity, string columna)
		{
			DateTime result;
			try
			{
				result = ((entity[columna] != null) ? Convert.ToDateTime(((CrmDateTime)entity[columna]).Value) : DateTime.Today);
			}
			catch (Exception)
			{
				result = DateTime.Today;
			}
			return result;
		}

		public void Save()
		{
			using (DBHelper dbHelper = new DBHelper())
			{
				if (this.CursoID == "")
				{
					this.CursoID = Convert.ToString(dbHelper.RunSPReturnInteger("Curso_Save", true, new customParameter[]
					{
						dbHelper.MP("@CampaignID", SqlDbType.UniqueIdentifier, this.CampaignID),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Copete", SqlDbType.VarChar, this.Copete),
						dbHelper.MP("@Docentes", SqlDbType.VarChar, this.Docentes),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@DiasSemanaCantidad", SqlDbType.VarChar, this.DiasSemanaCantidad),
						dbHelper.MP("@Modalidad", SqlDbType.VarChar, this.Modalidad),
						dbHelper.MP("@DirigidoA", SqlDbType.VarChar, this.DirigidoA),
						dbHelper.MP("@CostoSocioBsAs", SqlDbType.SmallMoney, this.CostoSocioBsAs),
						dbHelper.MP("@CostoSocioInterior", SqlDbType.SmallMoney, this.CostoSocioInterior),
						dbHelper.MP("@CostoNoSocio", SqlDbType.SmallMoney, this.CostoNoSocio),
						dbHelper.MP("@CronogramaInicio", SqlDbType.SmallDateTime, this.CronogramaInicio),
						dbHelper.MP("@CronogramaFin", SqlDbType.SmallDateTime, this.CronogramaFin),
						dbHelper.MP("@CronogramaHorarioInicio", SqlDbType.SmallDateTime, this.CronogramaHorarioInicio),
						dbHelper.MP("@CronogramaHorarioFin", SqlDbType.SmallDateTime, this.CronogramaHorarioFin),
						dbHelper.MP("@CronogramaClases", SqlDbType.Int, this.CronogramaClases),
						dbHelper.MP("@Duracion", SqlDbType.VarChar, this.Duracion),
						dbHelper.MP("@BrochureUrl", SqlDbType.VarChar, this.BrochureUrl),
						dbHelper.MP("@ImagenID", SqlDbType.Int, this.ImagenID)
					}));
				}
				else
				{
					dbHelper.RunSP("Curso_Update", true, new customParameter[]
					{
						dbHelper.MP("@CursoID", SqlDbType.Int, this.CursoID),
						dbHelper.MP("@CampaignID", SqlDbType.UniqueIdentifier, this.CampaignID),
						dbHelper.MP("@ResourceID", SqlDbType.Int, this.ResourceID),
						dbHelper.MP("@Titulo", SqlDbType.VarChar, this.Titulo),
						dbHelper.MP("@Copete", SqlDbType.VarChar, this.Copete),
						dbHelper.MP("@Docentes", SqlDbType.VarChar, this.Docentes),
						dbHelper.MP("@Descripcion", SqlDbType.VarChar, this.Descripcion),
						dbHelper.MP("@DiasSemanaCantidad", SqlDbType.VarChar, this.DiasSemanaCantidad),
						dbHelper.MP("@Modalidad", SqlDbType.VarChar, this.Modalidad),
						dbHelper.MP("@DirigidoA", SqlDbType.VarChar, this.DirigidoA),
						dbHelper.MP("@CostoSocioBsAs", SqlDbType.SmallMoney, this.CostoSocioBsAs),
						dbHelper.MP("@CostoSocioInterior", SqlDbType.SmallMoney, this.CostoSocioInterior),
						dbHelper.MP("@CostoNoSocio", SqlDbType.SmallMoney, this.CostoNoSocio),
						dbHelper.MP("@CronogramaInicio", SqlDbType.SmallDateTime, this.CronogramaInicio),
						dbHelper.MP("@CronogramaFin", SqlDbType.SmallDateTime, this.CronogramaFin),
						dbHelper.MP("@CronogramaHorarioInicio", SqlDbType.SmallDateTime, this.CronogramaHorarioInicio),
						dbHelper.MP("@CronogramaHorarioFin", SqlDbType.SmallDateTime, this.CronogramaHorarioFin),
						dbHelper.MP("@CronogramaClases", SqlDbType.Int, this.CronogramaClases),
						dbHelper.MP("@Duracion", SqlDbType.VarChar, this.Duracion),
						dbHelper.MP("@BrochureUrl", SqlDbType.VarChar, this.BrochureUrl),
						dbHelper.MP("@ImagenID", SqlDbType.Int, this.ImagenID)
					});
				}
			}
		}
	}
}
