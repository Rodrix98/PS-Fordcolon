using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace CapaDatos
{
    public class CD_Venta
    {

        public bool RegistrarVenta(Venta obj, DataTable detalleVenta, out string Mensaje)
        {
            bool respuesta = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarVenta", oconexion);
                    cmd.Parameters.AddWithValue("idCliente", obj.idCliente);
                    cmd.Parameters.AddWithValue("totalProducto", obj.totalProducto);
                    cmd.Parameters.AddWithValue("montoTotal", obj.montoTotal);
                    cmd.Parameters.AddWithValue("contacto", obj.contacto);
                    cmd.Parameters.AddWithValue("idPais", obj.idPais);
                    cmd.Parameters.AddWithValue("telefono", obj.telefono);
                    cmd.Parameters.AddWithValue("direccion", obj.direccion);
                    cmd.Parameters.AddWithValue("idTransaccion", obj.idTransaccion);
                    cmd.Parameters.AddWithValue("detalleVenta", detalleVenta);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    respuesta = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                    Mensaje = cmd.Parameters["mensaje"].Value.ToString();
                }

            }
            catch (Exception ex)
            {
                respuesta = false;
                Mensaje = ex.Message;
            }

            return respuesta;

        }

        public List<Detalle_Venta> ListarCompras(int idCliente)
        {
            List<Detalle_Venta> lista = new List<Detalle_Venta>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    string query = "select * from fn_ListarCompra(@idCliente)";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.Parameters.AddWithValue("@idCliente", idCliente);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Detalle_Venta()
                                {
                                    idProducto = new Producto()
                                    {
                                        nombre = dr["nombre"].ToString(),
                                        precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                        rutaImagen = dr["rutaImagen"].ToString(),
                                        nombreImagen = dr["nombreImagen"].ToString(),
                                        
                                    },

                                    cantidad = Convert.ToInt32(dr["cantidad"]),
                                    total = Convert.ToDecimal(dr["total"], new CultureInfo("es-AR")),
                                    idTransaccion = dr["idTransaccion"].ToString(),
                                    fechaVenta = dr["fechaVenta"].ToString(),
                                    idVenta = Convert.ToInt32(dr["idVenta"])
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
                lista = new List<Detalle_Venta>();
            }

            return lista;
        }

    }
}
