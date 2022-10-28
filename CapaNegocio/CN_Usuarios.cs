using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Usuarios
    {
        private CD_Usuarios objCapaDato = new CD_Usuarios();

        public List<Usuario> Listar()
        {
            return objCapaDato.Listar();
        }

        public int RegistrarUsuario(Usuario obj, out string Mensaje)
        {

            Mensaje = string.Empty;
            
            if (string.IsNullOrEmpty(obj.nombre) || string.IsNullOrWhiteSpace(obj.nombre))
            {
                Mensaje = "El nombre del usuario no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.apellido) || string.IsNullOrWhiteSpace(obj.apellido))
            {
                Mensaje = "El apellido del usuario no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.correo) || string.IsNullOrWhiteSpace(obj.correo))
            {
                Mensaje = "El correo del usuario no puede ser vacio";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                string clave = CN_Recursos.generarClave();

                string asunto = "Creacion de Cuenta";
                string mensajeCorreo = "<h3>Su cuenta fue creada correctamente<h3></br><p>Su contraseña para acceder es: !clave!</p>";
                mensajeCorreo = mensajeCorreo.Replace("!clave!", clave);

                bool respuesta = CN_Recursos.enviarCorreo(obj.correo, asunto, mensajeCorreo);

                if (respuesta)
                {
                    
                    obj.clave = CN_Recursos.ConvertirSHA256(clave);
                    return objCapaDato.RegistrarUsuario(obj, out Mensaje);
                }
                else
                {
                    Mensaje = "No se puede enviar el correo";
                    return 0;
                }

            }
            else
            {
                return 0;
            }

            
        }

        public bool EditarUsuario(Usuario obj, out string Mensaje)
        {
            
            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.nombre) || string.IsNullOrWhiteSpace(obj.nombre))
            {
                Mensaje = "El nombre del usuario no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.apellido) || string.IsNullOrWhiteSpace(obj.apellido))
            {
                Mensaje = "El apellido del usuario no puede ser vacio";
            }
            else if (string.IsNullOrEmpty(obj.correo) || string.IsNullOrWhiteSpace(obj.correo))
            {
                Mensaje = "El correo del usuario no puede ser vacio";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDato.EditarUsuario(obj, out Mensaje);
            }
            else
            {
                return false;
            }
        }

        public bool EliminarUsuario(int id, out string Mensaje)
        {
            return objCapaDato.EliminarUsuario(id, out Mensaje);
        }

        public bool CambiarClave(int idUsuario, string nuevaClave, out string Mensaje)
        {
            return objCapaDato.CambiarClave(idUsuario, nuevaClave, out Mensaje);
        }

        public bool ReestablecerClave(int idUsuario, string correo, out string Mensaje)
        {

            Mensaje = string.Empty;

            string nuevaClave = CN_Recursos.generarClave();
            bool resultado = objCapaDato.ReestablecerClave(idUsuario, CN_Recursos.ConvertirSHA256(nuevaClave), out Mensaje);
            
            if (resultado)
            {

                string asunto = "Contraseña Reestablecida";
                string mensajeCorreo = "<h3>Su cuenta fue reestablecida correctamente<h3></br><p>Su nueva contraseña para acceder es: !clave!</p>";
                mensajeCorreo = mensajeCorreo.Replace("!clave!", nuevaClave);

                bool respuesta = CN_Recursos.enviarCorreo(correo, asunto, mensajeCorreo);

                if (respuesta)
                {

                    return true;
                }
                else
                {
                    Mensaje = "No se pudo enviar el correo";
                    return false;
                }
            }
            else
            {
                Mensaje = "No se pudo reestablecer la contraseña";
                return false;
            }
        }
    }
}
