using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Camarco.Tools.SQL;
using System.Data;

namespace Camarco.Model
{
    public class SeccionDocumento{

    public bool ModelValidated = false;

		public int DocumentoID
		{
			get;
			set;
		}

		public string Titulo
		{
			get;
			set;
		}

		public string Descripcion
		{
			get;
			set;
		}

		public List<DocumentoCategoria> Categorias
		{
			get;
			set;
		}

		public DateTime FechaModificacion
		{
			get;
			set;
		}

		public int FileID
		{
			get;
			set;
		}

		public int ResourceID
		{
			get;
			set;
		}

		public bool Publico
		{
			get;
			set;
		}


        public string ResourceURL
        {
            get;
            set;
        }
    }
}
