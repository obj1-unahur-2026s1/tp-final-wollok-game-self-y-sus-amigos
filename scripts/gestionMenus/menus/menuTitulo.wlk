import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.menus.menuNiveles.*
import scripts.gestionMenus.menus.menuVolumen.*
import scripts.gestionMenus.gestorMenu.*

object menuTitulo inherits Menu(opciones = [newGame, continue, options, exit], image = "sprites\\UI\\menu\\menuTitulo\\menuTitulo_1.png") {
    override method volver() {}
}

object newGame {
    method entrar() {
        gestorNivel.pasarNivel()
    }
}

object continue {
    method entrar() {
        game.removeVisual(menuTitulo)
        gestorMenu.menuActual(menuNiveles)
        menuNiveles.entrar()
    }
}

object options {
    method entrar() {
        game.removeVisual(menuTitulo)
        gestorMenu.menuActual(menuVolumen)
        menuVolumen.entrar()
    }
}

object exit {
    method entrar() {
        game.stop()
    }
}