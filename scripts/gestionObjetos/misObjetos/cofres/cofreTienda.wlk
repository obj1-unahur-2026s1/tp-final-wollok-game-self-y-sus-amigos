import cofre.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionRecompensas.gestorRecompensas.*
import scripts.gestionObjetos.misObjetos.cartel.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class CofreTienda inherits Cofre
{
    const cartel = new Cartel(position = position.up(1), image = "sprites/objetos/cartel/cartel_" + self.precio() + ".png")
    const property precioBase = 30
    method precio() = precioBase - gestorMejoras.bonusDescuentoCofres()

    override method initialize()
    {
        super()
        game.addVisual(cartel)
    }

    override method puedeAbrirse(entidad)
    {
        return entidad.monedas() >= self.precio()
    }

    override method entregarContenido(entidad)
    {
        entidad.gastarMonedas(self.precio())

        const ruta = bancoImagenes.rutaAnimacionSimple("personaje", "pj", "getItem") + "personajeItem_"

        gestorSonidos.reproducirSonido("obtenerMejoras", "personaje")
        
        animador.reproducirAdelante(entidad, ruta, 13, 3, {
            gestorRecompensas.recompensaTienda().entregar(entidad)
        })
    }
}