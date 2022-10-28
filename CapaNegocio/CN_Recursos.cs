using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;
using System.IO;

namespace CapaNegocio
{
    public class CN_Recursos
    {

        public static string generarClave()
        {
            string clave = Guid.NewGuid().ToString("N").Substring(0, 6);
            return clave;
        }

        public static bool enviarCorreo(string correo, string asunto, string mensaje)
        {
            bool resultado = false;
            
            try
            {

                MailMessage mail = new MailMessage();

                mail.To.Add(correo);
                mail.From = new MailAddress("rodriwheels41@gmail.com");
                mail.Subject = asunto;
                mail.Body = mensaje;
                mail.IsBodyHtml = true;

                var smtp = new SmtpClient()
                {
                    Credentials = new NetworkCredential("rodriwheels41@gmail.com", "xjwjmsbhtsebamqa"),
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true
                };

                smtp.Send(mail);
                resultado = true;
            }
            catch (Exception ex)
            {
                resultado = false;
            }
            return resultado;
        }


        //encriptacion DE TEXTO en SHA256
        public static string ConvertirSHA256(string texto)
        {
            StringBuilder sb = new StringBuilder();
            //USAR LA REFERENCIA DE "System.Security.Cryptography"
            using(SHA256 hash = SHA256Managed.Create())
            {
                Encoding enc = Encoding.UTF8;
                byte[] result = hash.ComputeHash(enc.GetBytes(texto));

                foreach (byte b in result)
                {
                    sb.Append(b.ToString("x2"));
                }
            }
            return sb.ToString();
        }

        public static string ConvertirBase64(string ruta, out bool conversion)
        {

            string textoBase64 = string.Empty;
            conversion = true;

            try
            {

                byte[] bytes = File.ReadAllBytes(ruta); 
                textoBase64 = Convert.ToBase64String(bytes);

            }
            catch (Exception ex)
            {

                conversion = false;
            }

            return textoBase64;
        }

        public static string CadenaTransaccion()
        {
            Random random = new Random();

            int tamaño = 12;

            const string letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

            return new string(Enumerable.Repeat(letras, tamaño).Select(s => s[random.Next(s.Length)]).ToArray());

        }



    }
}
