import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionSonidos.gestorSonidos.*

class RecompensaMejora
{
    const property mejora

    method entregar(personaje)
    {
        game.addVisual(mejora)

        gestorMejoras.agregar(mejora)

        game.schedule(10000, {
            game.removeVisual(mejora)
            personaje.reiniciarImagen()
        })
    }
}