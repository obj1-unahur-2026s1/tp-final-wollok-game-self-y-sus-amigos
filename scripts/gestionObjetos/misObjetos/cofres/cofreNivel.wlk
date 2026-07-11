import cofre.*

class CofreNivel inherits Cofre
{
    override method puedeAbrirse(entidad)
    {
        return entidad.tieneLlave()
    }
}