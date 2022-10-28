using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FordcolonTienda.Models.ViewModel
{
    public class ComprobanteCompra2
    {
        public string contacto { get; set; }
        public string idTransaccion { get; set; }
        public string fechaVenta { get; set; }
        public decimal montoTotal { get; set; }
        public string nombreProducto { get; set; }
        public decimal precio { get; set; }
        public int cantidad { get; set; }
        public string provincia { get; set; }
        public string localidad { get; set; }
        public string codigoPostal { get; set; }
        public string direccion { get; set; }

    }
}