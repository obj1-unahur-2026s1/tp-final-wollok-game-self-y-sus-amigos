import scripts.personaje.personaje.*
import scripts.gestionNiveles.niveles.pantallaTitulo.*
import scripts.gestionNiveles.gestorMenu.*


object controlesJuego
{
    method configurar()
    {
        // control de movimiento del personaje con flechas
        keyboard.right().onPressDo({ personaje.moverDerecha() })
        keyboard.left().onPressDo({ personaje.moverIzquierda() })
        keyboard.up().onPressDo({ personaje.moverArriba() })
        keyboard.down().onPressDo({ personaje.moverAbajo() })

        // control de movimiento del personaje con AWSD
        keyboard.d().onPressDo({ personaje.moverDerecha() })
        keyboard.a().onPressDo({ personaje.moverIzquierda() })
        keyboard.w().onPressDo({ personaje.moverArriba() })
        keyboard.s().onPressDo({ personaje.moverAbajo() })

        // controles generales
        keyboard.space().onPressDo({personaje.ataque()})
        keyboard.e().onPressDo({personaje.interact()})

        //keyboard.l().onPressDo({gestorNiveles.pasarNivel() })
        keyboard.p().onPressDo({game.stop()})
    }
}

object controlesMenu {
    method configurar() {
        keyboard.right().onPressDo({ gestorMenu.derecha() })
        keyboard.left().onPressDo({ gestorMenu.izquierda() })
        keyboard.up().onPressDo({ gestorMenu.arriba() })
        keyboard.down().onPressDo({ gestorMenu.abajo() })
        
        keyboard.enter().onPressDo({ gestorMenu.aceptar() })
        keyboard.backspace().onPressDo({ gestorMenu.volver() })
    }
}