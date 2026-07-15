import cofre.*
import scripts.gestionSonidos.gestorSonidos.*

class CofreNivel inherits Cofre
{
    override method puedeAbrirse(entidad)
    {
        return entidad.tieneLlave()
    }
}