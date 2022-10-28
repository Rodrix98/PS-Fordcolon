using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Venta
    {

        private CD_Venta objCapaDato = new CD_Venta();

        public bool RegistrarVenta(Venta obj, DataTable detalleVenta, out string Mensaje)
        {
            return objCapaDato.RegistrarVenta(obj, detalleVenta, out Mensaje);
        }

        public List<Detalle_Venta> ListarCompras(int idCliente)
        {
            return objCapaDato.ListarCompras(idCliente);
        }
    }
}
