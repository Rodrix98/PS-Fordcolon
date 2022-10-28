using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Marca
    {
        private CD_Marca objCapaDato = new CD_Marca();

        public List<Marca> ListarMarcas()
        {
            return objCapaDato.ListarMarcas();
        }

        public int RegistrarMarca(Marca obj, out string Mensaje)
        {

            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.descripcion) || string.IsNullOrWhiteSpace(obj.descripcion))
            {
                Mensaje = "La descripcion de la marca no puede estar vacia";
            }


            if (string.IsNullOrEmpty(Mensaje))
            {

                return objCapaDato.RegistrarMarca(obj, out Mensaje);
            }
            else
            {
                return 0;
            }
        }

        public bool EditarMarca(Marca obj, out string Mensaje)
        {

            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.descripcion) || string.IsNullOrWhiteSpace(obj.descripcion))
            {
                Mensaje = "La descripcion de la marca no puede estar vacia";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDato.EditarMarca(obj, out Mensaje);
            }
            else
            {
                return false;
            }
        }

        public bool EliminarMarca(int id, out string Mensaje)
        {
            return objCapaDato.EliminarMarca(id, out Mensaje);
        }

        //public List<Marca> ListarMarcasPorCategoria(int idCategoria)
        //{
        //    return objCapaDato.ListarMarcasPorCategoria(idCategoria);
        //}
    }
}
