using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Pedidos
    {
        CD_Pedidos objCapaDato = new CD_Pedidos();

        public List<Pedidos> ListarPedidos()
        {
            return objCapaDato.ListarPedidos2();
        }

        public Pedidos RegistrarPedido(Pedidos obj)
        {

            return objCapaDato.RegistrarPedido(obj);
           
        }
    }
}
