using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Producto
    {

        private CD_Producto objCapaDato = new CD_Producto();

        public List<Producto> ListarProductos()
        {
            return objCapaDato.ListarProductos();  
        }

        public List<Producto> BuscarProducto(string valor)
        {
            return objCapaDato.BuscarProductos(valor);
        }

        public int RegistrarProducto(Producto obj, out string Mensaje)
        {

            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.nombre) || string.IsNullOrWhiteSpace(obj.nombre))
            {
                Mensaje = "El nombre del producto no puede estar vacio";
            }
            else if (string.IsNullOrEmpty(obj.descripcion) || string.IsNullOrWhiteSpace(obj.descripcion))
            {
                Mensaje = "La descripcion del producto no puede estar vacio";
            }
            else if (obj.idMarca.idMarca == 0)
            {
                Mensaje = "Debe seleccionar una marca";
            }
            else if (obj.idCategoria.idCategoria == 0)
            {
                Mensaje = "Debe seleccionar una categoria";
            }
            else if (obj.precio == 0)
            {
                Mensaje = "Debe ingresar el precio del producto";
            }
            else if (obj.stock == 0)
            {
                Mensaje = "Debe ingresar el stock del producto";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {

                return objCapaDato.RegistrarProducto(obj, out Mensaje);
            }
            else
            {
                return 0;
            }
        }

        public bool EditarProducto(Producto obj, out string Mensaje)
        {

            Mensaje = string.Empty;

            if (string.IsNullOrEmpty(obj.nombre) || string.IsNullOrWhiteSpace(obj.nombre))
            {
                Mensaje = "El nombre del producto no puede estar vacio";
            }
            else if (string.IsNullOrEmpty(obj.descripcion) || string.IsNullOrWhiteSpace(obj.descripcion))
            {
                Mensaje = "La descripcion del producto no puede estar vacio";
            }
            else if (obj.idMarca.idMarca == 0)
            {
                Mensaje = "Debe seleccionar una marca";
            }
            else if (obj.idCategoria.idCategoria == 0)
            {
                Mensaje = "Debe seleccionar una categoria";
            }
            else if (obj.precio == 0)
            {
                Mensaje = "Debe ingresar el precio del producto";
            }
            else if (obj.stock == 0)
            {
                Mensaje = "Debe ingresar el stock del producto";
            }

            if (string.IsNullOrEmpty(Mensaje))
            {
                return objCapaDato.EditarProducto(obj, out Mensaje);
            }
            else
            {
                return false;
            }
        }

        public bool GuardarDatosImagen(Producto obj, out string Mensaje )
        {
            return objCapaDato.GuardarDatosImagen(obj, out Mensaje);
        }

        public bool EliminarProducto(int id, out string Mensaje)
        {
            return objCapaDato.EliminarProducto(id, out Mensaje);
        }

    }
}
