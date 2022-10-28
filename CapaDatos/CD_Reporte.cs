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
    public class CD_Reporte
    {
        public Dashboard VerDashboard()
        {
            Dashboard objeto = new Dashboard();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    SqlCommand cmd = new SqlCommand("sp_ReporteDashboard", oconexion);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {

                            objeto = new Dashboard()
                            {
                                totalCliente = Convert.ToInt32(dr["TotalCliente"]),
                                totalVenta = Convert.ToInt32(dr["TotalVenta"]),
                                totalProducto = Convert.ToInt32(dr["TotalProducto"])
                            };
                        }
                    }
                }
            }
            catch (AccessViolationException ave)
            {
                //string error = ex.Message;
                Console.WriteLine("Error" + ave.Message);
                objeto = new Dashboard();
            }

            return objeto;
        }

        public List<Reporte> Ventas(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> lista = new List<Reporte>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    SqlCommand cmd = new SqlCommand("sp_ReporteVentas", oconexion);

                    cmd.Parameters.AddWithValue("fechaInicio", fechaInicio);
                    cmd.Parameters.AddWithValue("fechaFin", fechaFin);
                    cmd.Parameters.AddWithValue("idTransaccion", idTransaccion);

                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Reporte()
                                {
                                    fechaVenta = dr["FechaVenta"].ToString(),
                                    cliente = dr["Cliente"].ToString(),
                                    producto = dr["Producto"].ToString(),
                                    precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                    cantidad = Convert.ToInt32(dr["cantidad"].ToString()),
                                    total = Convert.ToDecimal(dr["total"], new CultureInfo("es-AR")),
                                    idTransaccion = dr["idTransaccion"].ToString()
                                });
                        }
                    }
                }
            }
            catch (AccessViolationException ave)
            {
                //string error = ex.Message;
                Console.WriteLine("Error" + ave.Message);
                lista = new List<Reporte>();
            }

            return lista;
        }
    }
}
