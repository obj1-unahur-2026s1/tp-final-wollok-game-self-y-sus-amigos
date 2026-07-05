import personaje.*
import niveles.*

object controles {
  method configurar() {
    keyboard.right().onPressDo({ personaje.moverDerecha() })
    keyboard.left().onPressDo({ personaje.moverIzquierda() })
    keyboard.up().onPressDo({ personaje.moverArriba() })
    keyboard.down().onPressDo({ personaje.moverAbajo() })
    keyboard.x().onPressDo({personaje.ataque()})
    keyboard.z().onPressDo({personaje.interact()})
    keyboard.l().onPressDo({gestorNiveles.pasarNivel() })
    keyboard.s().onPressDo({game.stop()})
    keyboard.r().onPressDo({gestorNiveles.reiniciarNivel()})
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

