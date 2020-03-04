using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
    public class DenunciaForm
    {
        public bool ModelValidated = false;

        public string denuncia_area { get; set; }
        public string denuncia_ocupacion { get; set; }
        public string denuncia_resumen { get; set; }
        public string denuncia_archivo { get; set; }
        public string denuncia_tipo_de_archivo { get; set; }
        public string denuncia_relacion { get; set; }
        public bool   denuncia_anonima { get; set; }
        public string denuncia_nombreyapell { get; set; }
        public string denuncia_nacionalidad { get; set; }
        public string denuncia_dni { get; set; }
        public string denuncia_telefono { get; set; }
        public string denuncia_email { get; set; }

        public int id { get; set; }


        public void save()
        {

            using (DBHelper dbHelper = new DBHelper())
            {
                    this.id = dbHelper.RunSPReturnInteger("Denuncia_Save", true, new customParameter[]
                    {
						dbHelper.MP("@area", SqlDbType.VarChar, Text.Truncate(this.denuncia_area, 50)),
						dbHelper.MP("@ocupacion", SqlDbType.VarChar, Text.Truncate(this.denuncia_ocupacion, 200)),
						dbHelper.MP("@resumen", SqlDbType.VarChar, Text.Truncate(this.denuncia_resumen, 50)),
						dbHelper.MP("@archivo", SqlDbType.VarChar, Text.Truncate(this.denuncia_archivo, int.MaxValue)),
						dbHelper.MP("@tipoarchivo", SqlDbType.VarChar, this.denuncia_tipo_de_archivo),                        
						dbHelper.MP("@relacion", SqlDbType.VarChar, Text.Truncate(this.denuncia_relacion, 10)),
						dbHelper.MP("@anonima", SqlDbType.Bit, this.denuncia_anonima),
						dbHelper.MP("@nombreyapell", SqlDbType.VarChar, Text.Truncate(this.denuncia_nombreyapell, 50)),
						dbHelper.MP("@nacionalidad", SqlDbType.VarChar, Text.Truncate(this.denuncia_nacionalidad, 50)),
						dbHelper.MP("@dni", SqlDbType.VarChar, Text.Truncate(this.denuncia_dni, 50)),
						dbHelper.MP("@telefono", SqlDbType.VarChar, Text.Truncate(this.denuncia_telefono, 50)),
						dbHelper.MP("@email", SqlDbType.VarChar, Text.Truncate(this.denuncia_email, 50)),
						dbHelper.MP("@fecha", SqlDbType.Date, DateTime.Now),
                        dbHelper.MP("@hora", SqlDbType.Time, DateTime.Now.ToString("HH:mm:ss"))
                    });
                }
            }
        }

    }
