import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object tesoroVictoria inherits Mejora
{
    override method nombre()      = "tesoro de victoria"
    override method descripcion() = "Otorga una cantidad de monedas al completar un nivel"
    override method maximoAcumulacion() = 10

    override method aplicar()
    {
        gestorMejoras.monedasFinalNivel(gestorMejoras.monedasFinalNivel() + 1)
    } 
}