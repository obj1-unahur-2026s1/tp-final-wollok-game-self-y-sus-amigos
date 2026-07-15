import scripts.gestionMenus.menus.menuPausa.*
import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionMenus.menus.menuNiveles.*
import scripts.gestionMenus.menus.menuVolumen.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.gestorMenu.*

object menuControles inherits Menu(opciones = ["pag1", "pag2", "pag3"], position = game.at(6,3)) {
    override method volver() 
    {
        game.removeVisual(self)
        gestorMenu.quitarMenuVacio()
        gestorMenu.abrir(menuPausa)
        self.sonidoVolver()
    }
    override method aceptar() {self.volver()}
}