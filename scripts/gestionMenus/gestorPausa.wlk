import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionMenus.menus.menuPausa.*
import scripts.gestionMenus.gestorMenu.*
object gestorPausa
{
    method pausar() 
    {
        if (!transicion.transicionActiva())
        {
            gestorSonidos.reproducirSonido("soundMenu2", "UI")
            self.pausarMovimientos()
            gestorMenu.iniciarPausa()
        }
    }

    method pausarMovimientos() 
    {
        gestorEnemigos.enemigosActivos().forEach({e => e.pausa(true)})
    }

    method despausarMovimientos()
    {
        gestorEnemigos.enemigosActivos().forEach({e => e.pausa(false)})
    } 
}