import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object avaricia inherits Mejora
{
    override method nombre()      = "avaricia"
    override method descripcion() = "Aumenta en +1 las monedas que agarra el jugador"
    override method maximoAcumulacion() = 5

    override method aplicar()
    {
        gestorMejoras.multiplicadorMonedas(gestorMejoras.multiplicadorMonedas() + 1)
    } 
}