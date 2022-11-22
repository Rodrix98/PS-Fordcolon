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
    public class CD_Cliente
    {

        public List<Cliente> ListarCliente()
        {
            List<Cliente> lista = new List<Cliente>();

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "SELECT idCliente, nombre, apellido, correo, clave, reestrablecer, aceptoCopy FROM Cliente";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.CommandType = CommandType.Text;

                    oconexion.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            lista.Add(
                                new Cliente()
                                {
                                    idCliente = Convert.ToInt32(dr["idCliente"]),
                                    nombre = dr["nombre"].ToString(),
                                    apellido = dr["apellido"].ToString(),
                                    correo = dr["correo"].ToString(),
                                    clave = dr["clave"].ToString(),
                                    reestablecer = Convert.ToBoolean(dr["reestrablecer"]),
                                    aceptoCopy = Convert.ToBoolean(dr["aceptoCopy"])
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
                lista = new List<Cliente>();
            }

            return lista;
        }

        public int RegistrarCliente(Cliente obj, out string Mensaje)
        {
            int idAutoGenerado = 0;
            Mensaje = string.Empty;

            try
            {

                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_RegistrarCliente", oconexion);
                    cmd.Parameters.AddWithValue("nombre", obj.nombre);
                    cmd.Parameters.AddWithValue("apellido", obj.apellido);
                    cmd.Parameters.AddWithValue("correo", obj.correo);
                    cmd.Parameters.AddWithValue("clave", obj.clave);
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

        public bool CambiarClave(int idCliente, string nuevaClave, out string Mensaje)
        {

            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Cliente set clave = @nuevaClave, reestrablecer = 0 WHERE idCliente = @id", oconexion);
                    cmd.Parameters.AddWithValue("@id", idCliente);
                    cmd.Parameters.AddWithValue("@nuevaClave", nuevaClave);
                    cmd.CommandType = CommandType.Text;
                    oconexion.Open();
                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;
                }
            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);
            }
            return resultado;
        }

        public bool ReestablecerClave(int idCliente, string clave, out string Mensaje)
        {

            bool resultado = false;
            Mensaje = string.Empty;

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Cliente set clave = @clave, reestrablecer = 1 WHERE idCliente = @id", oconexion);
                    cmd.Parameters.AddWithValue("@id", idCliente);
                    cmd.Parameters.AddWithValue("@clave", clave);
                    cmd.CommandType = CommandType.Text;
                    oconexion.Open();
                    resultado = cmd.ExecuteNonQuery() > 0 ? true : false;
                }
            }
            catch (AccessViolationException ave)
            {
                resultado = false;
                Console.WriteLine("Error" + ave.Message);
            }
            return resultado;
        }

        public void ConfirmarCopyright(string correo)
        {

            try
            {
                using (SqlConnection oconexion = new SqlConnection(Conexion.cn))
                {
                    string query = "sp_AceptarCopyCliente";

                    SqlCommand cmd = new SqlCommand(query, oconexion);
                    cmd.Parameters.AddWithValue("correo", correo);
                    cmd.CommandType = CommandType.StoredProcedure;

                    oconexion.Open();

                    cmd.ExecuteNonQuery();
                }
            }
            catch (AccessViolationException ave)
            {
                //string error = ex.Message;
                Console.WriteLine("Error" + ave.Message);
            }

        }

    }
}
