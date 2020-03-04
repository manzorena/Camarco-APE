using Camarco.Tools.SQL;
using Camarco.Tools.Validation;
using System;
using System.Collections.Generic;
using System.Data;

namespace Camarco.Model
{
    public class Adhesion_form
    {
        public bool ModelValidated = false;

        public string adhesion_name { get; set; }
        public string adhesion_empresa { get; set; }
        public string adhesion_cargo { get; set; }
        public string adhesion_nota { get; set; }
        public string adhesion_tipo_de_archivo { get; set; }

        public int id { get; set; }



        public bool ValidateModel()
        {
            List<string> Errors = new List<string>();

            if (this.adhesion_name.Length == 0)
            {
                Errors.Add("El campo nombre y apellido no puede estar vacío.");
            }

            if (this.adhesion_empresa.Length == 0)
            {
                Errors.Add("El campo empresa no puede estar vacío.");
            }

            if (this.adhesion_cargo.Length == 0)
            {
                Errors.Add("El campo cargo no puede estar vacío.");
            }

            if (this.adhesion_nota.Length == 0)
            {
                Errors.Add("Debe adjuntar una Nota de adhesion.");
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

                    this.id = dbHelper.RunSPReturnInteger("Adhesion_Save", true, new customParameter[]
					{
						dbHelper.MP("@nombre", SqlDbType.VarChar, Text.Truncate(this.adhesion_name, 50)),
						dbHelper.MP("@empresa", SqlDbType.VarChar, Text.Truncate(this.adhesion_empresa, 200)),
						dbHelper.MP("@cargo", SqlDbType.VarChar, Text.Truncate(this.adhesion_cargo, 50)),
						dbHelper.MP("@nota", SqlDbType.VarChar, this.adhesion_nota),
						dbHelper.MP("@tipoarchivo", SqlDbType.VarChar, this.adhesion_tipo_de_archivo),

						dbHelper.MP("@fecha", SqlDbType.Date, DateTime.Now),
                        dbHelper.MP("@hora", SqlDbType.Time, DateTime.Now.ToString("HH:mm:ss"))
					});
            }
        }

    }
 }
