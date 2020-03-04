using Microsoft.Crm.Sdk;
using Microsoft.Crm.Sdk.Query;
using Microsoft.Crm.SdkTypeProxy;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;

namespace Camarco.Tools.CRM
{
	public class CRMHelper : IDisposable
	{
		public static CrmService InicializarServicioCRM()
		{
			CrmService oService = new CrmService();
            string sServiceUrl = System.Configuration.ConfigurationManager.AppSettings["sServiceUrl"];
			//string sServiceUrl = "http://crm:5555/mscrmservices/2007/crmservice.asmx"; //Descomentar.- Charlyzard
            //string sServiceUrl = "http://192.168.50.12:5555/mscrmservices/2007/crmservice.asmx";
			string sOrganization = "CAC-CRM";
			CrmAuthenticationToken token = new CrmAuthenticationToken();
			token.AuthenticationType = 0;
			token.OrganizationName = sOrganization;
			oService.Url = sServiceUrl;
			oService.CrmAuthenticationTokenValue = token;
			oService.PreAuthenticate = true;
			oService.Credentials = CredentialCache.DefaultCredentials;
			return oService;
		}

		void IDisposable.Dispose()
		{
			GC.SuppressFinalize(this);
		}

		public static RetrieveMultipleResponse MonstrarTodos(int cantidad)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.campaign.ToString();
			query2.ColumnSet = cols;
			OrderExpression oe = new OrderExpression();
			oe.AttributeName = "msa_startdatetime";
			oe.OrderType = OrderType.Descending;
			query2.Orders.Add(oe);
			query2.PageInfo.Count = cantidad;
			query2.PageInfo.PageNumber = 1;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("msa_startdatetime", ConditionOperator.OnOrBefore, DateTime.Now.AddDays(-1.0).Date.ToString("yyyy-MM-dd"));
			query2.Criteria.AddCondition("msa_publisheventdetailsonweb", ConditionOperator.Equal, true);
			return (RetrieveMultipleResponse)oService.Execute(new RetrieveMultipleRequest
			{
				Query = query2,
				ReturnDynamicEntities = true
			});
		}

		public static void Particular()
		{
			int cantidad = 2000;
			RetrieveMultipleResponse response = CRMHelper.MonstrarTodos(cantidad);
			Console.WriteLine("");
			Console.WriteLine("Escriba el nombre de la campaña");
			Console.WriteLine("");
			string consulta = Console.ReadLine();
			using (List<BusinessEntity>.Enumerator enumerator = response.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					if (consulta == item["name"].ToString())
					{
						Console.WriteLine("");
						Console.WriteLine("Codigo de campaña: " + ((Key)item["campaignid"]).Value.ToString());
						CrmDateTime fechaIni = (CrmDateTime)item["msa_startdatetime"];
						CrmDateTime fechaFin = (CrmDateTime)item["msa_enddatetime"];
						Console.WriteLine("");
						Console.WriteLine("Fecha de inicio: " + fechaIni.date);
						Console.WriteLine("");
						Console.WriteLine("Fecha de finalizacion: " + fechaIni.date);
						Console.WriteLine("");
					}
				}
			}
			Console.ReadLine();
		}

		public static void Rango()
		{
			int cantidad = 2000;
			RetrieveMultipleResponse response = CRMHelper.MonstrarTodos(cantidad);
			Console.WriteLine("");
			Console.WriteLine("Ingrese fecha de inicio (dd/mm/aaaa): ");
			Console.WriteLine("");
			DateTime fechaIniR = Convert.ToDateTime(Console.ReadLine());
			Console.WriteLine("");
			Console.WriteLine("Ingrese fecha de finalizacion (dd/mm/aaaa): ");
			Console.WriteLine("");
			DateTime fechaFinR = Convert.ToDateTime(Console.ReadLine());
			Console.WriteLine("");
			Console.WriteLine("Campañas: ");
			Console.WriteLine("");
			using (List<BusinessEntity>.Enumerator enumerator = response.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					DynamicEntity item = (DynamicEntity)enumerator.Current;
					try
					{
						CrmDateTime fechaInic = (CrmDateTime)item["msa_startdatetime"];
						DateTime fechaIniConverted = Convert.ToDateTime(fechaInic.Value);
						if (fechaIniR < fechaIniConverted && fechaFinR > fechaIniConverted)
						{
							Console.WriteLine(item["name"].ToString());
							Console.WriteLine("");
						}
					}
					catch (KeyNotFoundException)
					{
					}
					catch (Exception)
					{
					}
				}
			}
			Console.ReadLine();
		}

		public static DynamicEntity Retrieve(string cid)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			TargetRetrieveDynamic targetRetrieve = new TargetRetrieveDynamic();
			targetRetrieve.EntityId = new Guid(cid);
			targetRetrieve.EntityName = EntityName.campaign.ToString();
			RetrieveResponse retrieved = (RetrieveResponse)oService.Execute(new RetrieveRequest
			{
				Target = targetRetrieve,
				ColumnSet = new AllColumns(),
				ReturnDynamicEntities = true
			});
			return (DynamicEntity)retrieved.BusinessEntity;
		}

		public static RetrieveMultipleResponse RetrieveLook(string entidad)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = entidad;
			query2.ColumnSet = cols;
			return (RetrieveMultipleResponse)oService.Execute(new RetrieveMultipleRequest
			{
				Query = query2,
				ReturnDynamicEntities = true
			});
		}

		public static void TodasRespuestasCampanas()
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.campaignresponse.ToString();
			query2.ColumnSet = cols;
			query2.PageInfo = new PagingInfo();
			query2.PageInfo.Count = 500;
			query2.PageInfo.PageNumber = 1;
			RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(new RetrieveMultipleRequest
			{
				Query = query2
			});
			int cantidad = 1;
			using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					campaignresponse item = (campaignresponse)enumerator.Current;
					Console.WriteLine("");
					Console.WriteLine(cantidad.ToString() + "-");
					Console.WriteLine("");
					Console.WriteLine(item.regardingobjectid.name);
					Console.WriteLine(item.responsecode.name);
					Console.WriteLine(item.promotioncodename);
					Console.WriteLine("");
					cantidad++;
					Console.ReadLine();
				}
			}
		}

		public static void RespuestaPorCampaña()
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			string id = "bc16130a-151c-e411-9f30-00155d00f21d";
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.campaignresponse.ToString();
			query2.ColumnSet = cols;
			query2.PageInfo = new PagingInfo();
			query2.PageInfo.Count = 500;
			query2.PageInfo.PageNumber = 1;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("regardingobjectid", ConditionOperator.Equal, id);
			RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(new RetrieveMultipleRequest
			{
				Query = query2
			});
			int cantidad = 1;
			using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					campaignresponse item = (campaignresponse)enumerator.Current;
					Console.WriteLine("");
					Console.WriteLine(cantidad.ToString() + "-");
					Console.WriteLine("");
					Console.WriteLine(item.regardingobjectid.name);
					Console.WriteLine(item.responsecode.name);
					Console.WriteLine(item.promotioncodename);
					Console.WriteLine("");
					cantidad++;
					Console.ReadLine();
				}
			}
		}

		public static string AgregarRespuestaCampaña(string porcentajeBeca, string idProm, string campaignid, string contactid, string dni, string idDelegacion, int porcentajeP, int porcentajeE, string cuilF, string cuitF, string razonF, string pregunta, string costoCurso, string ordenCompra, string estadoInscripcion, string respNombre, string respApellido, string respTel, string respMail, string estadoPago, string contactoRol, string contactoNombre, string contactoApellido, string contactoDia, string contactoMes, string contactoAno, string contactoTelefono, string contactoCelular, string contactoCiudad, string calleNombre, int calleNumero, string callePiso, string calleDepto, string empresaCuit, string empresaRazon, string empresaSocio, string empresaMail, string empresaTelefono, string empresaLocalidad, string empresaCalle, string empresaNumero, string empresaPiso, string empresaDepto, string contactoTitulo, string modoPago, string opcionPago, string idEmpresa, string contactoMail, string empresaTipo)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			Lookup campaignLookup = new Lookup();
			campaignLookup.Value = new Guid(campaignid);
			campaignLookup.type = EntityName.campaign.ToString();
			LookupProperty campaignProp = new LookupProperty();
			campaignProp.Name = "regardingobjectid";
			campaignProp.Value = campaignLookup;
			PicklistProperty eventoProp = new PicklistProperty();
			eventoProp.Name = "huddle_tipoevento";
			eventoProp.Value = new Picklist();
			eventoProp.Value.Value = 1;
			PicklistProperty respuestaProp = new PicklistProperty();
			respuestaProp.Name = "responsecode";
			respuestaProp.Value = new Picklist();
			respuestaProp.Value.Value = 200000;
			Lookup contactLookup = new Lookup();
			contactLookup.Value = new Guid(contactid);
			contactLookup.type = EntityName.contact.ToString();
			LookupProperty contactProp = new LookupProperty();
			contactProp.Name = "huddle_contactoid";
			contactProp.Value = contactLookup;
			Lookup delegacionLookup = new Lookup();
			delegacionLookup.Value = new Guid(idDelegacion);
			delegacionLookup.type = "new_provincia";
			LookupProperty delegacionLookupProp = new LookupProperty();
			delegacionLookupProp.Name = "huddle_delegacinid";
			delegacionLookupProp.Value = delegacionLookup;
			StringProperty porcentajeBecaProp = new StringProperty();
			porcentajeBecaProp.Name = "new_porcentajebeca";
			porcentajeBecaProp.Value = porcentajeBeca;
			StringProperty dniProp = new StringProperty();
			dniProp.Name = "huddle_documento";
			dniProp.Value = dni;
			StringProperty montoNetoProp = new StringProperty();
			montoNetoProp.Name = "new_nuevomontoneto";
			montoNetoProp.Value = "0";
			StringProperty Promo = new StringProperty();
			Promo.Name = "promotioncodename";
			Promo.Value = idProm;
			CrmDecimalProperty porcentajeParProp = new CrmDecimalProperty();
			porcentajeParProp.Name = "new_porcentajeparticular";
			porcentajeParProp.Value = new CrmDecimal
			{
				Value = porcentajeP
			};
			CrmDecimalProperty porcentajeEmpProp = new CrmDecimalProperty();
			porcentajeEmpProp.Name = "new_porcentajeempresa";
			porcentajeEmpProp.Value = new CrmDecimal
			{
				Value = porcentajeE
			};
			StringProperty cuilProp = new StringProperty();
			cuilProp.Name = "new_cuilfacturacion";
			if (cuilF == null)
			{
				cuilF = "";
			}
			cuilProp.Value = cuilF;
			StringProperty cuitProp = new StringProperty();
			cuitProp.Name = "new_cuitfacturacion";
			if (cuitF == null)
			{
				cuitF = "";
			}
			cuitProp.Value = cuitF;
			if (razonF == null)
			{
				razonF = "";
			}
			StringProperty razonFProp = new StringProperty();
			razonFProp.Name = "new_razonsocfacturacion";
			razonFProp.Value = razonF;
			StringProperty costoProp = new StringProperty();
			costoProp.Name = "new_monto";
			costoProp.Value = costoCurso;
			Lookup preguntaLookup = new Lookup();
			preguntaLookup.Value = new Guid(pregunta);
			preguntaLookup.type = "new_preguntafinal";
			LookupProperty preguntaProp = new LookupProperty();
			preguntaProp.Name = "new_preguntafinalid";
			preguntaProp.Value = preguntaLookup;
			bool ordenCompraBool = false;
			if (ordenCompra == "SI")
			{
				ordenCompraBool = true;
			}
			CrmBooleanProperty ordenProp = new CrmBooleanProperty();
			ordenProp.Name = "new_ordencompra";
			ordenProp.Value = new CrmBoolean
			{
				Value = ordenCompraBool
			};
			int estadoNum = 1;
			if (estadoInscripcion == "INICIADO")
			{
				estadoNum = 1;
			}
			if (estadoInscripcion == "PENDIENTE")
			{
				estadoNum = 2;
			}
			PicklistProperty estadoProp = new PicklistProperty();
			estadoProp.Name = "new_estadodeinscripcion";
			estadoProp.Value = new Picklist();
			estadoProp.Value.Value = estadoNum;
			int estadoP = 1;
			if (estadoPago == "PENDIENTE")
			{
				estadoP = 1;
			}
			PicklistProperty estadoPagoProp = new PicklistProperty();
			estadoPagoProp.Name = "new_estadodelpago";
			estadoPagoProp.Value = new Picklist();
			estadoPagoProp.Value.Value = estadoP;
			StringProperty respNombreProp = new StringProperty();
			respNombreProp.Name = "huddle_nombrerrhh";
			respNombreProp.Value = respNombre;
			StringProperty respApellidoProp = new StringProperty();
			respApellidoProp.Name = "huddle_apellidorrhh";
			respApellidoProp.Value = respApellido;
			StringProperty respTelProp = new StringProperty();
			respTelProp.Name = "huddle_telefonorrhh";
			respTelProp.Value = respTel;
			StringProperty respMailProp = new StringProperty();
			respMailProp.Name = "huddle_correoelectrnicorrhh";
			respMailProp.Value = respMail;
			StringProperty contactoPuestoProp = new StringProperty();
			contactoPuestoProp.Name = "huddle_rolcontacto";
			contactoPuestoProp.Value = contactoRol;
			StringProperty contactoNombreProp = new StringProperty();
			contactoNombreProp.Name = "huddle_nombrecontacto";
			contactoNombreProp.Value = contactoNombre;
			StringProperty contactoApellidoProp = new StringProperty();
			contactoApellidoProp.Name = "huddle_apellidocontacto";
			contactoApellidoProp.Value = contactoApellido;
			StringProperty mailProp = new StringProperty();
			mailProp.Name = "huddle_correoelectronicocontacto";
			mailProp.Value = contactoMail;
			CrmDateTimeProperty contactoFehaNacProp = new CrmDateTimeProperty();
			string pasaFecha = "no";
			if (contactoDia != "" && contactoMes != "" && contactoAno != "")
			{
				pasaFecha = "si";
				CrmDateTime fechaNac = new CrmDateTime();
				DateTime fechaNacimiento = new DateTime((int)Convert.ToInt16(contactoAno), (int)Convert.ToInt16(contactoMes), (int)Convert.ToInt16(contactoDia));
				fechaNac.Value = fechaNacimiento.ToString("s");
				contactoFehaNacProp.Name = "huddle_fechadenacimientocontacto";
				contactoFehaNacProp.Value = fechaNac;
			}
			StringProperty contactoTelProp = new StringProperty();
			contactoTelProp.Name = "huddle_telefonoparticularcontacto";
			contactoTelProp.Value = contactoTelefono;
			StringProperty contactoCelProp = new StringProperty();
			contactoCelProp.Name = "huddle_celularcontacto";
			contactoCelProp.Value = contactoCelular;
			StringProperty contactoCiudadProp = new StringProperty();
			contactoCiudadProp.Name = "huddle_ciudadcontacto";
			contactoCiudadProp.Value = contactoCiudad;
			StringProperty contactoCalleProp = new StringProperty();
			contactoCalleProp.Name = "huddle_callecontacto";
			contactoCalleProp.Value = calleNombre;
			StringProperty contactoNumProp = new StringProperty();
			contactoNumProp.Name = "huddle_numerocontacto";
			contactoNumProp.Value = calleNumero.ToString();
			StringProperty contactoPisoProp = new StringProperty();
			contactoPisoProp.Name = "huddle_pisocontacto";
			contactoPisoProp.Value = callePiso;
			StringProperty contactoDeptoProp = new StringProperty();
			contactoDeptoProp.Name = "huddle_departamentocontacto";
			contactoDeptoProp.Value = calleDepto;
			StringProperty contactoTituloProp = new StringProperty();
			contactoTituloProp.Name = "new_tituloprofesional";
			contactoTituloProp.Value = contactoTitulo;
			Lookup empresaLookup = new Lookup();
			empresaLookup.Value = new Guid(idEmpresa);
			empresaLookup.type = EntityName.account.ToString();
			LookupProperty empresaLookProp = new LookupProperty();
			empresaLookProp.Name = "huddle_empresainstitucinid";
			empresaLookProp.Value = empresaLookup;
			StringProperty empresaCuitProp = new StringProperty();
			empresaCuitProp.Name = "huddle_cuitempresa";
			empresaCuitProp.Value = empresaCuit;
			StringProperty empresaRazonProp = new StringProperty();
			empresaRazonProp.Name = "huddle_razonsocialempresa";
			empresaRazonProp.Value = empresaRazon;
			PicklistProperty empresaSocioProp = new PicklistProperty();
			empresaSocioProp.Name = "huddle_condicon";
			empresaSocioProp.Value = new Picklist();
			if (empresaSocio == "SI")
			{
				empresaSocioProp.Value.Value = 1;
			}
			else
			{
				empresaSocioProp.Value.Value = 2;
			}
			StringProperty empresaMailProp = new StringProperty();
			empresaMailProp.Name = "huddle_correoelectronicoempresa";
			empresaMailProp.Value = empresaMail;
			StringProperty empresaTelProp = new StringProperty();
			empresaTelProp.Name = "huddle_telefonoempresa";
			empresaTelProp.Value = empresaTelefono;
			StringProperty empresaLocalidadProp = new StringProperty();
			empresaLocalidadProp.Name = "huddle_localidadempresa";
			empresaLocalidadProp.Value = empresaLocalidad;
			StringProperty empresaCalleProp = new StringProperty();
			empresaCalleProp.Name = "huddle_calleempresa";
			empresaCalleProp.Value = empresaCalle;
			StringProperty empresaNumeroProp = new StringProperty();
			empresaNumeroProp.Name = "huddle_numeroempresa";
			empresaNumeroProp.Value = empresaNumero;
			StringProperty empresaPisoProp = new StringProperty();
			empresaPisoProp.Name = "huddle_pisoempresa";
			empresaPisoProp.Value = empresaPiso;
			StringProperty empresaDeptoProp = new StringProperty();
			empresaDeptoProp.Name = "huddle_departamentoempresa";
			empresaDeptoProp.Value = empresaDepto;
			PicklistProperty opcionEstadoBeca = new PicklistProperty();
			opcionEstadoBeca.Name = "new_estadodebeca";
			opcionEstadoBeca.Value = new Picklist();
			if (opcionPago == "BECA")
			{
				opcionEstadoBeca.Value.Value = 2;
			}
			else
			{
				opcionEstadoBeca.Value.Value = 1;
			}
			PicklistProperty facOpcionPagoProp = new PicklistProperty();
			facOpcionPagoProp.Name = "new_opcionesdepago";
			facOpcionPagoProp.Value = new Picklist();
			if (opcionPago == "BECA")
			{
				facOpcionPagoProp.Value.Value = 1;
			}
			if (opcionPago == "ESTUDIANTE")
			{
				facOpcionPagoProp.Value.Value = 2;
			}
			if (opcionPago == "COLEGIO")
			{
				facOpcionPagoProp.Value.Value = 3;
			}
			if (opcionPago == "SOCIOBSAS")
			{
				facOpcionPagoProp.Value.Value = 4;
			}
			if (opcionPago == "SOCIOINT")
			{
				facOpcionPagoProp.Value.Value = 5;
			}
			if (opcionPago == "NOSOCIO")
			{
				facOpcionPagoProp.Value.Value = 6;
			}
			if (opcionPago == "FUNCIONARIO")
			{
				facOpcionPagoProp.Value.Value = 7;
			}
			if (opcionPago == "")
			{
				facOpcionPagoProp.Value.Value = 8;
			}
			PicklistProperty facModoPagoProp = new PicklistProperty();
			facModoPagoProp.Name = "new_mododepago";
			facModoPagoProp.Value = new Picklist();
			if (modoPago == "ONLINE")
			{
				facModoPagoProp.Value.Value = 2;
			}
			else
			{
				facModoPagoProp.Value.Value = 1;
			}
			DynamicEntity rta = new DynamicEntity();
			rta.Name = EntityName.campaignresponse.ToString();
			rta.Properties = new PropertyCollection
			{
				campaignProp,
				eventoProp,
				respuestaProp,
				contactProp,
				dniProp,
				delegacionLookupProp,
				porcentajeParProp,
				porcentajeEmpProp,
				cuilProp,
				cuitProp,
				razonFProp,
				preguntaProp,
				costoProp,
				ordenProp,
				estadoProp,
				respNombreProp,
				respApellidoProp,
				respTelProp,
				respMailProp,
				estadoPagoProp,
				contactoPuestoProp,
				contactoNombreProp,
				contactoApellidoProp,
				contactoTelProp,
				contactoCelProp,
				contactoCiudadProp,
				contactoCalleProp,
				contactoNumProp,
				contactoPisoProp,
				contactoDeptoProp,
				empresaCuitProp,
				empresaRazonProp,
				empresaSocioProp,
				empresaMailProp,
				empresaTelProp,
				empresaLocalidadProp,
				empresaCalleProp,
				empresaNumeroProp,
				empresaPisoProp,
				empresaDeptoProp,
				contactoTituloProp,
				facModoPagoProp,
				facOpcionPagoProp,
				empresaLookProp,
				mailProp,
				Promo,
				opcionEstadoBeca,
				porcentajeBecaProp,
				montoNetoProp
			};
			if (pasaFecha == "si")
			{
				rta.Properties.Add(contactoFehaNacProp);
			}
			Guid crID = default(Guid);
			return oService.Create(rta).ToString();
		}

		public static string CreateContacto(string nombre, string apellido, string mail, string dni, string tel, string cel, string dirCalle, int dirNumero, string dirPiso, string dirDepto, string city, string idCargo, string idEmpresa, string sexo, string idArea, string idTipoDir, string ano, string mes, string dia, string idTitulo)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			StringProperty nombreProp = new StringProperty();
			nombreProp.Name = "firstname";
			nombreProp.Value = nombre;
			StringProperty apellidoProp = new StringProperty();
			apellidoProp.Name = "lastname";
			apellidoProp.Value = apellido;
			StringProperty mailProp = new StringProperty();
			mailProp.Name = "emailaddress1";
			mailProp.Value = mail;
			StringProperty dniProp = new StringProperty();
			dniProp.Name = "huddle_documento";
			dniProp.Value = dni;
			StringProperty telProp = new StringProperty();
			telProp.Name = "telephone1";
			telProp.Value = tel;
			StringProperty celProp = new StringProperty();
			celProp.Name = "mobilephone";
			celProp.Value = cel;
			StringProperty dirCalleProp = new StringProperty();
			dirCalleProp.Name = "address1_name";
			dirCalleProp.Value = dirCalle;
			CrmNumberProperty dirNumProp = new CrmNumberProperty();
			dirNumProp.Name = "huddle_address1numero";
			dirNumProp.Value = new CrmNumber
			{
				Value = dirNumero
			};
			StringProperty dirPisoProp = new StringProperty();
			dirPisoProp.Name = "huddle_address1piso";
			dirPisoProp.Value = dirPiso;
			StringProperty dirDeptoProp = new StringProperty();
			dirDeptoProp.Name = "huddle_address1departamento";
			dirDeptoProp.Value = dirDepto;
			StringProperty cityProp = new StringProperty();
			cityProp.Name = "address1_city";
			cityProp.Value = city;
			PicklistProperty sexoaProp = new PicklistProperty();
			sexoaProp.Name = "new_sexo";
			sexoaProp.Value = new Picklist();
			if (sexo == "MASCULINO")
			{
				sexoaProp.Value.Value = 2;
			}
			else
			{
				sexoaProp.Value.Value = 1;
			}
			CrmDateTimeProperty fehaNacProp = new CrmDateTimeProperty();
			string pasaFecha = "no";
			if (ano != "" && mes != "" && dia != "")
			{
				pasaFecha = "si";
				CrmDateTime fechaNac = new CrmDateTime();
				DateTime fechaNacimiento = new DateTime((int)Convert.ToInt16(ano), (int)Convert.ToInt16(mes), (int)Convert.ToInt16(dia));
				fechaNac.Value = fechaNacimiento.ToString("s");
				fehaNacProp.Name = "huddle_fechanacimiento";
				fehaNacProp.Value = fechaNac;
			}
			Lookup areaLookup = new Lookup();
			areaLookup.Value = new Guid(idArea);
			areaLookup.type = "new_area";
			LookupProperty areaProp = new LookupProperty();
			areaProp.Name = "new_areaid";
			areaProp.Value = areaLookup;
			Lookup tipoDirLookup = new Lookup();
			tipoDirLookup.Value = new Guid(idTipoDir);
			tipoDirLookup.type = "new_tipodomicilio";
			LookupProperty tipoDirProp = new LookupProperty();
			tipoDirProp.Name = "new_tipodomicilioid";
			tipoDirProp.Value = tipoDirLookup;
			Lookup tituloLookup = new Lookup();
			tituloLookup.Value = new Guid(idTitulo);
			tituloLookup.type = "new_tituloprofesional";
			LookupProperty tituloProp = new LookupProperty();
			tituloProp.Name = "new_tituloprofesionalid";
			tituloProp.Value = tituloLookup;
			Customer empresa = new Customer();
			empresa.type = EntityName.account.ToString();
			empresa.Value = new Guid(idEmpresa);
			CustomerProperty empresaProp = new CustomerProperty();
			empresaProp.Name = "parentcustomerid";
			empresaProp.Value = empresa;
			Lookup rolLookup = new Lookup();
			rolLookup.Value = new Guid(idCargo);
			rolLookup.type = "new_rolcargofuncion";
			LookupProperty rolProp = new LookupProperty();
			rolProp.Name = "new_rolid";
			rolProp.Value = rolLookup;
			DynamicEntity contact = new DynamicEntity();
			contact.Name = EntityName.contact.ToString();
			contact.Properties = new PropertyCollection
			{
				nombreProp,
				apellidoProp,
				mailProp,
				dniProp,
				telProp,
				celProp,
				dirCalleProp,
				dirNumProp,
				dirPisoProp,
				dirDeptoProp,
				cityProp,
				rolProp,
				sexoaProp,
				areaProp,
				tipoDirProp,
				empresaProp,
				tituloProp
			};
			if (pasaFecha == "si")
			{
				contact.Properties.Add(fehaNacProp);
			}
			Guid crID = default(Guid);
			return oService.Create(contact).ToString();
		}

		public static string CreateEmpresa(string razonSocial, string cuit, string telefono, string mail, bool pyme, string dirCalle, int dirNumero, string dirPiso, string dirDepto, string city, string pais, string socio, string idTipo)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			StringProperty razonProp = new StringProperty();
			razonProp.Name = "name";
			razonProp.Value = razonSocial;
			StringProperty cuitProp = new StringProperty();
			cuitProp.Name = "sic";
			cuitProp.Value = cuit;
			StringProperty telProp = new StringProperty();
			telProp.Name = "telephone1";
			telProp.Value = telefono;
			StringProperty mailProp = new StringProperty();
			mailProp.Name = "emailaddress1";
			mailProp.Value = mail;
			CrmBooleanProperty pymeProp = new CrmBooleanProperty();
			pymeProp.Name = "huddle_espyme";
			pymeProp.Value = new CrmBoolean
			{
				Value = pyme
			};
			StringProperty dirCalleProp = new StringProperty();
			dirCalleProp.Name = "address1_name";
			dirCalleProp.Value = dirCalle;
			CrmNumberProperty dirNumProp = new CrmNumberProperty();
			dirNumProp.Name = "huddle_numero";
			dirNumProp.Value = new CrmNumber
			{
				Value = dirNumero
			};
			StringProperty dirPisoProp = new StringProperty();
			dirPisoProp.Name = "huddle_piso";
			dirPisoProp.Value = dirPiso;
			StringProperty dirDeptoProp = new StringProperty();
			dirDeptoProp.Name = "huddle_departamento";
			dirDeptoProp.Value = dirDepto;
			StringProperty cityProp = new StringProperty();
			cityProp.Name = "address1_city";
			cityProp.Value = city;
			StringProperty paisProp = new StringProperty();
			paisProp.Name = "new_pais";
			paisProp.Value = pais;
			PicklistProperty socioProp = new PicklistProperty();
			socioProp.Name = "new_condicion";
			socioProp.Value = new Picklist();
			if (socio == "Activo")
			{
				socioProp.Value.Value = 1;
			}
			else
			{
				socioProp.Value.Value = 7;
			}
			Lookup tipoLookup = new Lookup();
			tipoLookup.Value = new Guid(idTipo);
			tipoLookup.type = "new_tipoorganizacion";
			LookupProperty tipoProp = new LookupProperty();
			tipoProp.Name = "new_tipoorganizacionid";
			tipoProp.Value = tipoLookup;
			DynamicEntity empresa = new DynamicEntity();
			empresa.Name = EntityName.account.ToString();
			empresa.Properties = new PropertyCollection
			{
				razonProp,
				cuitProp,
				telProp,
				mailProp,
				dirCalleProp,
				dirNumProp,
				dirPisoProp,
				dirDeptoProp,
				cityProp,
				paisProp,
				pymeProp,
				socioProp,
				tipoProp
			};
			Guid crID = default(Guid);
			return oService.Create(empresa).ToString();
		}

		public static void UpdateContacto(string contacto, string nombre, string apellido, string mail, string dni, string tel, string cel, string dirCalle, int dirNumero, string dirPiso, string dirDepto, string city, string idCargo, string idEmpresa, string sexo, string idArea, string idTipoDir, string ano, string mes, string dia, string idTitulo)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			KeyProperty contactoIdProp = new KeyProperty();
			contactoIdProp.Name = "contactid";
			contactoIdProp.Value = new Key();
			contactoIdProp.Value.Value = new Guid(contacto);
			StringProperty nombreUpProp = new StringProperty();
			nombreUpProp.Name = "firstname";
			nombreUpProp.Value = nombre;
			StringProperty apellidoUpProp = new StringProperty();
			apellidoUpProp.Name = "lastname";
			apellidoUpProp.Value = apellido;
			StringProperty mailUpProp = new StringProperty();
			mailUpProp.Name = "emailaddress1";
			mailUpProp.Value = mail;
			StringProperty dniUpProp = new StringProperty();
			dniUpProp.Name = "huddle_documento";
			dniUpProp.Value = dni;
			StringProperty telUpProp = new StringProperty();
			telUpProp.Name = "telephone1";
			telUpProp.Value = tel;
			StringProperty celUpProp = new StringProperty();
			celUpProp.Name = "mobilephone";
			celUpProp.Value = cel;
			StringProperty dirUpCalleProp = new StringProperty();
			dirUpCalleProp.Name = "address1_name";
			dirUpCalleProp.Value = dirCalle;
			CrmNumberProperty dirUpNumProp = new CrmNumberProperty();
			dirUpNumProp.Name = "huddle_address1numero";
			dirUpNumProp.Value = new CrmNumber
			{
				Value = dirNumero
			};
			StringProperty dirUpPisoProp = new StringProperty();
			dirUpPisoProp.Name = "huddle_address1piso";
			dirUpPisoProp.Value = dirPiso;
			StringProperty dirUpDeptoProp = new StringProperty();
			dirUpDeptoProp.Name = "huddle_address1departamento";
			dirUpDeptoProp.Value = dirDepto;
			StringProperty cityUpProp = new StringProperty();
			cityUpProp.Name = "address1_city";
			cityUpProp.Value = city;
			Lookup rolLookup = new Lookup();
			rolLookup.Value = new Guid(idCargo);
			rolLookup.type = "new_rolcargofuncion";
			LookupProperty rolProp = new LookupProperty();
			rolProp.Name = "new_rolid";
			rolProp.Value = rolLookup;
			PicklistProperty sexoaProp = new PicklistProperty();
			sexoaProp.Name = "new_sexo";
			sexoaProp.Value = new Picklist();
			if (sexo == "MASCULINO")
			{
				sexoaProp.Value.Value = 2;
			}
			else
			{
				sexoaProp.Value.Value = 1;
			}
			Lookup areaLookup = new Lookup();
			areaLookup.Value = new Guid(idArea);
			areaLookup.type = "new_area";
			LookupProperty areaProp = new LookupProperty();
			areaProp.Name = "new_areaid";
			areaProp.Value = areaLookup;
			Lookup tipoDirLookup = new Lookup();
			tipoDirLookup.Value = new Guid(idTipoDir);
			tipoDirLookup.type = "new_tipodomicilio";
			LookupProperty tipoDirProp = new LookupProperty();
			tipoDirProp.Name = "new_tipodomicilioid";
			tipoDirProp.Value = tipoDirLookup;
			Lookup tituloLookup = new Lookup();
			tituloLookup.Value = new Guid(idTitulo);
			tituloLookup.type = "new_tituloprofesional";
			LookupProperty tituloProp = new LookupProperty();
			tituloProp.Name = "new_tituloprofesionalid";
			tituloProp.Value = tituloLookup;
			Customer empresa = new Customer();
			empresa.type = EntityName.account.ToString();
			empresa.Value = new Guid(idEmpresa);
			CustomerProperty empresaProp = new CustomerProperty();
			empresaProp.Name = "parentcustomerid";
			empresaProp.Value = empresa;
			if (ano == "")
			{
				ano = "1910";
				mes = "1";
				dia = "1";
			}
			CrmDateTime fechaNac = new CrmDateTime();
			DateTime fechaNacimiento = new DateTime((int)Convert.ToInt16(ano), (int)Convert.ToInt16(mes), (int)Convert.ToInt16(dia));
			fechaNac.Value = fechaNacimiento.ToString("s");
			CrmDateTimeProperty fehaNacProp = new CrmDateTimeProperty();
			fehaNacProp.Name = "huddle_fechanacimiento";
			fehaNacProp.Value = fechaNac;
			oService.Update(new DynamicEntity
			{
				Name = EntityName.contact.ToString(),
				Properties = new PropertyCollection
				{
					contactoIdProp,
					nombreUpProp,
					apellidoUpProp,
					mailUpProp,
					dniUpProp,
					telUpProp,
					celUpProp,
					dirUpCalleProp,
					dirUpNumProp,
					dirUpPisoProp,
					dirUpDeptoProp,
					cityUpProp,
					rolProp,
					sexoaProp,
					areaProp,
					tipoDirProp,
					fehaNacProp,
					tituloProp,
					empresaProp
				}
			});
		}

		public static void UpdateEmpresa(string idempresa, string razonSocial, string cuit, string telefono, string mail, bool pyme, string dirCalle, int dirNumero, string dirPiso, string dirDepto, string city, string pais, string socio, string idTipo)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			KeyProperty empresaIdProp = new KeyProperty();
			empresaIdProp.Name = "accountid";
			empresaIdProp.Value = new Key();
			empresaIdProp.Value.Value = new Guid(idempresa);
			StringProperty razonProp = new StringProperty();
			razonProp.Name = "name";
			razonProp.Value = razonSocial;
			StringProperty cuitProp = new StringProperty();
			cuitProp.Name = "sic";
			cuitProp.Value = cuit;
			StringProperty telProp = new StringProperty();
			telProp.Name = "telephone1";
			telProp.Value = telefono;
			StringProperty mailProp = new StringProperty();
			mailProp.Name = "emailaddress1";
			mailProp.Value = mail;
			CrmBooleanProperty pymeProp = new CrmBooleanProperty();
			pymeProp.Name = "huddle_espyme";
			pymeProp.Value = new CrmBoolean
			{
				Value = pyme
			};
			StringProperty dirCalleProp = new StringProperty();
			dirCalleProp.Name = "address1_name";
			dirCalleProp.Value = dirCalle;
			CrmNumberProperty dirNumProp = new CrmNumberProperty();
			dirNumProp.Name = "huddle_numero";
			dirNumProp.Value = new CrmNumber
			{
				Value = dirNumero
			};
			StringProperty dirPisoProp = new StringProperty();
			dirPisoProp.Name = "huddle_piso";
			dirPisoProp.Value = dirPiso;
			StringProperty dirDeptoProp = new StringProperty();
			dirDeptoProp.Name = "huddle_departamento";
			dirDeptoProp.Value = dirDepto;
			StringProperty cityProp = new StringProperty();
			cityProp.Name = "address1_city";
			cityProp.Value = city;
			StringProperty paisProp = new StringProperty();
			paisProp.Name = "new_pais";
			paisProp.Value = pais;
			PicklistProperty socioProp = new PicklistProperty();
			socioProp.Name = "new_condicion";
			socioProp.Value = new Picklist();
			if (socio == "Activo")
			{
				socioProp.Value.Value = 1;
			}
			else
			{
				socioProp.Value.Value = 3;
			}
			Lookup tipoLookup = new Lookup();
			tipoLookup.Value = new Guid(idTipo);
			tipoLookup.type = "new_tipoorganizacion";
			LookupProperty tipoProp = new LookupProperty();
			tipoProp.Name = "new_tipoorganizacionid";
			tipoProp.Value = tipoLookup;
			oService.Update(new DynamicEntity
			{
				Name = EntityName.account.ToString(),
				Properties = new PropertyCollection
				{
					empresaIdProp,
					razonProp,
					cuitProp,
					telProp,
					mailProp,
					dirCalleProp,
					dirNumProp,
					dirPisoProp,
					dirDeptoProp,
					cityProp,
					paisProp,
					pymeProp,
					socioProp,
					tipoProp
				}
			});
		}

		public static RetrieveMultipleResponse GetProximosCinco(int pagina)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.campaign.ToString();
			query2.ColumnSet = cols;
			OrderExpression oe = new OrderExpression();
			oe.AttributeName = "msa_startdatetime";
			oe.OrderType = OrderType.Ascending;
			query2.Orders.Add(oe);
			query2.PageInfo.Count = 150;
			query2.PageInfo.PageNumber = pagina;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("msa_startdatetime", ConditionOperator.OnOrAfter, DateTime.Now.Date.ToString("yyyy-MM-dd"));
			query2.Criteria.AddCondition("msa_publisheventdetailsonweb", ConditionOperator.Equal, true);
			return (RetrieveMultipleResponse)oService.Execute(new RetrieveMultipleRequest
			{
				Query = query2,
				ReturnDynamicEntities = true
			});
		}

		public static DynamicEntity ContactoByEmail(string mail)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.contact.ToString();
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("emailaddress1", ConditionOperator.Equal, mail);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
			DynamicEntity contacto = null;
			try
			{
				RetrieveMultipleResponse response3 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response3.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						contacto = item;
					}
				}
			}
			catch (Exception)
			{
				contacto = null;
			}
			return contacto;
		}

		public static DynamicEntity EmpresaById(string id)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.account.ToString();
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("accountid", ConditionOperator.Equal, id);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity empresa = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						empresa = item;
					}
				}
			}
			catch (Exception)
			{
				empresa = null;
			}
			return empresa;
		}

		public static DynamicEntity EmpresaByCuit(string cuit)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.account.ToString();
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("sic", ConditionOperator.Equal, cuit);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity empresa = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						if (((Status)item["statuscode"]).name == "Activo")
						{
							empresa = item;
						}
					}
				}
			}
			catch (Exception)
			{
				empresa = null;
			}
			return empresa;
		}

		public static DynamicEntity ContactoByDNI(string dni)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.contact.ToString();
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("huddle_documento", ConditionOperator.Equal, dni);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity contacto = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						contacto = item;
					}
				}
			}
			catch (Exception)
			{
				contacto = null;
			}
			return contacto;
		}

		public static DynamicEntity RetrieveEntityByName(string nombreCargo, string entityName)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = entityName;
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("new_name", ConditionOperator.Equal, nombreCargo);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity contacto = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						contacto = item;
					}
				}
			}
			catch (Exception)
			{
				contacto = null;
			}
			return contacto;
		}

		public static DynamicEntity DelegacionByNombre(string nombreDelegacion)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = "new_provincia";
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("new_nombre", ConditionOperator.Equal, nombreDelegacion);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity delegacion = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						delegacion = item;
					}
				}
			}
			catch (Exception)
			{
				delegacion = null;
			}
			return delegacion;
		}

		public static DynamicEntity PromoById(string id)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = "new_promocion";
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("new_name", ConditionOperator.Equal, id);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity empresa = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						empresa = item;
					}
				}
			}
			catch (Exception)
			{
				empresa = null;
			}
			return empresa;
		}

		public static DynamicEntity UnicoInscripto(string idCurso, string dni)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			AllColumns cols = new AllColumns();
			QueryExpression query2 = new QueryExpression();
			query2.EntityName = EntityName.campaignresponse.ToString();
			query2.ColumnSet = cols;
			query2.Criteria = new FilterExpression();
			query2.Criteria.AddCondition("regardingobjectid", ConditionOperator.Equal, idCurso);
			query2.Criteria.AddCondition("huddle_documento", ConditionOperator.Equal, dni);
			RetrieveMultipleRequest request2 = new RetrieveMultipleRequest();
			request2.Query = query2;
			request2.ReturnDynamicEntities = true;
			DynamicEntity delegacion = null;
			try
			{
				RetrieveMultipleResponse response2 = (RetrieveMultipleResponse)oService.Execute(request2);
				using (List<BusinessEntity>.Enumerator enumerator = response2.BusinessEntityCollection.BusinessEntities.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						DynamicEntity item = (DynamicEntity)enumerator.Current;
						delegacion = item;
					}
				}
			}
			catch (Exception)
			{
				delegacion = null;
			}
			return delegacion;
		}

		public static void DesactivarCodigo(string codigoProm, string dni)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			KeyProperty empresaIdProp = new KeyProperty();
			empresaIdProp.Name = "new_promocionid";
			empresaIdProp.Value = new Key();
			empresaIdProp.Value.Value = new Guid(codigoProm);
			StringProperty dniProp = new StringProperty();
			dniProp.Name = "new_dni";
			dniProp.Value = dni;
			StringProperty fecProp = new StringProperty();
			fecProp.Name = "new_fechautilizado";
			fecProp.Value = DateTime.Now.ToString();
			CrmBooleanProperty usadoProp = new CrmBooleanProperty();
			usadoProp.Name = "new_usado";
			usadoProp.Value = new CrmBoolean
			{
				Value = true
			};
			oService.Update(new DynamicEntity
			{
				Name = "new_promocion",
				Properties = new PropertyCollection
				{
					empresaIdProp,
					usadoProp,
					dniProp,
					fecProp
				}
			});
		}

		public static void PagoRespuesta(string codResp, string idPago, double montoNeto, string metodoPago, string medioPago, string cuotas, string comision)
		{
			CrmService oService = CRMHelper.InicializarServicioCRM();
			KeyProperty campRespIdProp = new KeyProperty();
			campRespIdProp.Name = "activityid";
			campRespIdProp.Value = new Key();
			campRespIdProp.Value.Value = new Guid(codResp);
			PicklistProperty estadoProp = new PicklistProperty();
			estadoProp.Name = "new_estadodeinscripcion";
			estadoProp.Value = new Picklist();
			estadoProp.Value.Value = 4;
			PicklistProperty estadoPagoProp = new PicklistProperty();
			estadoPagoProp.Name = "new_estadodelpago";
			estadoPagoProp.Value = new Picklist();
			estadoPagoProp.Value.Value = 2;
			StringProperty idPagoProp = new StringProperty();
			idPagoProp.Name = "new_idpago";
			idPagoProp.Value = idPago;
			StringProperty comisionProp = new StringProperty();
			comisionProp.Name = "new_comisionpayu";
			comisionProp.Value = comision;
			StringProperty montoNetoProp = new StringProperty();
			montoNetoProp.Name = "new_nuevomontoneto";
			montoNetoProp.Value = montoNeto.ToString();
			CrmNumberProperty cuotasProp = new CrmNumberProperty();
			cuotasProp.Name = "new_cuotas";
			cuotasProp.Value = new CrmNumber
			{
				Value = Convert.ToInt32(cuotas)
			};
			PicklistProperty metodoPagoProp = new PicklistProperty();
			metodoPagoProp.Name = "new_metododepago";
			metodoPagoProp.Value = new Picklist();
			if (metodoPago == "Credito")
			{
				metodoPagoProp.Value.Value = 3;
			}
			if (metodoPago == "Efectivo")
			{
				metodoPagoProp.Value.Value = 2;
			}
			if (metodoPago == "Transferencia")
			{
				metodoPagoProp.Value.Value = 4;
			}
			StringProperty medioPagoProp = new StringProperty();
			medioPagoProp.Name = "new_mediodepago";
			medioPagoProp.Value = medioPago.ToString();
			oService.Update(new DynamicEntity
			{
				Name = EntityName.campaignresponse.ToString(),
				Properties = new PropertyCollection
				{
					campRespIdProp,
					estadoProp,
					estadoPagoProp,
					idPagoProp,
					montoNetoProp,
					medioPagoProp,
					metodoPagoProp,
					cuotasProp,
					comisionProp
				}
			});
		}

		public static void LogInscripcion(string strMsg, string idAleatorio)
		{
			string pathLog = "C:\\Logs";
			using (StreamWriter sw = new StreamWriter(string.Format("{0}\\Log-Personal-{1}-{2}-{3}-{4}.txt", new object[]
			{
				pathLog,
				DateTime.Now.Year,
				DateTime.Now.Month,
				DateTime.Now.Day,
				idAleatorio
			}), true))
			{
				try
				{
					sw.WriteLine(" ");
					sw.WriteLine(strMsg);
				}
				catch
				{
				}
			}
		}
	}
}
