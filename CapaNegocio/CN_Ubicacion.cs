using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using CapaDatos;

namespace CapaNegocio
{
    public class CN_Ubicacion
    {

        private CD_Ubicacion objCapaDato = new CD_Ubicacion();

        public List<Departamento> ObtenerDepartamentos(string idProvincia)
        {
            return objCapaDato.ObtenerDepartamentos(idProvincia);
        }

        public List<Provincia> ObtenerProvincias()
        {
            return objCapaDato.ObtenerProvincias();
        }

        public string ObtenerProvinciasPorID(int idProvincia)
        {
            return objCapaDato.ObtenerProvinciaPorID(idProvincia);
        }

        public List<Pais> ObtenerPais(string idDepartamento, string idProvincia)
        {
            return objCapaDato.ObtenerPais(idDepartamento, idProvincia);
        }

    }
}
