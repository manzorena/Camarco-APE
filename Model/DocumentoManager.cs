using Camarco.Tools.SQL;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
	public static class DocumentoManager
	{
		public static int CountAll()
		{
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Documentos_CountAll", false, new customParameter[0]);
			}
			return result;
		}

		public static List<Documento> List(int page, int perpage)
		{
			List<Documento> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Documento> retval = new List<Documento>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Documentos_List", false, new customParameter[]
				{
					dbHelper.MP("@Page", SqlDbType.Int, page.ToString()),
					dbHelper.MP("@PerPage", SqlDbType.TinyInt, perpage.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Documento((int)dR["DocumentoID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static int CountFiltered(string nombre, int seccion, int categoria)
		{
			int result;
			using (DBHelper dbHelper = new DBHelper())
			{
				result = dbHelper.RunSPReturnInteger("Documentos_CountFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccion.ToString()),
					dbHelper.MP("@CategoriaID", SqlDbType.Int, categoria.ToString())
				});
			}
			return result;
		}

		public static List<Documento> ListFiltered(int page, int perpage, string nombre, int seccion, int categoria)
		{
			List<Documento> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Documento> retval = new List<Documento>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("Documentos_ListFiltered", false, new customParameter[]
				{
					dbHelper.MP("@Page", SqlDbType.Int, page.ToString()),
					dbHelper.MP("@PerPage", SqlDbType.TinyInt, perpage.ToString()),
					dbHelper.MP("@Nombre", SqlDbType.VarChar, nombre),
					dbHelper.MP("@SeccionID", SqlDbType.Int, seccion.ToString()),
					dbHelper.MP("@CategoriaID", SqlDbType.Int, categoria.ToString())
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new Documento((int)dR["DocumentoID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<DocumentoCategoria> GetCategorias()
		{
			List<DocumentoCategoria> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<DocumentoCategoria> retval = new List<DocumentoCategoria>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("DocumentoCategorias_List", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new DocumentoCategoria((int)dR["DocumentoCategoriaID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<DocumentoCategoria> GetCategoriasParents()
		{
			List<DocumentoCategoria> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<DocumentoCategoria> retval = new List<DocumentoCategoria>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("DocumentoCategorias_ListParents", false, new customParameter[0]))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new DocumentoCategoria((int)dR["DocumentoCategoriaID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static List<DocumentoCategoria> GetCategoriasParentsBySeccion(int sid)
		{
			List<DocumentoCategoria> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<DocumentoCategoria> retval = new List<DocumentoCategoria>();
				using (DataSet ds = dbHelper.RunSPReturnDataSet("DocumentoCategorias_ListParentsBySeccion", false, new customParameter[]
				{
					dbHelper.MP("@SeccionID", SqlDbType.Int, sid)
				}))
				{
					foreach (DataRow dR in ds.Tables[0].Rows)
					{
						retval.Add(new DocumentoCategoria((int)dR["DocumentoCategoriaID"]));
					}
					ds.Clear();
				}
				result = retval;
			}
			return result;
		}

		public static Documento GetByResource(int ResourceID)
		{
			Documento result;
			using (DBHelper dbHelper = new DBHelper())
			{
				int DocumentoID = dbHelper.RunSPReturnInteger("Documentos_GetByResource", false, new customParameter[]
				{
					dbHelper.MP("@ResourceID", SqlDbType.Int, ResourceID.ToString())
				});
				if (DocumentoID == -1)
				{
					result = null;
				}
				else
				{
					Documento d = new Documento(DocumentoID);
					d.LoadCategorias();
					d.LoadResource();
					result = d;
				}
			}
			return result;
		}

		public static List<Documento> ListFilteredByUser(int seccionid, int categoria, int subcategoria, string tag)
		{
			List<Documento> result;
			using (DBHelper dbHelper = new DBHelper())
			{
				List<Documento> retval = new List<Documento>();
				if (tag.Length == 0)
				{
					using (DataSet ds = dbHelper.RunSPReturnDataSet("Documentos_ListFiltered_Categoria", false, new customParameter[]
					{
						dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid),
						dbHelper.MP("@CategoriaID", SqlDbType.Int, categoria),
						dbHelper.MP("@SubCategoriaID", SqlDbType.Int, subcategoria)
					}))
					{
						foreach (DataRow dR in ds.Tables[0].Rows)
						{
							retval.Add(new Documento((int)dR["DocumentoID"]));
						}
						ds.Clear();
					}
				}
				else
				{
					using (DataSet ds = dbHelper.RunSPReturnDataSet("Resources_TagFilter", false, new customParameter[]
					{
						dbHelper.MP("@SeccionID", SqlDbType.Int, seccionid),
						dbHelper.MP("@Type", SqlDbType.Int, 1),
						dbHelper.MP("@Tag", SqlDbType.VarChar, tag.ToLower())
					}))
					{
						foreach (DataRow dR in ds.Tables[0].Rows)
						{
							retval.Add(DocumentoManager.GetByResource((int)dR["ResourceID"]));
						}
						ds.Clear();
					}
				}
				result = retval;
			}
			return result;
		}
	}
}
