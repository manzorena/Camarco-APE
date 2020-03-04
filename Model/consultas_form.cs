using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
    public class ConsultaForm
    {
        public bool ModelValidated = false;

        public string consulta_mensaje { get; set; }
        public string consulta_nombre { get; set; }
        public string consulta_apellido { get; set; }
        public string consulta_nacionalidad { get; set; }
        public string consulta_dni { get; set; }
        public string consulta_email { get; set; }
        public string consulta_telefono { get; set; }

        public int id { get; set; }



        public bool ValidateModel()
        {
            List<string> Errors = new List<string>();

            if (this.consulta_mensaje.Length == 0)
            {
                Errors.Add("El campo mensaje no puede estar vacío.");
            }

            if (Errors.Count > 0)
            {
                throw new ValidationException(Errors);
            }
            this.ModelValidated = true;
            return true;
        }



        public void Save()
        {
            if (false)
            {
                this.ValidateModel();
            }
            using (DBHelper dbHelper = new DBHelper())
            {

                    this.id = dbHelper.RunSPReturnInteger("Consulta_Save", true, new customParameter[]
					{
						dbHelper.MP("@nombre", SqlDbType.VarChar, Text.Truncate(this.consulta_nombre, 50)),
						dbHelper.MP("@mensaje", SqlDbType.VarChar, Text.Truncate(this.consulta_mensaje, 200)),
						dbHelper.MP("@apellido", SqlDbType.VarChar, Text.Truncate(this.consulta_apellido, 50)),
						dbHelper.MP("@nacionalidad", SqlDbType.VarChar, Text.Truncate(this.consulta_nacionalidad, 50)),
						dbHelper.MP("@dni", SqlDbType.VarChar, Text.Truncate(this.consulta_dni, 10)),
						dbHelper.MP("@email", SqlDbType.VarChar, Text.Truncate(this.consulta_email, 50)),
						dbHelper.MP("@telefono", SqlDbType.VarChar, Text.Truncate(this.consulta_telefono, 50)),
						dbHelper.MP("@fecha", SqlDbType.Date, DateTime.Now),
                        dbHelper.MP("@hora", SqlDbType.Time, DateTime.Now.ToString("HH:mm:ss"))
					});
            }
        }

    }


}
