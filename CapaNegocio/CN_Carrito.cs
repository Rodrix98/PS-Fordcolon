using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;


namespace CapaNegocio
{
    public class CN_Carrito
    {
        private CD_Carrito objCapaDato = new CD_Carrito();

        public bool ExisteCarrito(int idCliente, int idProducto)
        {
            return objCapaDato.ExisteCarrito(idCliente, idProducto);
        }

        public bool OperacionCarrito(int idCliente, int idProducto, bool sumar, out string mensaje)
        {
            return objCapaDato.OperacionCarrito(idCliente, idProducto, sumar, out mensaje);
        }

        public int CantidadEnCarrito(int idCliente)
        {
            return objCapaDato.CantidadEnCarrito(idCliente);
        }

        public List<Carrito> ListarProductosEnCarrito(int idCliente)
        {
            return objCapaDato.ListarProductosEnCarrito(idCliente);
        }

        public bool EliminarCarrito(int idCliente, int idProducto)
        {
            return objCapaDato.EliminarCarrito(idCliente, idProducto);
        }

    }
}
