import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.personaje.personaje.*

object intentosExtra inherits Mejora
{
    override method nombre()      = "vida extra"
    override method descripcion() = "Proporciona un corazon extra a la vida del jugador"
    override method maximoAcumulacion() = 3

    override method aplicar()
    {
        gestorMejoras.intentosExtra(gestorMejoras.intentosExtra() + 1)
        personaje.añadirIntento()
    } 
}