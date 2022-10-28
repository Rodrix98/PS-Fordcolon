using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Detalle_Venta
    {
        public int idDetalle { get; set; }
        public int idVenta { get; set; }
        public Producto idProducto  { get; set; }
        public int cantidad { get; set; }
        public decimal total { get; set; }
        public string idTransaccion { get; set; }
        public string fechaVenta { get; set; }

    }
}
