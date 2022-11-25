using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CapaEntidad;
using CapaNegocio;
using System.IO;
using System.Threading.Tasks;
using System.Data;
using System.Globalization;
using Rotativa;
using FordcolonTienda.Models.ViewModel;
using FordcolonTienda.Filter;
using System.Net.Mail;
using System.Net;

namespace FordcolonTienda.Controllers
{
    public class TiendaController : Controller
    {
        // GET: Tienda
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DetalleProducto(int idProducto = 0)
        {
            
            Producto oProducto = new Producto();
            bool conversion;

            oProducto = new CN_Producto().ListarProductos().Where(p => p.idProducto == idProducto).FirstOrDefault();

            if (oProducto != null)
            {
                oProducto.Base64 = CN_Recursos.ConvertirBase64(Path.Combine(oProducto.rutaImagen, oProducto.nombreImagen), out conversion);
                oProducto.Extension = Path.GetExtension(oProducto.nombreImagen);
            }

            
            return View(oProducto);
        }

        [HttpGet]
        public JsonResult ListarMarcas()
        {
            List<Marca> lista = new List<Marca>();

            lista = new CN_Marca().ListarMarcas();

            return Json(new { data = lista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ListarModeloPorMarca (int idMarca)
        {
            List<Categoria> lista = new List<Categoria>();

            lista = new CN_Categoria().ListarModeloPorMarca(idMarca);

            return Json(new { data = lista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ListarProductos(int idCategoria, int idMarca)
        {
            List<Producto> lista = new List<Producto>();

            bool conversion;

            lista = new CN_Producto().ListarProductos().Select(p => new Producto()
            {

                idProducto = p.idProducto,
                nombre = p.nombre,
                descripcion = p.descripcion,
                idMarca = p.idMarca,
                idCategoria = p.idCategoria,
                precio = p.precio,
                stock = p.stock,
                rutaImagen = p.rutaImagen,
                Base64 = CN_Recursos.ConvertirBase64(Path.Combine(p.rutaImagen, p.nombreImagen), out conversion),
                Extension = Path.GetExtension(p.nombreImagen),
                activo = p.activo

            }).Where(p =>

                p.idCategoria.idCategoria == (idCategoria == 0 ? p.idCategoria.idCategoria : idCategoria) &&
                p.idMarca.idMarca == (idMarca == 0 ? p.idMarca.idMarca : idMarca) /*&&
                p.stock > 0 */ && p.activo == true

            ).OrderBy(p => p.nombre).ToList();

            var jsonresult = Json(new { data = lista }, JsonRequestBehavior.AllowGet);

            jsonresult.MaxJsonLength = int.MaxValue;

            return jsonresult;
        }

        public JsonResult BuscarProductos(string valor)
        {
            List<Producto> lista = new List<Producto>();

            bool conversion;

            lista = new CN_Producto().BuscarProducto(valor).Select(p => new Producto()
            {

                idProducto = p.idProducto,
                nombre = p.nombre,
                descripcion = p.descripcion,
                idMarca = p.idMarca,
                idCategoria = p.idCategoria,
                precio = p.precio,
                stock = p.stock,
                rutaImagen = p.rutaImagen,
                Base64 = CN_Recursos.ConvertirBase64(Path.Combine(p.rutaImagen, p.nombreImagen), out conversion),
                Extension = Path.GetExtension(p.nombreImagen),
                activo = p.activo

            }).Where(p =>

                p.activo == true

            ).ToList();

            var jsonresult = Json(new { data = lista }, JsonRequestBehavior.AllowGet);

            jsonresult.MaxJsonLength = int.MaxValue;

            return jsonresult;
        }

        [HttpPost]
        public JsonResult AgregarCarrito(int idProducto)
        {

            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            bool existe = new CN_Carrito().ExisteCarrito(idCliente, idProducto);

            bool respuesta = false;

            string mensaje = string.Empty;

            if (existe)
            {
                mensaje = "El producto ya existe en el carrito";

            }
            else
            {

                respuesta = new CN_Carrito().OperacionCarrito(idCliente, idProducto, true, out mensaje);
            }

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);

        }

        [HttpGet]
        public JsonResult CantidadEnCarrito()
        {
            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            int cantidad = new CN_Carrito().CantidadEnCarrito(idCliente);

            return Json(new { cantidad = cantidad }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ListarProductosEnCarrito()
        {
            
            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            List<Carrito> oLista = new List<Carrito>();

            bool conversion;

            oLista = new CN_Carrito().ListarProductosEnCarrito(idCliente).Select(oc => new Carrito()
            {

                idProducto = new Producto()
                {

                    idProducto = oc.idProducto.idProducto,
                    nombre = oc.idProducto.nombre,
                    idMarca = oc.idProducto.idMarca,
                    precio = oc.idProducto.precio,
                    rutaImagen = oc.idProducto.rutaImagen,
                    Base64 = CN_Recursos.ConvertirBase64(Path.Combine(oc.idProducto.rutaImagen, oc.idProducto.nombreImagen), out conversion),
                    Extension = Path.GetExtension(oc.idProducto.nombreImagen)

                },
                cantidad = oc.cantidad

            }).ToList();

            return Json(new { data = oLista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult OperacionCarrito(int idProducto, bool sumar)
        {

            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            bool respuesta = false;

            string mensaje = string.Empty;

            respuesta = new CN_Carrito().OperacionCarrito(idCliente, idProducto, sumar, out mensaje);

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public JsonResult EliminarCarrito(int idProducto)
        {
           
            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            bool respuesta = false;

            string mensaje = string.Empty;

            respuesta = new CN_Carrito().EliminarCarrito(idCliente, idProducto);

            return Json(new { respuesta = respuesta, mensaje = mensaje }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerDepartamento(string idProvincia)
        {
            List<Departamento> oLista = new List<Departamento>();

            oLista = new CN_Ubicacion().ObtenerDepartamentos(idProvincia);

            return Json(new { lista = oLista },JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerProvincia()
        {
            List<Provincia> oLista = new List<Provincia>();

            oLista = new CN_Ubicacion().ObtenerProvincias();

            return Json(new { lista = oLista }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerPais(string idDepartamento, string idProvincia)
        {
            List<Pais> oLista = new List<Pais>();

            oLista = new CN_Ubicacion().ObtenerPais(idDepartamento, idProvincia);

            return Json(new { lista = oLista }, JsonRequestBehavior.AllowGet);
        }

        [ValidarSession]
        [Authorize]
        public ActionResult Carrito()
        {
            return View();
        }

        [HttpPost]
        public async Task<JsonResult> ProcesarPago(List<Carrito> oListaCarrito, Venta oVenta, string Localidad, string CodigoPostal, int Provincia)
        {
            decimal total = 0;

            DataTable detalleVenta = new DataTable();

            detalleVenta.Locale = new CultureInfo("es-AR");

            detalleVenta.Columns.Add("idProducto", typeof(string));
            detalleVenta.Columns.Add("Cantidad", typeof(int));
            detalleVenta.Columns.Add("Total", typeof(decimal));

            foreach (Carrito oCarrito in oListaCarrito)
            {
                decimal subtotal = Convert.ToDecimal(oCarrito.cantidad.ToString()) * oCarrito.idProducto.precio;

                total += subtotal;
                
                detalleVenta.Rows.Add(new object[]
                {
                    oCarrito.idProducto.idProducto,
                    oCarrito.cantidad,
                    subtotal

                });

            }

            oVenta.montoTotal = total;
            oVenta.idCliente = ((Cliente)Session["Cliente"]).idCliente;

            TempData["Venta"] = oVenta;
            TempData["DetalleVenta"] = detalleVenta;
            TempData["Localidad"] = Localidad;
            TempData["CodigoPostal"] = CodigoPostal;

            CN_Ubicacion objeto = new CN_Ubicacion();

            string nombreProvincia = objeto.ObtenerProvinciasPorID(Provincia);

            TempData["Provincia"] = nombreProvincia;

            return Json(new {Status = true, Link = "/Tienda/PagoEfectuado?idTransaccion=" + CN_Recursos.CadenaTransaccion() + "&status=true" + "&localidad=" + Localidad + "&codigo=" + CodigoPostal + "&provincia=" + nombreProvincia}, JsonRequestBehavior.AllowGet);

        }

        [ValidarSession]
        [Authorize]
        public async Task<ActionResult> PagoEfectuado()
        {
            string idTransaccion = Request.QueryString["idTransaccion"];
            bool status = Convert.ToBoolean(Request.QueryString["status"]);
            string Localidad = Request.QueryString["localidad"];
            string CodigoPostal = Request.QueryString["codigo"];
            string Provincia = Request.QueryString["provincia"];

            ViewData["Status"] = status;

            //Venta oVenta = (Venta)TempData["Venta"];

            if (status)
            {
                Venta oVenta = (Venta)TempData["Venta"];

                DataTable detalleVenta = (DataTable)TempData["DetalleVenta"];

                oVenta.idTransaccion = idTransaccion;

                string Mensaje = string.Empty;

                bool respuesta = new CN_Venta().RegistrarVenta(oVenta, detalleVenta, out Mensaje);

                ViewData["idTransaccion"] = oVenta.idTransaccion;

                ViewData["Localidad"] = Localidad;

                ViewData["CodigoPostal"] = CodigoPostal;

                ViewData["Provincia"] = Provincia;
            }

            //TempData["idTransaccion"] = oVenta.idTransaccion;

            //TempData["Localidad"] = Localidad;

            //TempData["CodigoPostal"] = CodigoPostal;

            //TempData["Provincia"] = Provincia;

            ////correo

            //var GenerarPDF = new Rotativa.ActionAsPdf("ImprimirComprobante")
            //{
            //    FileName = "Comprobante " + oVenta.idTransaccion
            //};

            //var pdfAsBytes = GenerarPDF.BuildFile(this.ControllerContext);

            //var msgTitle = "Comprobante de compra " + oVenta.idTransaccion + ".pdf";

            //var OrderConfirmation = "Su Compra se ha realizado con exito.<br />" +
            //                        " Le Dejamos adjunto su comprobante de compra: ";

            //using (MailMessage mail = new MailMessage())
            //{
            //    mail.From = new MailAddress("rodriwheels41@gmail.com");
            //    mail.To.Add("rodriwheels41@gmail.com");
            //    mail.Subject = msgTitle;
            //    mail.Body = OrderConfirmation;
            //    mail.IsBodyHtml = true;
            //    //STREAM THE CONVERTED BYTES AS ATTACHMENT HERE
            //    mail.Attachments.Add(new Attachment(new MemoryStream(pdfAsBytes), "Comprobante.pdf"));

            //    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
            //    {
            //        smtp.Credentials = new NetworkCredential("rodriwheels41@gmail.com", "odwafelocmmwchec");
            //        smtp.EnableSsl = true;
            //        smtp.Send(mail);
            //    }
            //}

            return View();
        }

        public ActionResult ImprimirComprobante()
        {

            string idTransaccion = (TempData["idTransaccion"]).ToString();
            string Localidad = (TempData["Localidad"]).ToString();
            string CodigoPostal = (TempData["CodigoPostal"]).ToString();
            string Provincia = (TempData["Provincia"]).ToString();

            List<ComprobanteCompra2> oLista = new List<ComprobanteCompra2>();

            oLista = new Conexion().GenerarComprobante(idTransaccion).Select(oc => new ComprobanteCompra2()
            {

                nombreProducto = oc.nombreProducto,
                cantidad = oc.cantidad,
                precio = oc.precio,
                contacto = oc.contacto,
                idTransaccion = oc.idTransaccion,
                fechaVenta = oc.fechaVenta,
                montoTotal = oc.montoTotal,
                direccion = oc.direccion,
                localidad = Localidad,
                codigoPostal = CodigoPostal,
                provincia = Provincia

            }).ToList();

            foreach (var item in oLista)
            {
                ViewBag.Contacto = item.contacto;
                ViewBag.idTransaccion = item.idTransaccion;
                ViewBag.fechaVenta = item.fechaVenta;
                ViewBag.montoTotal = item.montoTotal;
                ViewBag.direccion = item.direccion;
                ViewBag.localidad = item.localidad;
                ViewBag.codigoPostal = item.codigoPostal;
                ViewBag.provincia = item.provincia;
            }


            return new ViewAsPdf("ImprimirComprobante", oLista)
            {
                FileName = $"Comprobante {idTransaccion}.pdf",
                PageOrientation = Rotativa.Options.Orientation.Portrait,
                PageSize = Rotativa.Options.Size.A4

            };
        }

        [ValidarSession]
        [Authorize]
        public ActionResult MisCompras()
        {
            int idCliente = ((Cliente)Session["Cliente"]).idCliente;

            List<Detalle_Venta> oLista = new List<Detalle_Venta>();

            bool conversion;

            oLista = new CN_Venta().ListarCompras(idCliente).Select(oc => new Detalle_Venta()
            {

                idProducto = new Producto()
                {
                    nombre = oc.idProducto.nombre,
                    precio = oc.idProducto.precio,
                    Base64 = CN_Recursos.ConvertirBase64(Path.Combine(oc.idProducto.rutaImagen, oc.idProducto.nombreImagen), out conversion),
                    Extension = Path.GetExtension(oc.idProducto.nombreImagen)

                },
                cantidad = oc.cantidad,
                total = oc.total,
                idTransaccion = oc.idTransaccion,
                fechaVenta = oc.fechaVenta,
                idVenta = oc.idVenta,

            }).OrderByDescending(oc => oc.idVenta).ToList();

            return View(oLista);
        }

        public ActionResult Contacto()
        {
            return View();
        }

    }
}