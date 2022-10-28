using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

namespace CapaDatos
{
    public class CD_Carrito
    {
        public bool ExisteCarrito(int idCliente, int idProducto)
        {
            bool resultado = true;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_ExisteCarrito", oconexion);
                    cmd.Parameters.AddWithValue("idCliente", idCliente);
                    cmd.Parameters.AddWithValue("idProducto", idProducto);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                }

            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);

            }
            return resultado;
        }

        public bool OperacionCarrito(int idCliente, int idProducto, bool sumar, out string mensaje)
        {
            bool resultado = true;

            mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_OperacionCarrito", oconexion);
                    cmd.Parameters.AddWithValue("idCliente", idCliente);
                    cmd.Parameters.AddWithValue("idProducto", idProducto);
                    cmd.Parameters.AddWithValue("sumar", sumar);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                    mensaje = cmd.Parameters["mensaje"].Value.ToString();
                }

            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);

            }
            return resultado;
        }

        public int CantidadEnCarrito(int idCliente)
        {

            int resultado = 0;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("select count(*) from Carrito where idCliente = @idCliente", oconexion);
                    cmd.Parameters.AddWithValue("@idCliente", idCliente);
                    cmd.CommandType = CommandType.Text;
                    oconexion.Open();
                    resultado = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch (AccessViolationException ave)
            {
                resultado = 0;
                Console.WriteLine("Error" + ave.Message);
            }
            return resultado;
        }

        public List<Carrito> ListarProductosEnCarrito(int idCliente)
        {
            List<Carrito> lista = new List<Carrito>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    string query = "select * from fn_obtenerCarritoCliente(@idCliente)";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.Parameters.AddWithValue("@idCliente", idCliente);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Carrito()
                                {
                                    idProducto = new Producto()
                                    {
                                        idProducto = Convert.ToInt32(dr["idProducto"]),
                                        nombre = dr["nombre"].ToString(),
                                        precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                        rutaImagen = dr["rutaImagen"].ToString(),
                                        nombreImagen = dr["nombreImagen"].ToString(),
                                        idMarca = new Marca() { descripcion = dr["DesMarca"].ToString() }
                                    },
                                    
                                    cantidad = Convert.ToInt32(dr["cantidad"])
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
                lista = new List<Carrito>();
            }

            return lista;
        }

        public bool EliminarCarrito(int idCliente, int idProducto)
        {
            bool resultado = true;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarCarrito", oconexion);
                    cmd.Parameters.AddWithValue("idCliente", idCliente);
                    cmd.Parameters.AddWithValue("idProducto", idProducto);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                }

            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);

            }
            return resultado;
        }


    }
}
