using Camarco.Model;
using Camarco.Tools;
using Camarco.Web.WS.Carmarco.CRM;
using NLog;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Threading;

namespace Camarco.Integration
{
	public static class Sync
	{
		public static void DelayedCleanup(object path)
		{
			try
			{
				Thread.Sleep(50000);
				Directory.Delete((string)path, true);
			}
			catch
			{
			}
		}

		public static void Cursos(object basePath)
		{
			List<Curso> cursosDB = new List<Curso>();
			Logger logger = LogManager.GetLogger("CamarcoLogger");
			Camarco.Model.Cursos.ClearCursos();
			try
			{
				CRMLookUpService s = new CRMLookUpService();
				Campaign[] cursos = s.GetCampaignsByTypeCodeAndPublishedOnWebSite(3, true, 200000, 200002);
				DateTime maxOldDate = DateTime.Now.AddMonths(-6);
				Campaign[] array = cursos;
				for (int i = 0; i < array.Length; i++)
				{
					Campaign curso = array[i];
					if (!(curso.StartDateTime < maxOldDate))
					{
						try
						{
							Curso c = Camarco.Model.Cursos.GetByCampaign(curso.CampaingId);
							if (c == null)
							{
								c = new Curso();
							}
							try
							{
								if (c.ImagenID == 0)
								{
									InfoImage image = s.GetImageCourse(curso.CampaingId.ToString());
									if (image.Success)
									{
										Camarco.Model.File a = new Camarco.Model.File();
										a.Filename = image.FileName;
										a.Extension = Path.GetExtension(image.FileName).Replace(".", "");
										a.Kb = 0;
										using (FileStream fs = new FileStream(basePath + a.Filename, FileMode.Create))
										{
											using (BinaryWriter bw = new BinaryWriter(fs))
											{
												bw.Write(Convert.FromBase64String(image.DocumentBody));
												bw.Close();
											}
										}
										FileManager.CropImage(142, 115, basePath + a.Filename, basePath + a.Filename + "2");
										a.Filebinary = FileManager.ReadBinaryFile((string)basePath, a.Filename + "2");
										a.Save();
										System.IO.File.Delete(basePath + a.Filename);
										System.IO.File.Delete(basePath + a.Filename + "2");
										c.ImagenID = a.FileID;
									}
								}
							}
							catch
							{
							}
							c.CampaignID = curso.CampaingId;
							c.Copete = curso.EventDetails;
							c.Titulo = curso.EventName;
							c.Docentes = string.Concat(new string[]
							{
								curso.Docente1,
								" ",
								curso.Docente2,
								" ",
								curso.Docente3,
								" ",
								curso.Docente4,
								curso.Docente5
							});
							c.CostoNoSocio = ((curso.CostoNoSocio == null) ? 0m : decimal.Parse(curso.CostoNoSocio, CultureInfo.InvariantCulture));
							c.CostoSocioBsAs = ((curso.CostoSocioBsAs == null) ? 0m : decimal.Parse(curso.CostoSocioBsAs, CultureInfo.InvariantCulture));
							c.CostoSocioInterior = ((curso.CostoSocioInterior == null) ? 0m : decimal.Parse(curso.CostoSocioInterior, CultureInfo.InvariantCulture));
							c.CronogramaInicio = curso.StartDateTime.Value;
							c.CronogramaFin = curso.EndDateTime.Value;
							c.Descripcion = "";
							c.DiasSemanaCantidad = curso.DiasSemanaCantidad;
							c.CronogramaHorarioInicio = ((curso.CourseStartTime.Length <= 2) ? DateTime.ParseExact("1900-01-01 " + curso.CourseStartTime.PadLeft(2, '0') + ":00", "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : DateTime.ParseExact("1900-01-01 " + curso.CourseStartTime.Replace(".", ":").PadLeft(5, '0'), "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture));
							c.CronogramaHorarioFin = ((curso.CourseEndTime.Length <= 2) ? DateTime.ParseExact("1900-01-01 " + curso.CourseEndTime.PadLeft(2, '0') + ":00", "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : DateTime.ParseExact("1900-01-01 " + curso.CourseEndTime.Replace(".", ":").PadLeft(5, '0'), "yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture));
							c.Modalidad = curso.Modalidad;
							c.Duracion = curso.Duracion;
							c.BrochureUrl = ((curso.EventBrochureUrl != null && curso.EventBrochureUrl.Length > 0) ? curso.EventBrochureUrl.Replace("www.camarco.org.ar", "capacitacion.camarco.org.ar") : curso.EventBrochureUrl);
							c.DirigidoA = curso.DirigidoA;
							cursosDB.Add(c);
						}
						catch (Exception ex)
						{
							logger.Error(string.Concat(new string[]
							{
								"Integration > Cursos > LocalLoad: FAILED! > ",
								curso.EventName,
								" CampaignID ",
								curso.CampaingId.ToString(),
								" | ",
								ex.Message
							}));
						}
					}
				}
			}
			catch (Exception ex)
			{
				logger.Error("Integration > Cursos: FAILED! > " + ex.Message);
				return;
			}
			foreach (Curso c in cursosDB)
			{
				try
				{
					//Curso c;
					if (c.CursoID == "")
					{
						Resource r = new Resource();
						r.Nombre = c.Titulo;
						r.Type = ResourceType.CURSO;
						r.Save();
						c.ResourceID = r.ResourceID;
					}
					else
					{
						c.Resource.Nombre = c.Titulo;
						c.Resource.Save();
					}
					c.Save();
				}
				catch (Exception ex)
				{
					//Curso c;
					logger.Error(string.Concat(new string[]
					{
						"Integration > Cursos > LocalSave: FAILED! > ",
						c.Titulo,
						" CampaignID ",
						c.CampaignID.ToString(),
						" | ",
						ex.Message
					}));
				}
			}
		}
	}
}
