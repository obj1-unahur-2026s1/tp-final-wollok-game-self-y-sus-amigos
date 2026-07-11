import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object bendicionSuerte inherits Mejora
{
    override method nombre()      = "bendicion de la suerte"
    override method descripcion() = "Aumenta la suerte del personaje, y sus propabilidades de obtener mejores recompensas"
    override method maximoAcumulacion() = 10
    override method aplicar()
    {
        gestorMejoras.suerte(gestorMejoras.suerte() + 1)
    } 
}