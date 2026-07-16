import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionSonidos.gestorSonidos.*
class Menu
{
    var property position = game.at(6, 1)
    var property image = "sprites\\UI\\menu\\" + self + "\\" + self + "_1.png"

    method opcionSeleccionada() = opciones.get(opcionActual - 1) 
    var property opcionActual = 1
    var property canPress = true 
    const property opciones = []

    method derecha()   { if (!opciones.isEmpty()) self.mover(1) }
    method abajo()     { if (!opciones.isEmpty()) self.mover(1) }
    method izquierda() { if (!opciones.isEmpty()) self.mover(-1) }
    method arriba()    { if (!opciones.isEmpty()) self.mover(-1) }

    method mover(delta) {
        if (canPress)
        {
            opcionActual = ((opcionActual - 1 + delta + opciones.size()) % opciones.size()) + 1
            self.actualizar()
            self.sonidoMover()
        }
    }

    method aceptar() 
    {
        if (canPress and !transicion.transicionActiva())
        {
            self.sonidoAceptar()
            self.opcionSeleccionada().entrar()
            canPress = false
        }
    }

    method volver() { self.sonidoVolver() }

    method sonidoMover()   { gestorSonidos.reproducirSonido("soundMenu1", "UI") }
    method sonidoAceptar() { gestorSonidos.reproducirSonido("soundMenu2", "UI") }
    method sonidoVolver()  { gestorSonidos.reproducirSonido("soundMenu3", "UI") }

    method entrar() 
    {
        gestorMenu.menuActual(self)
        game.addVisual(self)
        canPress = true
    }

    method actualizar() {
        image = "sprites\\UI\\menu\\" + self + "\\" + self + "_" + opcionActual + ".png"
    }
}