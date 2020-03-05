using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Camarco.Model
{
    public class EspacioPymeModel
    {
        #region Constructor

        public EspacioPymeModel() 
        {
            List<ArticuloModel> ArticulosSlider = new List<ArticuloModel>();
            List<ArticuloModel> ArticulosAgenda = new List<ArticuloModel>();
        }

        #endregion

        #region Properties

        private List<ArticuloModel> _articulosSlider;

        public List<ArticuloModel> ArticulosSlider
        {
            get { return _articulosSlider; }
            set { _articulosSlider = value; }
        }

        private List<ArticuloModel> _articulosAgenda;

        public List<ArticuloModel> ArticulosAgenda
        {
            get { return _articulosAgenda; }
            set { _articulosAgenda = value; }
        }

        #endregion
    }
}
