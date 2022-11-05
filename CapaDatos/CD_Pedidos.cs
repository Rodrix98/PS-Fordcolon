using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Pedidos
    {
        public List<Pedidos> ListarPedidos()
        {
            List<Pedidos> lista = new List<Pedidos>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    string query = "SELECT idPedido, pe.idProducto, cantidad, po.nombre FROM Pedidos pe JOIN Producto po ON pe.idProducto = po.idProducto";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Pedidos()
                                {
                                    
                                    idPedido = Convert.ToInt32(dr["idPedido"]),
                                    idProducto = new Producto() { idProducto = Convert.ToInt32(dr["idProducto"]), nombre = dr["nombre"].ToString() },
                                    cantidad = Convert.ToInt32(dr["cantidad"]),
                                }
                            );
                        }
                    }
                }
            }
            catch (AccessViolationException ave)
            {
                //string error = ex.Message;
                Console.WriteLine("Error" + ave.Message);
                lista = new List<Pedidos>();
            }

            return lista;
        }

        public List<Pedidos> ListarPedidos2()
        {
            List<Pedidos> lista = new List<Pedidos>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    string query = "select * FROM Pedidos";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Pedidos()
                                {
                                    nombre = dr["nombreProducto"].ToString(),
                                    cantidad = Convert.ToInt32(dr["cantidad"]),
                                    fechaPedido = dr["fechaPedido"].ToString()
                                }
                            );
                        }
                    }
                }
            }
            catch (AccessViolationException ave)
            {
                //string error = ex.Message;
                Console.WriteLine("Error" + ave.Message);
                lista = new List<Pedidos>();
            }

            return lista;
        }

        public Pedidos RegistrarPedido(Pedidos obj)
        {
            
            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarPedido", oconexion);
                    cmd.Parameters.AddWithValue("cantidad", obj.cantidad);
                    cmd.Parameters.AddWithValue("nombre", obj.idProducto.nombre);
                    cmd.Parameters.AddWithValue("fechaPedido", obj.fechaPedido);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                }

            }
            catch (AccessViolationException ave)
            {
                Console.WriteLine("Error" + ave.Message);

            }
            
            return obj;
        }


    }


}
