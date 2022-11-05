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

        [HttpGet]
        public JsonResult ListarProductosPEDIDOS(string search)
        {
            List<Producto> lista = new List<Producto>();

            lista = new CN_Producto().ListarProductos().Where(p => p.nombre.Contains(search)).Select(p => new Producto()
            {
                idProducto = p.idProducto,
                nombre = p.nombre

            }).ToList();

            return new JsonResult { Data = lista, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

    }
}