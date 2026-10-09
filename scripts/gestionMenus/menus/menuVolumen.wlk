import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionSonidos.gestorSonidos.*

object menuVolumen inherits Menu(position = game.at(7, 5), image = "sprites/UI/menu/menuVolumen/menu_Volumen.png") {

    const sliders = [
        new Slider(position = game.at(7, 4), prefijo = "musica", alCambiar = { v => gestorSonidos.volumenMusica(v) }),
        new Slider(position = game.at(7, 3), prefijo = "efectos", alCambiar = { v => gestorSonidos.volumenEfectos(v) })
    ]

    override method entrar() {
        super()
        sliders.forEach({ s => game.addVisual(s); game.addVisual(s.tileSeleccion()) })
        sliders.get(opcionActual - 1).activar()
    }

    override method volver() {
        super()
        sliders.forEach({ s => game.removeVisual(s); game.removeVisual(s.tileSeleccion()) })
        game.removeVisual(self)
        gestorMenu.abrir(menuTitulo)
    }

    override method arriba()    { self.mover(-1) }
    override method abajo()     { self.mover(1) }

    override method mover(delta) {
        sliders.get(opcionActual - 1).desactivar()
        opcionActual = ((opcionActual - 1 + delta + sliders.size()) % sliders.size()) + 1
        sliders.get(opcionActual - 1).activar()
        self.sonidoMover()
    }

    override method izquierda() { sliders.get(opcionActual - 1).modificar(-1) }
    override method derecha()   { sliders.get(opcionActual - 1).modificar(1) }

    override method aceptar()   { gestorMenu.menuActual().volver() }
}

class Slider {
    var nivel = 2
    const property position
    const property prefijo
    const property alCambiar
    const niveles = [0, 25, 50, 75, 100]
    const property tileSeleccion = new VisualMenu(position = position, image = "sprites/utilidades/transparente.png")

    method image() = "sprites/UI/menu/menuVolumen/" + prefijo + "_" + niveles.get(nivel) + ".png"

    method modificar(delta) {
        nivel = (nivel + delta).min(niveles.size() - 1).max(0)
        alCambiar.apply(niveles.get(nivel) / 100.0)
        menuVolumen.sonidoMover()
        gestorSonidos.actualizarVolumenMusica()
    }

    method activar()    { tileSeleccion.image("sprites/UI/menu/menuVolumen/" + prefijo + "_Select.png") }
    method desactivar() { tileSeleccion.image("sprites/utilidades/transparente.png") }
}
