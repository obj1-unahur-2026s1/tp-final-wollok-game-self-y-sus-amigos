import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object botasPinchos inherits Mejora
{
    override method nombre()      = "botas con pinchos"
    override method descripcion() = "Proporciona la habilidad de pasar encima de pinchos activados"

    override method aplicar()
    {
        gestorMejoras.pasarPinchos(gestorMejoras.pasarPinchos() + 1)
    } 
}