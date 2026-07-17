import scripts.gestionMejoras.misMejoras.recompensaCombate.*
import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object recompensaIntento inherits Mejora
{
    override method nombre()      = "recompensa salud"
    override method descripcion() = "Habilita la posibilidad de obtener curas de enemigos"

    override method aplicar()
    {
        gestorMejoras.bonusRecompensaIntento( gestorMejoras.bonusRecompensaIntento() + 1)
    } 
}