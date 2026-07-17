import cofre.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionRecompensas.gestorRecompensas.*

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
        gestorRecompensas.recompensaTienda().entregar(entidad)
        entidad.gastarMonedas(self.precio())
    }
}