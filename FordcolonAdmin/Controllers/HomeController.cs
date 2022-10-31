using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CapaEntidad;
using CapaNegocio;
using ClosedXML.Excel;
using FordcolonAdmin.Models;

namespace FordcolonAdmin.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Usuarios()
        {
            return View();
        }

        [HttpGet]
        public JsonResult ListarUsuarios()
        {
            List<Usuario> oLista = new List<Usuario>();

            oLista = new CN_Usuarios().Listar();

            return Json(new { data = oLista}, JsonRequestBehavior.AllowGet);
        }
        
        [HttpPost]
        public JsonResult GuardarUsuario(Usuario obj)
        {
            object resultado;
            string mensaje = string.Empty;

            if (obj.idUsuario == 0)
            {
                resultado = new CN_Usuarios().RegistrarUsuario(obj, out mensaje);

            }
            else
            {
                resultado = new CN_Usuarios().EditarUsuario(obj, out mensaje);
            }

            return Json(new { resultado = resultado, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EliminarUsuario(int id)
        {
            bool respuesta = false;
            string mensaje = string.Empty;

            respuesta = new CN_Usuarios().EliminarUsuario(id, out mensaje);

            return Json(new { resultado = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ListaReporte(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> oLista = new List<Reporte>();

            oLista = new CN_Reporte().Ventas(fechaInicio, fechaFin, idTransaccion);

            return Json(new { data = oLista }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public JsonResult VistaDashboard()
        {
            Dashboard objeto = new CN_Reporte().VerDashboard();

            return Json(new { resultado = objeto }, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public FileResult ExportarVenta(string fechaInicio, string fechaFin, string idTransaccion)
        {
            List<Reporte> oLista = new List<Reporte>();
            oLista = new CN_Reporte().Ventas(fechaInicio, fechaFin, idTransaccion);

            DataTable dt = new DataTable();

            dt.Locale = new System.Globalization.CultureInfo("es-AR");
            dt.Columns.Add("FechaVenta", typeof(string));
            dt.Columns.Add("Cliente", typeof(string));
            dt.Columns.Add("Producto", typeof(string));
            dt.Columns.Add("precio", typeof(decimal));
            dt.Columns.Add("cantidad", typeof(int));
            dt.Columns.Add("total", typeof(decimal));
            dt.Columns.Add("idTransaccion", typeof(string));

            foreach (Reporte rp in oLista)
            {
                dt.Rows.Add(new object[] {
                    rp.fechaVenta,
                    rp.cliente,
                    rp.producto,
                    rp.precio,
                    rp.cantidad,
                    rp.total,
                    rp.idTransaccion

                });
            }

            dt.TableName = "Datos";

            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt);
                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);
                    return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "ReporteVenta" + DateTime.Now.ToString() + ".xlsx");
                }
            }

        }

        [HttpGet]
        public JsonResult ReporteVentasporMes(string fechaInicio, string fechaFin)
        {
            Conexion c = new Conexion();

            List<ReporteVenta> lista = c.ReporteVentasSEGUNDO(fechaInicio,fechaFin);

            return Json(lista, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult ReporteProductosMasVendidos(int mes)
        {
            Conexion c = new Conexion();

            List<ReporteProducto> lista = c.ReporteCantidadProductos(mes);

            return Json(lista, JsonRequestBehavior.AllowGet);
        }
    }
}