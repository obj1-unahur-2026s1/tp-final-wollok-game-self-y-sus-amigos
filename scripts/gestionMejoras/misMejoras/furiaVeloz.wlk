import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object furiaVeloz inherits Mejora
{
    override method nombre()      = "furia veloz"
    override method descripcion() = "Aumenta la velocidad de ataque del jugador"
    override method maximoAcumulacion() = 3

    override method aplicar()
    {
        gestorMejoras.reducirTicksAtaque(1)
    } 
}