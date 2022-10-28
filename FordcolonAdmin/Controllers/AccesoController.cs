using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CapaEntidad;
using CapaNegocio;
using System.Web.Security;

namespace FordcolonAdmin.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CambiarClave()
        {
            return View();
        }

        public ActionResult ReestablecerClave()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(string correo, string clave)
        {

            Usuario oUsuario = new Usuario();

            oUsuario = new CN_Usuarios().Listar().Where(u => u.correo == correo && u.clave == CN_Recursos.ConvertirSHA256(clave)).FirstOrDefault();

            if (oUsuario == null)
            {

                ViewBag.Error = "Correo o Contraseña no existentes";
                return View();
            }
            else
            {

                if (oUsuario.reestablecer)
                {

                    TempData["idUsuario"] = oUsuario.idUsuario;

                    return RedirectToAction("CambiarClave");
                }

                FormsAuthentication.SetAuthCookie(oUsuario.correo, false);

                ViewBag.Error = null;

                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        [HttpPost]
        public ActionResult CambiarClave(string idUsuario, string claveActual, string nuevaClave, string confirmarClave)
        {
            
            Usuario oUsuario = new Usuario();

            oUsuario = new CN_Usuarios().Listar().Where(u => u.idUsuario == int.Parse(idUsuario)).FirstOrDefault();

            if (oUsuario.clave != CN_Recursos.ConvertirSHA256(claveActual))
            {
                TempData["idUsuario"] = idUsuario;
                ViewData["vclave"] = "";
                ViewBag.Error = "La contraseña actual no es correcta";
                return View();
            }
            else if (nuevaClave != confirmarClave)
            {
                TempData["idUsuario"] = idUsuario;
                ViewData["vclave"] = claveActual;
                ViewBag.Error = "Las contraseñas no coinciden";
                return View();
            }

            ViewData["vclave"] = "";

            nuevaClave = CN_Recursos.ConvertirSHA256(nuevaClave);

            string mensaje = string.Empty;

            bool respuesta = new CN_Usuarios().CambiarClave(int.Parse(idUsuario),nuevaClave,out mensaje);

            if (respuesta)
            {
                return RedirectToAction("Index");
            }
            else
            {
                TempData["idUsuario"] = idUsuario;
                ViewBag.Error = mensaje;
                return View();

            }

        }

        [HttpPost]
        public ActionResult ReestablecerClave(string correo)
        {
            Usuario oUsuario = new Usuario();

            oUsuario = new CN_Usuarios().Listar().Where(item => item.correo == correo).FirstOrDefault();

            if (oUsuario == null)
            {
                ViewBag.Error = "No se encontro un usuario relacionado a ese correo";

                return View();
            }

            string mensaje = string.Empty;
            bool respuesta = new CN_Usuarios().ReestablecerClave(oUsuario.idUsuario, correo, out mensaje);

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

        public ActionResult CerrarSesion()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Acceso");
        }
    }
}