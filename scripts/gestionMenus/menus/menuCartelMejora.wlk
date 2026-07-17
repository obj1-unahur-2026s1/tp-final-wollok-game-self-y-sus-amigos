import Menu.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionNiveles.transicionNivel.*

class MenuCartelMejora inherits Menu(position = game.at(0, 0))
{
    var property mejora = null
    var property personaje = null

    override method image() = mejora.image()

    method mostrar(unaMejora, unPersonaje)
    {
        mejora = unaMejora
        personaje = unPersonaje
        gestorMenu.inMenu(true)
        gestorMenu.abrir(self)
    }

    override method aceptar()
    {
        if (canPress and !transicion.transicionActiva())
        {
            self.sonidoAceptar()
            game.removeVisual(self)
            personaje.reiniciarImagen()
            gestorMenu.inMenu(false)
            canPress = false
        }
    }
}
