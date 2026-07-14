import scripts.gestionNiveles.niveles.Nivel.*
import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionInput.teclado.*

object pantallaTitulo inherits Nivel(controles = controlesMenu){
    
    override method iniciarNivel() { 
        super()
        gestorMenu.iniciarTitulo()
    }
    
    override method musicasFondo() = ["menuMusic.mp3"]
}

