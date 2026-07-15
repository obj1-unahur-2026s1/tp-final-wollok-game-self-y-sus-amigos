import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.menus.menuNiveles.*
import scripts.gestionMenus.menus.menuVolumen.*
import scripts.gestionMenus.gestorMenu.*

object menuTitulo inherits Menu(opciones = [newGame, continue, options, exit]) {
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
        gestorMenu.abrir(menuNiveles)
    }
}

object options {
    method entrar() {
        game.removeVisual(menuTitulo)
        gestorMenu.abrir(menuVolumen)
    }
}

object exit {
    method entrar() {
        game.stop()
    }
}