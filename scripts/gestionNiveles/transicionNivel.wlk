import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.personaje.personaje.*


object transicion
{
    var property image = "sprites\\utilidades\\transparente.png"
    var property position = game.at(0, 0)

    method activar()
    {
        game.addVisual(self)

        const ruta = bancoImagenes.rutaAnimacionSimple("UI", "transicion", "play")

        animador.reproducirAdelante(self, ruta + "transition_", 28, 1, {
            gestorNivel.descargarNivel()
            gestorNivel.cargarNivelActual()
            self.desactivar()
        })
    }

    
    method desactivar()
    {
        game.addVisual(self)
        
        const ruta = bancoImagenes.rutaAnimacionSimple("UI", "transicion", "play")

        animador.reproducirAtras(self, ruta + "transition_", 28, 1, {
            game.removeVisual(self)
            personaje.spawn()
        })
    }
}