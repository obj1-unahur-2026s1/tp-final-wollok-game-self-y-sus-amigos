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
    
    const menuVacio = new VisualMenu(position = game.at(6, 1), image = "sprites\\UI\\menu\\menuVacio.png")
    var property menuActual = null
    const property visualesMenu = []

    method abrir(menu) {
        menuActual = menu
        menu.entrar()
    }

    method iniciarTitulo() {
        game.addVisual(menuVacio)
        self.abrir(menuTitulo)
    }
}

class VisualMenu {
    var property position
    var property image
}