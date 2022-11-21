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
    public class CD_Producto
    {
        public List<Producto> ListarProductos()
        {
            List<Producto> lista = new List<Producto>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    StringBuilder sb = new StringBuilder();

                    sb.AppendLine("select p.idProducto, p.nombre, p.descripcion,");
                    sb.AppendLine("m.idMarca, m.descripcion [desMarca],");
                    sb.AppendLine("c.idCategoria, c.descripcion [desCategoria],");
                    sb.AppendLine("p.precio, p.stock, p.rutaImagen, p.nombreImagen, p.activo");
                    sb.AppendLine("from Producto p inner join Marca m on m.idMarca = p.idMarca");
                    sb.AppendLine("inner join Categoria c on c.idCategoria = p.idCategoria");

                    SqlCommand cmd = new SqlCommand(sb.ToString(), oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Producto()
                                {
                                    idProducto = Convert.ToInt32(dr["idProducto"]),
                                    nombre = dr["nombre"].ToString(),
                                    descripcion = dr["descripcion"].ToString(),
                                    idMarca = new Marca() { idMarca = Convert.ToInt32(dr["idMarca"]), descripcion = dr["desMarca"].ToString() },
                                    idCategoria = new Categoria() { idCategoria = Convert.ToInt32(dr["idCategoria"]), descripcion = dr["desCategoria"].ToString() },
                                    precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                    stock = Convert.ToInt32(dr["stock"]),
                                    rutaImagen = dr["rutaImagen"].ToString(),
                                    nombreImagen = dr["nombreImagen"].ToString(),
                                    activo = Convert.ToBoolean(dr["activo"]),

                                    
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
                lista = new List<Producto>();
            }

            return lista;
        }

        public int RegistrarProducto(Producto obj, out string Mensaje)
        {
            int idAutoGenerado = 0;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistarProducto", oconexion);
                    cmd.Parameters.AddWithValue("nombre", obj.nombre);
                    cmd.Parameters.AddWithValue("descripcion", obj.descripcion);
                    //cmd.Parameters.AddWithValue("idMarca", obj.idMarca.idMarca);
                    cmd.Parameters.AddWithValue("idCategoria", obj.idCategoria.idCategoria);
                    cmd.Parameters.AddWithValue("precio", obj.precio);
                    cmd.Parameters.AddWithValue("stock", obj.stock);
                    cmd.Parameters.AddWithValue("activo", obj.activo);
                    cmd.Parameters.Add("resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    idAutoGenerado = Convert.ToInt32(cmd.Parameters["resultado"].Value);
                    Mensaje = cmd.Parameters["mensaje"].Value.ToString();
                }

            }
            catch (AccessViolationException ave)
            {
                idAutoGenerado = 0;
                Console.WriteLine("Error" + ave.Message);

            }
            return idAutoGenerado;
        }

        public bool EditarProducto(Producto obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EditarProducto", oconexion);
                    cmd.Parameters.AddWithValue("idProducto", obj.idProducto);
                    cmd.Parameters.AddWithValue("nombre", obj.nombre);
                    cmd.Parameters.AddWithValue("descripcion", obj.descripcion);
                    //cmd.Parameters.AddWithValue("idMarca", obj.idMarca.idMarca);
                    cmd.Parameters.AddWithValue("idCategoria", obj.idCategoria.idCategoria);
                    cmd.Parameters.AddWithValue("precio", obj.precio);
                    cmd.Parameters.AddWithValue("stock", obj.stock);
                    cmd.Parameters.AddWithValue("activo", obj.activo);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                    Mensaje = cmd.Parameters["mensaje"].Value.ToString();
                }

            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }

            return resultado;

        }


        public bool GuardarDatosImagen(Producto obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "update Producto set rutaImagen = @rutaImagen, nombreImagen = @nombreImagen where idProducto = @idProducto";

                    SqlCommand cmd = new SqlCommand(query, oconexion);

                    cmd.Parameters.AddWithValue("@rutaImagen", obj.rutaImagen);
                    cmd.Parameters.AddWithValue("@nombreImagen", obj.nombreImagen);
                    cmd.Parameters.AddWithValue("@idProducto", obj.idProducto);
                    cmd.Parameters.Add("resultado", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    if (cmd.ExecuteNonQuery() > 0 )
                    {
                        resultado = true;
                    }
                    else
                    {
                        Mensaje = "No se pudo actualizar la imagen";
                    }

                }

            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);

            }

            return resultado;
        }

        public bool EliminarProducto(int id, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarProducto", oconexion);
                    cmd.Parameters.AddWithValue("idProducto", id);
                    cmd.Parameters.Add("resultado", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("mensaje", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();

                    resultado = Convert.ToBoolean(cmd.Parameters["resultado"].Value);
                    Mensaje = cmd.Parameters["mensaje"].Value.ToString();
                }

            }
            catch (Exception ex)
            {
                resultado = false;
                Mensaje = ex.Message;
            }

            return resultado;

        }

        public List<Producto> BuscarProductos(string valor)
        {
            List<Producto> lista = new List<Producto>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    SqlCommand cmd = new SqlCommand("sp_BuscarProducto", oconexion);
                    cmd.Parameters.AddWithValue("valor", valor);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Producto()
                                {
                                    idProducto = Convert.ToInt32(dr["idProducto"]),
                                    nombre = dr["nombre"].ToString(),
                                    descripcion = dr["descripcion"].ToString(),
                                    idMarca = new Marca() { idMarca = Convert.ToInt32(dr["idMarca"]), descripcion = dr["desMarca"].ToString() },
                                    idCategoria = new Categoria() { idCategoria = Convert.ToInt32(dr["idCategoria"]), descripcion = dr["desCategoria"].ToString() },
                                    precio = Convert.ToDecimal(dr["precio"], new CultureInfo("es-AR")),
                                    stock = Convert.ToInt32(dr["stock"]),
                                    rutaImagen = dr["rutaImagen"].ToString(),
                                    nombreImagen = dr["nombreImagen"].ToString(),
                                    activo = Convert.ToBoolean(dr["activo"]),


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
                lista = new List<Producto>();
            }

            return lista;
        }

        public List<Marca> MarcaParaProducto(int idCategoria)
        {
            List<Marca> marca = new List<Marca>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    SqlCommand cmd = new SqlCommand("sp_MarcaParaProducto", oconexion);
                    cmd.Parameters.AddWithValue("idCategoria", idCategoria);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {

                            marca.Add(

                                new Marca()
                                {
                                    idMarca = Convert.ToInt32(dr["idMarca"]),
                                    descripcion = dr["descripcion"].ToString()
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
                marca = new List<Marca>();
            }

            return marca;
        }


    }
}
