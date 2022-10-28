using CapaEntidad;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace FordcolonTienda.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult RegistrarCliente()
        {
            return View();
        }

        public ActionResult ReestablecerClave()
        {
            return View();
        }

        public ActionResult CambiarClave()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegistrarCliente(Cliente objeto)
        {

            int resultado;
            string mensaje = string.Empty;

            ViewData["nombre"] = string.IsNullOrEmpty(objeto.nombre) ? "" : objeto.nombre;
            ViewData["apellido"] = string.IsNullOrEmpty(objeto.apellido) ? "" : objeto.apellido;
            ViewData["correo"] = string.IsNullOrEmpty(objeto.correo) ? "" : objeto.correo;

            if (objeto.clave != objeto.confirmarClave)
            {

                ViewBag.Error = "Las contraseñas no coinciden";
                return View();
            }

            resultado = new CN_Cliente().RegistrarCliente(objeto, out mensaje);

            if (resultado > 0)
            {
                ViewBag.Error = null;
                return RedirectToAction("Index", "Acceso");
            }
            else
            {
                ViewBag.Error = mensaje;
                return View();
            }
        }

        [HttpPost]
        public ActionResult Index(string correo, string clave)
        {
            Cliente oCliente = null;

            oCliente = new CN_Cliente().Listar().Where(item => item.correo == correo && item.clave == CN_Recursos.ConvertirSHA256(clave)).FirstOrDefault();

            if (oCliente == null)
            {

                ViewBag.Error = "Correo o contraseña incorrectas";
                return View();
            }
            else
            {

                if (oCliente.reestablecer)
                {

                    TempData["idCliente"] = oCliente.idCliente;
                    return RedirectToAction("CambiarClave", "Acceso");
                }
                else
                {

                    FormsAuthentication.SetAuthCookie(oCliente.correo, false);

                    Session["Cliente"] = oCliente;

                    ViewBag.Error = null;

                    return RedirectToAction("Index", "Tienda"); 
                }
            }

            
        }

        [HttpPost]
        public ActionResult ReestablecerClave(string correo)
        {
            Cliente oCliente = new Cliente();

            oCliente = new CN_Cliente().Listar().Where(item => item.correo == correo).FirstOrDefault();

            if (oCliente == null)
            {
                ViewBag.Error = "No se encontro un cliente relacionado a ese correo";

                return View();
            }

            string mensaje = string.Empty;
            bool respuesta = new CN_Cliente().ReestablecerClave(oCliente.idCliente, correo, out mensaje);

            if (respuesta)
            {
                ViewBag.Error = null;

                return RedirectToAction("Index", "Acceso");
            }
            else
            {
                ViewBag.Error = mensaje;

                return View();
            }
        }

        [HttpPost]
        public ActionResult CambiarClave(string idCliente, string claveActual, string nuevaClave, string confirmarClave)
        {

            Cliente oCliente = new Cliente();

            oCliente = new CN_Cliente().Listar().Where(u => u.idCliente == int.Parse(idCliente)).FirstOrDefault();

            if (oCliente.clave != CN_Recursos.ConvertirSHA256(claveActual))
            {
                TempData["idCliente"] = idCliente;
                ViewData["vclave"] = "";
                ViewBag.Error = "La contraseña actual no es correcta";
                return View();
            }
            else if (nuevaClave != confirmarClave)
            {
                TempData["idCliente"] = idCliente;
                ViewData["vclave"] = claveActual;
                ViewBag.Error = "Las contraseñas no coinciden";
                return View();
            }

            ViewData["vclave"] = "";

            nuevaClave = CN_Recursos.ConvertirSHA256(nuevaClave);

            string mensaje = string.Empty;

            bool respuesta = new CN_Cliente().CambiarClave(int.Parse(idCliente), nuevaClave, out mensaje);

            if (respuesta)
            {
                return RedirectToAction("Index");
            }
            else
            {
                
                TempData["idCliente"] = idCliente;
                ViewBag.Error = mensaje;
                return View();
            }
        }

        public ActionResult CerrarSesion()
        {
            Session["Cliente"] = null;
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Acceso");
        }
    }
}