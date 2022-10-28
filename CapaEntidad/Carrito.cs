using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Carrito
    {
        public int idCarrito { get; set; }
        public Cliente idCliente { get; set; }
        public Producto idProducto { get; set; }
        public int cantidad { get; set; }

    }
}
