import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionSonidos.gestorSonidos.*


object menuVolumen {
    var opcionActual = 0
    const volumenMenu = new VisualMenu(position = game.at(7, 5), image = "sprites\\UI\\menu\\menu_Volumen.png")
    
    const sliders = [
        new Slider(position = game.at(7, 4), prefijo = "musica", alCambiar = { v => gestorSonidos.volumenMusica(v) }),
        new Slider(position = game.at(7, 3), prefijo = "efectos", alCambiar = { v => gestorSonidos.volumenEfectos(v) })
    ]

    method entrar() {
        //pantallaTitulo.mostrarFondoVacio()
        sliders.forEach({ s => game.addVisual(s); game.addVisual(s.tileSeleccion()) })
        sliders.get(opcionActual).activar()
        game.addVisual(volumenMenu)
    }

    method volver() {
        sliders.forEach({ s => game.removeVisual(s); game.removeVisual(s.tileSeleccion()) })
        game.removeVisual(volumenMenu)
        gestorMenu.abrir(menuTitulo)
    }

    method arriba() { self.moverVertical(-1) }
    method abajo()  { self.moverVertical(1) }

    method moverVertical(dir) {
        sliders.get(opcionActual).desactivar()
        opcionActual = (opcionActual + dir + sliders.size()) % sliders.size()
        sliders.get(opcionActual).activar()
    }

    method derecha()   { sliders.get(opcionActual).modificar(1) }
    method izquierda() { sliders.get(opcionActual).modificar(-1) }
    method aceptar()   { gestorMenu.menuActual().volver() }
}

class Slider {
    var nivel = 2
    const property position
    const property prefijo
    const property alCambiar
    const niveles = [0, 25, 50, 75, 100]
    const property tileSeleccion = new VisualMenu(position = position, image = "sprites\\utilidades\\transparente.png")

    method image() = "sprites\\UI\\menu\\" + prefijo + "_" + niveles.get(nivel) + ".png"

    method modificar(delta) {
    nivel = (nivel + delta).min(niveles.size() - 1).max(0)
    alCambiar.apply(niveles.get(nivel) / 100.0)
    gestorSonidos.actualizarVolumenMusica()
    }

    method activar()    { tileSeleccion.image("sprites\\UI\\menu\\" + prefijo + "_Select.png") }
    method desactivar() { tileSeleccion.image("sprites\\utilidades\\transparente.png") }
}