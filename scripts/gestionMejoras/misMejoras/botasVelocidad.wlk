import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object botasVelocidad inherits Mejora
{
    override method nombre()      = "botas velocidad"
    override method descripcion() = "Aumenta la velocidad de movimiento del jugador"
    override method maximoAcumulacion() = 4

    override method aplicar()
    {
        gestorMejoras.reducirTicksMovimiento(1)
    } 
}