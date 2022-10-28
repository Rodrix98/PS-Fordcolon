using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;

namespace FordcolonTienda.Models.ViewModel
{
    public class Conexion
    {
        public static string cn = ConfigurationManager.ConnectionStrings["cadena"].ToString();


        public List<ComprobanteCompra2> GenerarComprobante(string idTransaccion)
        {

            List<ComprobanteCompra2> lista = new List<ComprobanteCompra2>();

            try
            {

                using (SqlConnection oconexion = new SqlConnection(cn))
                {

                    string query = "SELECT p.nombre as NombreProducto, p.precio, dv.cantidad, dv.total,v.contacto, v.idTransaccion, v.fechaVenta, v.montoTotal, v.direccion FROM Venta v join Detalle_Venta dv on v.idVenta = dv.idVenta join Producto p on p.idProducto = dv.idProducto WHERE v.idTransaccion = @idTransaccion";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.Parameters.AddWithValue("@idTransaccion", idTransaccion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new ComprobanteCompra2()
                                {

                                    nombreProducto = dr["NombreProducto"].ToString(),
                                    precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                    cantidad = Convert.ToInt32(dr["cantidad"]),
                                    contacto = dr["contacto"].ToString(),
                                    idTransaccion = dr["idTransaccion"].ToString(),
                                    fechaVenta = dr["fechaVenta"].ToString(),
                                    montoTotal = Convert.ToDecimal(dr["montoTotal"], new CultureInfo("es-AR")),
                                    direccion = dr["direccion"].ToString()
                                }
                            );
                        }
                    }
                }

            }
            catch (AccessViolationException ave)
            {

                Console.WriteLine("Error" + ave.Message);
                lista = new List<ComprobanteCompra2>();
            }

            return lista;
        }

    }
}