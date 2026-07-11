import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object recompensaCombate inherits Mejora
{
    override method nombre()      = "recompensa de combate"
    override method descripcion() = "Habilita la opcion de conseguir monedas al matar enemigos"

    override method aplicar()
    {
        gestorMejoras.recompensaCombate( gestorMejoras.recompensaCombate() + 1)
    } 
}