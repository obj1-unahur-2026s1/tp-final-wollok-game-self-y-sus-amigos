import cofre.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionSonidos.gestorSonidos.*

class CofreTienda inherits Cofre
{
    const property precioBase = 30
    method precio() = precioBase - gestorMejoras.bonusDescuentoCofres()

    override method puedeAbrirse(entidad)
    {
        return entidad.monedas() >= self.precio()
    }

    override method entregarContenido(entidad)
    {
        super(entidad)
        entidad.gastarMonedas(self.precio())
    }
}