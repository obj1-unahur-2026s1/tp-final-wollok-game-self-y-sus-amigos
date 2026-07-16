import scripts.gestionMejoras.misMejoras.intentosExtra.*
import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionMenus.menus.menuPausa.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.gestorMenu.*

object menuMejoras inherits Menu(image = "sprites\\UI\\menu\\menuMejoras\\menuMejoras.png", position = game.at(6,3)) 
{
    const multiplicador = new VisualMenu(position = game.at(6, 3), image = "sprites\\UI\\menu\\menuMejoras\\multiplicador\\multiplicador_1.png")
    const definicion = new VisualMenu(position = game.at(6, 3), image = "sprites\\UI\\menu\\menuMejoras\\descripcionesMejoras\\noUpgrades.png")
    const objeto1 = new VisualMenu(position = game.at(6, 3), image = "sprites\\utilidades\\transparente.png")
    const objeto2 = new VisualMenu(position = game.at(6, 3), image = "sprites\\utilidades\\transparente.png")
    const objeto3 = new VisualMenu(position = game.at(6, 3), image = "sprites\\utilidades\\transparente.png")

    override method entrar()
    {
        super()
        game.addVisual(objeto1)
        game.addVisual(objeto2)
        game.addVisual(objeto3)
        game.addVisual(multiplicador)
        game.addVisual(definicion)
        self.actualizar()
    }

    method objetoActual() = opciones.get(opcionActual - 1)

    method objetoSiguiente() 
    {
        opcionActual = (opcionActual) % opciones.lenght()
        return opciones.get(opcionActual)
    }

    method objetoAnterior() 
    {
        opcionActual = (opcionActual - 2) % opciones.lenght()
        return opciones.get(opcionActual)
    }

    override method actualizar() 
    {
        if (!opciones.isEmpty())
        {
            objeto1.image("sprites\\mejoras\\grandes\\" + self.objetoActual() + ".png")
            objeto2.image("sprites\\mejoras\\pequeños\\" + self.objetoAnterior() + ".png")
            objeto3.image("sprites\\mejoras\\pequeños\\" + self.objetoSiguiente() + "_b.png")
            definicion.image("sprites\\UI\\menu\\menuMejoras\\descripcionesMejoras\\" + self.objetoActual() + ".png")
            multiplicador.image("sprites\\UI\\menu\\menuMejoras\\multiplicador\\multiplicador_" + gestorMejoras.cantidad(self.objetoActual()) + ".png")
        }
    }

    method insertarObjeto(objeto) 
    {
        if (!opciones.contains(objeto)) opciones.add(objeto)
    }

    override method volver() 
    {
        game.removeVisual(definicion)
        game.removeVisual(multiplicador)
        game.removeVisual(objeto1)
        game.removeVisual(objeto2)
        game.removeVisual(objeto3)
        game.removeVisual(self)
        gestorMenu.quitarMenuVacio()
        gestorMenu.abrir(menuPausa)
        self.sonidoVolver()
    }

    override method aceptar() 
    {
        self.volver()
    }
}