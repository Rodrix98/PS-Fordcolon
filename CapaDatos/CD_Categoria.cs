using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidad;
using System.Data;
using System.Data.SqlClient;

namespace CapaDatos
{
    public class CD_Categoria
    {
        public List<Categoria> ListarModeloPorMarca(int idMarca)
        {
            List<Categoria> lista = new List<Categoria>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {

                    StringBuilder sb = new StringBuilder();

                    sb.AppendLine("select distinct c.idCategoria, c.descripcion FROM Producto p");
                    sb.AppendLine("inner join Marca m on m.idMarca = p.idMarca");
                    sb.AppendLine("inner join Categoria c on c.idCategoria = p.idCategoria and c.activo = 1");
                    sb.AppendLine("WHERE m.idMarca = iif(@idMarca = 0, m.idMarca, @idMarca)");

                    SqlCommand cmd = new SqlCommand(sb.ToString(), oconexion);
                    cmd.Parameters.AddWithValue("@idMarca", idMarca);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Categoria()
                                {
                                    idCategoria = Convert.ToInt32(dr["idCategoria"]),
                                    descripcion = dr["descripcion"].ToString(),
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
                lista = new List<Categoria>();
            }

            return lista;
        }

        public List<Categoria> ListarCategorias()
        {
            List<Categoria> lista = new List<Categoria>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "SELECT idCategoria, descripcion, activo, relacionMarca FROM Categoria";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Categoria()
                                {
                                    idCategoria = Convert.ToInt32(dr["idCategoria"]),
                                    descripcion = dr["descripcion"].ToString(),
                                    activo = Convert.ToBoolean(dr["activo"]),
                                    relacionMarca = dr["relacionMarca"].ToString(),
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
                lista = new List<Categoria>();
            }

            return lista;
        }

        public int RegistrarCategoria(Categoria obj, out string Mensaje)
        {
            int idAutoGenerado = 0;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarCategoria", oconexion);
                    cmd.Parameters.AddWithValue("descripcion", obj.descripcion);
                    cmd.Parameters.AddWithValue("activo", obj.activo);
                    cmd.Parameters.AddWithValue("relacionMarca", obj.relacionMarca);
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

        public bool EditarCategoria(Categoria obj, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EditarCategoria", oconexion);
                    cmd.Parameters.AddWithValue("idCategoria", obj.idCategoria);
                    cmd.Parameters.AddWithValue("descripcion", obj.descripcion);
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

        public bool EliminarCategoria(int id, out string Mensaje)
        {
            bool resultado = false;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_EliminarCategoria", oconexion);
                    cmd.Parameters.AddWithValue("idCategoria", id);
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
    }
}
