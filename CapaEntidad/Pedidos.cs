using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Pedidos
    {
        public int idPedido { get; set; }
        public Producto idProducto { get; set; }
        public int cantidad { get; set; }
        public string nombre { get; set; }
        public string fechaPedido { get; set; }


    }
}
