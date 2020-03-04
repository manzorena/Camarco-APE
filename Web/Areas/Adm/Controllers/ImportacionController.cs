using Camarco.Model;
using Camarco.Tools;
using Camarco.Tools.SQL;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web.Mvc;

namespace Camarco.Web.Areas.Adm.Controllers
{
	public class ImportacionController : Controller
	{
		public ActionResult Index()
		{
			StringBuilder log = new StringBuilder();
			log.Append(DateTime.Now + " - Inicio Importacion<br>");
			using (DBHelper dbHelper = new DBHelper())
			{
				try
				{
					using (DataSet ds = dbHelper.RunSQLReturnDataSet("select top 20 Id,SeccionNombre, CategoriaNombre, SubCategoriaNombre, isnull(Tags,'') as Tags, Titulo, isnull(Descripcion,'') as Descripcion, isnull(FilePath,'') as FilePath, CarpetaBase from Importacion with(nolock) where importado=0", false))
					{
						log.Append(string.Concat(new object[]
						{
							DateTime.Now,
							" - Registros encontrados: ",
							ds.Tables[0].Rows.Count,
							"<br>"
						}));
						int index = 1;
						foreach (DataRow dR in ds.Tables[0].Rows)
						{
							log.Append(string.Concat(new object[]
							{
								DateTime.Now,
								" - Procesando ",
								index++,
								": ",
								(string)dR["Titulo"],
								"<br>"
							}));
							int seccionId = -1;
							if (dR["SeccionNombre"] != DBNull.Value)
							{
								try
								{
									seccionId = int.Parse(dbHelper.RunSQLReturnString("select cast(isnull((select SeccionID from Secciones with(nolock) where Nombre ='" + (string)dR["SeccionNombre"] + "'),-1) as varchar)", false));
									if (seccionId == -1)
									{
										Seccion s = new Seccion();
										s.Color = "";
										s.Descripcion = (string)dR["SeccionNombre"];
										s.Nombre = (string)dR["SeccionNombre"];
										s.Template = 1;
										s.TituloPagina = (string)dR["SeccionNombre"];
										s.Save();
										seccionId = s.SeccionID;
										log.Append(string.Concat(new object[]
										{
											DateTime.Now,
											" - Seccion ",
											(string)dR["SeccionNombre"],
											" creada.<br>"
										}));
									}
								}
								catch (Exception ex)
								{
									log.Append(string.Concat(new object[]
									{
										DateTime.Now,
										" - **Error creando Seccion ",
										(string)dR["SeccionNombre"],
										": ",
										ex.Message,
										" <br>"
									}));
									continue;
								}
							}
							int categoriaId = -1;
							if (dR["CategoriaNombre"] != DBNull.Value)
							{
								try
								{
									categoriaId = int.Parse(dbHelper.RunSQLReturnString("select cast(isnull((select DocumentoCategoriaID from DocumentosCategorias with(nolock) where Nombre ='" + (string)dR["CategoriaNombre"] + "'),-1) as varchar)", false));
									if (categoriaId == -1)
									{
										DocumentoCategoria d = new DocumentoCategoria();
										d.Nombre = (string)dR["CategoriaNombre"];
										d.Save();
										categoriaId = d.DocumentoCategoriaID;
										log.Append(string.Concat(new object[]
										{
											DateTime.Now,
											" - Categoria ",
											(string)dR["CategoriaNombre"],
											" creada.<br>"
										}));
									}
								}
								catch (Exception ex)
								{
									log.Append(string.Concat(new object[]
									{
										DateTime.Now,
										" - **Error creando Categoria ",
										(string)dR["CategoriaNombre"],
										": ",
										ex.Message,
										" <br>"
									}));
									continue;
								}
							}
							int subcategoriaId = -1;
							if (dR["SubCategoriaNombre"] != DBNull.Value)
							{
								try
								{
									subcategoriaId = int.Parse(dbHelper.RunSQLReturnString(string.Concat(new object[]
									{
										"select cast(isnull((select DocumentoCategoriaID from DocumentosCategorias with(nolock) where ParentID=",
										categoriaId,
										" and Nombre ='",
										(string)dR["SubCategoriaNombre"],
										"'),-1) as varchar)"
									}), false));
									if (subcategoriaId == -1)
									{
										DocumentoCategoria d = new DocumentoCategoria();
										d.Nombre = (string)dR["SubCategoriaNombre"];
										d.Parent = new DocumentoCategoria(categoriaId);
										d.Save();
										subcategoriaId = d.DocumentoCategoriaID;
										log.Append(string.Concat(new object[]
										{
											DateTime.Now,
											" - SubCategoria ",
											(string)dR["SubCategoriaNombre"],
											" creada.<br>"
										}));
									}
								}
								catch (Exception ex)
								{
									log.Append(string.Concat(new object[]
									{
										DateTime.Now,
										" - **Error creando SubCategoria ",
										(string)dR["SubCategoriaNombre"],
										": ",
										ex.Message,
										" <br>"
									}));
									continue;
								}
							}
							Documento doc = new Documento();
							doc.LoadResource();
							doc.Resource.Nombre = (string)dR["Titulo"];
							doc.Resource.Type = ResourceType.DOCUMENTO;
							doc.Titulo = (string)dR["Titulo"];
							doc.Descripcion = (string)dR["Descripcion"];
							doc.Publico = true;
							if (subcategoriaId > 0)
							{
								doc.Categorias.Add(new DocumentoCategoria(subcategoriaId));
							}
							else if (categoriaId > 0)
							{
								doc.Categorias.Add(new DocumentoCategoria(categoriaId));
							}
							if (seccionId > 0)
							{
								doc.Resource.Secciones.Add(new Seccion(seccionId));
							}
							try
							{
								if ((string)dR["FilePath"] != "")
								{
									Camarco.Model.File a = new Camarco.Model.File();
									a.Filename = Path.GetFileName((string)dR["FilePath"]);
									a.Extension = Path.GetExtension((string)dR["FilePath"]).Replace(".", "");
									a.Kb = FileManager.GetKBytes((string)dR["CarpetaBase"] + "\\", a.Filename);
									a.Filebinary = FileManager.ReadBinaryFile((string)dR["CarpetaBase"] + "\\", a.Filename);
									a.Save();
									doc.FileID = a.FileID;
									if (doc.Publico)
									{
										doc.Resource.URL = "/File/GetPublicFile?id=" + a.FileID;
									}
									else
									{
										doc.Resource.URL = "/File/GetPrivateFile?id=" + a.FileID;
									}
								}
							}
							catch (Exception ex)
							{
								log.Append(string.Concat(new object[]
								{
									DateTime.Now,
									" - **Error leyendo archivo ",
									(string)dR["FilePath"],
									": ",
									ex.Message,
									" <br>"
								}));
								continue;
							}
							try
							{
								string tags = (string)dR["Tags"];
								if (tags.Length > 0)
								{
									doc.Resource.Tags = tags;
								}
								doc.Resource.Save();
							}
							catch (Exception ex)
							{
								log.Append(string.Concat(new object[]
								{
									DateTime.Now,
									" - **Error grabando Resource : ",
									ex.Message,
									" <br>"
								}));
								continue;
							}
							try
							{
								doc.ResourceID = doc.Resource.ResourceID;
								doc.Save();
							}
							catch (Exception ex)
							{
								log.Append(string.Concat(new object[]
								{
									DateTime.Now,
									" - **Error grabando Documento : ",
									ex.Message,
									" <br>"
								}));
								ResourceManager.Remove(doc.ResourceID);
								continue;
							}
							log.Append(string.Concat(new object[]
							{
								DateTime.Now,
								" - ",
								(string)dR["Titulo"],
								" procesado.<br>"
							}));
							dbHelper.RunSQL("update importacion set importado=1 where Id=" + (int)dR["Id"], true);
						}
						ds.Clear();
					}
				}
				catch (Exception ex)
				{
					log.Append(string.Concat(new object[]
					{
						DateTime.Now,
						" - **Error Leyendo registros: ",
						ex.Message,
						" <br>"
					}));
				}
			}
			base.ViewData["log"] = log.ToString();
			return base.View();
		}
	}
}
