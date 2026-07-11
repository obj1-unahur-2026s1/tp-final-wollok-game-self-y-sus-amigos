import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object descuentoCofres inherits Mejora
{
    override method nombre()      = "descuento en cofres"
    override method descripcion() = "Otorga un descuento al precio de los cofres en la tienda"
    override method maximoAcumulacion() = 10

    override method aplicar()
    {
        gestorMejoras.descuentoCofres(gestorMejoras.descuentoCofres() + 1)
    } 
}