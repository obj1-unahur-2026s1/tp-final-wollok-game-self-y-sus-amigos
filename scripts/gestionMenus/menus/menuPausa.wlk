import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionMenus.gestorPausa.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.menus.menuMejoras.*
import scripts.gestionMenus.menus.menuControles.*
import scripts.gestionMenus.gestorMenu.*

object menuPausa inherits Menu(opciones = [resume, upgrades, control, exit2], position = game.at(6, 3)) {
    override method volver() 
    {
        super()
        gestorPausa.despausarMovimientos()
        gestorMenu.quitarMenuVacio()
        game.removeVisual(self)
        gestorMenu.inMenu(false)
    }

    override method entrar() 
    {
        gestorMenu.menuActual(self)
        gestorMenu.añadirMenuVacio()
        game.addVisual(self)
        canPress = true
    }
}

object resume {
    method entrar() 
    {
        gestorMenu.quitarMenuVacio()
        game.removeVisual(menuPausa)
        gestorPausa.despausarMovimientos()
        gestorMenu.inMenu(false)
    }
}

object upgrades {
    method entrar() 
    {
        game.removeVisual(menuPausa)
        gestorMenu.abrir(menuMejoras)
    }
}

object control {
    method entrar() 
    {
        game.removeVisual(menuPausa)
        gestorMenu.abrir(menuControles)
    }
}

object exit2 {
    method entrar() 
    {
        menuPausa.canPress(false)
        gestorNivel.cargarNivel(0)
    }
}