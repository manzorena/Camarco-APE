using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Camarco.Model
{
    public class ArticuloModel
    {
        #region Constructor

        public ArticuloModel()
        { 
            
        }

        #endregion
        
        //Datos que tienen las noticias en la Base de Datos
        //Por ejemplo:
        //public string titulo;

        #region Fields

        private String _titulo;

        public String Titulo
        {
            get { return _titulo; }
            set { _titulo = value; }
        }

        private String _imagenPath;

        public String ImagenPath
        {
            get { return _imagenPath; }
            set { _imagenPath = value; }
        }

        private Int32 _id;

        public Int32 Id
        {
            get { return _id; }
            set { _id = value; }
        }

        private Int32 _dia;

        public Int32 Dia
        {
            get { return _dia; }
            set { _dia = value; }
        }

        private Int32 _mes;

        public Int32 Mes
        {
            get { return _mes; }
            set { _mes = value; }
        }

        private String _ruta;

        public String Ruta
        {
            get { return _ruta; }
            set { _ruta = value; }
        }
        


        #endregion

    }
}