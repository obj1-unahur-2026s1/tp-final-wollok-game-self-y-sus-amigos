import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionNiveles.gestorMenu.*
import scripts.input.teclado.*

object pantallaTitulo {
    var opcionActual = 0
    var canPress = true
    const fondo = new VisualMenu(position = game.at(0, 0), image = "sprites\\UI\\menu\\menu_NewGame.png")

    // Wollok llama a esto al arrancar: dibuja el fondo y activa tus flechas
    method iniciarNivel() { 
        game.addVisual(fondo)
        controlesMenu.configurar()
        self.entrar() 
    }
    
    method mapaData() = []
    method musicasFondo() = ["menuMusic.mp3"]

    method entrar()            { self.mostrarFondoMenu() }
    method mostrarFondoMenu()  { fondo.image(menuButtons.get(opcionActual)) }
    method mostrarFondoVacio() { fondo.image("sprites\\UI\\menu\\menu_Vacio.png") }

    const menuButtons = [
        "sprites\\UI\\menu\\menu_NewGame.png", 
        "sprites\\UI\\menu\\menu_Continue.png", 
        "sprites\\UI\\menu\\menu_Options.png", 
        "sprites\\UI\\menu\\menu_Exit.png"
    ]

    method derecha()   { self.mover(1) }
    method abajo()     { self.mover(1) }
    method izquierda() { self.mover(-1) }
    method arriba()    { self.mover(-1) }

    method mover(delta) {
        opcionActual = (opcionActual + delta + menuButtons.size()) % menuButtons.size()
        self.mostrarFondoMenu()
    }

    method aceptar() {
        if (canPress) {
            if (opcionActual == 0) { 
                game.removeVisual(fondo) // Limpiamos el fondo del menú antes de iniciar la partida
                gestorNivel.pasarNivel() 
                canPress = false 
            }
            if (opcionActual == 1) { gestorMenu.abrir(levelSelector) }
            if (opcionActual == 2) { gestorMenu.abrir(volumeOptions) }
            if (opcionActual == 3) { game.stop() }
        }
    }
    
    method volver() {}
}

class VisualMenu {
    var property position
    var property image
}