import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object botinMultiplicado inherits Mejora
{
    override method nombre()      = "botin multiplicado"
    override method descripcion() = "Los cofres otorgan mas monedas"
    override method maximoAcumulacion() = 20

    override method aplicar()
    {
        gestorMejoras.monedasExtraCofres(gestorMejoras.monedasExtraCofres() + 1)
    } 
}