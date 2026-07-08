import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionNiveles.niveles.Nivel.*
import scripts.input.teclado.*

object pantallaTitulo inherits Nivel(controles = controlesMenu, image = "sprites\\UI\\menu\\menu_NewGame.png")
{
    var opcionActual = 0
    var canPress = true
    
    const menuButtons = [
        "sprites\\UI\\menu\\menu_NewGame.png",
        "sprites\\UI\\menu\\menu_Continue.png",
        "sprites\\UI\\menu\\menu_Options.png",
        "sprites\\UI\\menu\\menu_Exit.png"
    ]

    method opcionSiguiente() {
        opcionActual = opcionActual + 1

        if (opcionActual > 3) {
            opcionActual = 0
        }

        image = menuButtons.get(opcionActual)
    }

    method opcionAnterior(){
        opcionActual = opcionActual - 1
        if (opcionActual < 0) {
            opcionActual = 3
        }

        image = menuButtons.get(opcionActual)
    }

    method aceptar()
    {
        if (canPress){
            if(opcionActual == 0){
                gestorNivel.pasarNivel()
                canPress = false
            }
            if (opcionActual == 3){
                game.stop()
            }
        }
    }
}