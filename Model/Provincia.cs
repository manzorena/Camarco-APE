using System;

namespace Camarco.Model
{
	public class Provincia
	{
		public int ProvinciaID
		{
			get;
			set;
		}

		public string Nombre
		{
			get;
			set;
		}

		public Provincia(int id, string nombre)
		{
			this.ProvinciaID = id;
			this.Nombre = nombre;
		}
	}
}
