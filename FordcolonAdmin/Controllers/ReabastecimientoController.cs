using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CapaEntidad;
using CapaNegocio;
using Newtonsoft.Json;

namespace FordcolonAdmin.Controllers
{
    public class ReabastecimientoController : Controller
    {
        // GET: Reabastecimiento
        public ActionResult Pedidos()
        {
            return View();
        }

        [HttpGet]
        public JsonResult ListarPedidos()
        {
            List<Pedidos> oLista = new List<Pedidos>();

            oLista = new CN_Pedidos().ListarPedidos();

            return Json(new { data = oLista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GuardarPedido(Pedidos obj)
        {
            
            object Pedido = new CN_Pedidos().RegistrarPedido(obj);

            return Json(new { Pedido = Pedido }, JsonRequestBehavior.AllowGet);

        }



    }
}