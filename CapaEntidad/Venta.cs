using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class Venta
    {
        public int idVenta { get; set; }
        public int idCliente { get; set; }
        public int totalProducto { get; set; }
        public decimal montoTotal { get; set; }
        public string contacto  { get; set; }
        public string idPais { get; set; }
        public string telefono { get; set; }
        public string direccion { get; set; }
        public string fechaTexto { get; set; }
        public string idTransaccion { get; set; }

        public List<Detalle_Venta> oDetalleVenta { get; set; }
        
    }
}
