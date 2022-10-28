using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FordcolonAdmin.Models
{
    public class Conexion
    {

        public static string cn = ConfigurationManager.ConnectionStrings["cadena"].ToString();

        public List<ReporteVenta> ReporteVentasPRIMERO()
        {
            List<ReporteVenta> lista = new List<ReporteVenta>();

            using (SqlConnection oconexion = new SqlConnection(cn))
            {
                string query = "sp_ReporteVentasPorMes";

                SqlCommand cmd = new SqlCommand(query, oconexion);
                cmd.CommandType = CommandType.StoredProcedure;

                oconexion.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(
                            new ReporteVenta
                            {
                                mes = dr["mes"].ToString(),
                                cantidad = Convert.ToInt32(dr["cantidad"].ToString()),
                                monto = dr["TotalMontoPorMes"].ToString()

                            }

                        );

                    }
                }

                return lista;
                
            }
        }

        public List<ReporteVenta> ReporteVentasSEGUNDO(string fechaInicio, string fechaFin)
        {
            List<ReporteVenta> lista = new List<ReporteVenta>();

            using (SqlConnection oconexion = new SqlConnection(cn))
            {
                string query = "sp_ReporteVentasPorMes";

                SqlCommand cmd = new SqlCommand(query, oconexion);
                cmd.Parameters.AddWithValue("fechaInicio", fechaInicio);
                cmd.Parameters.AddWithValue("fechaFin", fechaFin);
                cmd.CommandType = CommandType.StoredProcedure;

                oconexion.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(
                            new ReporteVenta
                            {
                                mes = dr["mes"].ToString(),
                                cantidad = Convert.ToInt32(dr["cantidad"].ToString()),
                                monto = dr["TotalMontoPorMes"].ToString()

                            }

                        );

                    }
                }

                return lista;

            }
        }

        public List<ReporteProducto> ReporteCantidadProductos(string fechaInicio, string fechaFin)
        {
            List<ReporteProducto> lista = new List<ReporteProducto>();

            using (SqlConnection oconexion = new SqlConnection(cn))
            {
                string query = "sp_ReporteCantidadProductosPorMes";

                SqlCommand cmd = new SqlCommand(query, oconexion);
                cmd.Parameters.AddWithValue("fechaInicio", fechaInicio);
                cmd.Parameters.AddWithValue("fechaFin", fechaFin);
                cmd.CommandType = CommandType.StoredProcedure;

                oconexion.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(
                            new ReporteProducto
                            {
                                producto = dr["nombre"].ToString(),
                                cantidad = Convert.ToInt32(dr["CantidadProductos"].ToString()),
                            }

                        );

                    }
                }

                return lista;

            }
        }

    }
}