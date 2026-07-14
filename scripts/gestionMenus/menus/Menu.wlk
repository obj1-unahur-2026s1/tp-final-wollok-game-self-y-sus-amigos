import scripts.gestionMenus.gestorMenu.*
class Menu
{
    var property position = game.at(6, 1)
    var property image

    method opcionSeleccionada() = opciones.get(opcionActual - 1) 
    var property opcionActual = 1
    var property canPress = true 
    const property opciones = []

    method derecha()   { self.mover(1) }
    method abajo()     { self.mover(1) }
    method izquierda() { self.mover(-1) }
    method arriba()    { self.mover(-1) }

    method mover(delta) {
        opcionActual = ((opcionActual - 1 + delta + opciones.size()) % opciones.size()) + 1
        self.actualizar()
    }

    method aceptar() 
    {
        if (canPress)
        {
            self.opcionSeleccionada().entrar()
            canPress = false
        }
    }

    method volver() {}

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