import cofre.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionRecompensas.gestorRecompensas.*

class CofreNivel inherits Cofre
{
    override method puedeAbrirse(entidad)
    {
        return entidad.tieneLlave()
    }

    override method entregarContenido(entidad)
    {
        gestorRecompensas.recompensaNivel().entregar(entidad)
        entidad.tieneLlave(false)
    }
}