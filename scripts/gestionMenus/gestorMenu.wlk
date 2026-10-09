import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionNiveles.niveles.pantallaTitulo.*
import scripts.gestionSonidos.gestorSonidos.*
import menus.menuTitulo.*
import menus.menuControles.*
import menus.menuMejoras.*
import menus.menuNiveles.*
import menus.menuPausa.*
import menus.menuVolumen.*

object gestorMenu {
    
    const property menuVacio = new VisualMenu(position = menuActual.position(), image = "sprites/UI/menu/menuVacio.png")
    var property inMenu = true 
    var property menuActual = menuTitulo
    const property visualesMenu = []

    method abrir(menu) {
        menuActual = menu
        menu.entrar()
    }

    method añadirMenuVacio() {
        menuVacio.position(menuActual.position()) 
        game.addVisual(menuVacio)
    }

    method quitarMenuVacio() {
        game.removeVisual(menuVacio)
    }

    method iniciarPausa() {
        menuVacio.image("sprites/UI/menu/menuPausa/menuVacioPausa.png")
        menuPausa.opcionActual(1)
        menuPausa.actualizar()
        self.abrir(menuPausa)
        inMenu = true
    }

    method iniciarTitulo() {
        menuVacio.image("sprites/UI/menu/menuVacio.png")
        menuActual = menuTitulo
        self.añadirMenuVacio()
        self.abrir(menuTitulo)
    }
}

class VisualMenu {
    var property position
    var property image
}