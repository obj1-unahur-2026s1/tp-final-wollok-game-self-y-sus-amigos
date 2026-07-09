import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionNiveles.niveles.pantallaTitulo.*

object gestorMenu {
    var property menuActual = pantallaTitulo

    method abrir(menu) {
        menuActual = menu
        menu.entrar()
    }

    method ejecutar(accion) {
        accion.apply()
        game.sound("soundMenu1.mp3").play()
    }

    method derecha()   { self.ejecutar({ menuActual.derecha() }) }
    method izquierda() { self.ejecutar({ menuActual.izquierda() }) }
    method arriba()    { self.ejecutar({ menuActual.arriba() }) }
    method abajo()     { self.ejecutar({ menuActual.abajo() }) }

    method aceptar() { game.sound("soundMenu2.mp3").play(); menuActual.aceptar() }
    
    method volver() {
        game.sound("soundMenu3.mp3").play()
        menuActual.volver()
        menuActual = pantallaTitulo
        pantallaTitulo.entrar()
    }
}

object volumeOptions {
    var opcionActual = 0
    const volumenMenu = new VisualMenu(position = game.at(7, 5), image = "sprites\\UI\\menu\\menu_Volumen.png")
    
    const sliders = [
        new Slider(position = game.at(7, 4), prefijo = "musica", alCambiar = { v => gestorNivel.volumenMusica(v) }),
        new Slider(position = game.at(7, 3), prefijo = "efectos", alCambiar = { v => gestorNivel.volumenEfectos(v) })
    ]

    method entrar() {
        pantallaTitulo.mostrarFondoVacio()
        sliders.forEach({ s => game.addVisual(s); game.addVisual(s.tileSeleccion()) })
        sliders.get(opcionActual).activar()
        game.addVisual(volumenMenu)
    }

    method volver() {
        sliders.forEach({ s => game.removeVisual(s); game.removeVisual(s.tileSeleccion()) })
        game.removeVisual(volumenMenu)
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
    method aceptar()   { gestorMenu.volver() }
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
        alCambiar.apply(nivel / niveles.size() - 1)
    }

    method activar()    { tileSeleccion.image("sprites\\UI\\menu\\" + prefijo + "_Select.png") }
    method desactivar() { tileSeleccion.image("sprites\\utilidades\\transparente.png") }
}

object levelSelector {
    const totalPaginas = 2
    const columnas = 5
    var opcionActual = 1

    const sliderPaginas = new VisualMenu(position = game.at(7, 2), image = "sprites\\UI\\menu\\menu_SelectLevelPage_1.png")
    const puntero = new VisualMenu(position = game.at(7, 2), image = "sprites\\UI\\menu\\menu_SelectLevelPuntero_1.png")
    
    const property position = game.at(7, 2)
    var property image = "sprites\\UI\\menu\\menu_SelectLevel_1.png"

    method opcionActualPuntero() = if (opcionActual > 10) opcionActual - 10 else opcionActual
    method paginaActual()        = (opcionActual - 1).div(10) + 1
    method fila()                = if (((opcionActual - 1) % 10) < columnas) 1 else 2
    method columna()             = ((opcionActual - 1) % columnas) + 1

    method entrar() {
        pantallaTitulo.mostrarFondoVacio()
        game.addVisual(sliderPaginas)
        game.addVisual(puntero)
        game.addVisual(self)
        self.aplicar()
    }

    method volver() {
        game.removeVisual(sliderPaginas)
        game.removeVisual(puntero)
        game.removeVisual(self)
    }

    method moverA(pagina, fila, columna) {
        opcionActual = (pagina - 1) * 10 + (fila - 1) * columnas + columna
        self.aplicar()
    }

    method arriba()    { if (self.fila() == 2) self.moverA(self.paginaActual(), 1, self.columna()) }
    method abajo()     { if (self.fila() == 1) self.moverA(self.paginaActual(), 2, self.columna()) }
    method izquierda() {
        if (self.columna() > 1) self.moverA(self.paginaActual(), self.fila(), self.columna() - 1)
        else if (self.paginaActual() > 1) self.moverA(self.paginaActual() - 1, self.fila(), columnas)
    }
    method derecha() {
        if (self.columna() < columnas) self.moverA(self.paginaActual(), self.fila(), self.columna() + 1)
        else if (self.paginaActual() < totalPaginas) self.moverA(self.paginaActual() + 1, self.fila(), 1)
    }

    method aplicar() {
        image = "sprites\\UI\\menu\\menu_SelectLevel_" + self.paginaActual() + ".png"
        sliderPaginas.image("sprites\\UI\\menu\\menu_SelectLevelPage_" + self.paginaActual() + ".png")
        puntero.image("sprites\\UI\\menu\\menu_SelectLevelPuntero_" + self.opcionActualPuntero() + ".png")
    }

    method aceptar() {
        gestorNivel.nivelActual(opcionActual)
        gestorNivel.pasarNivel()
    }
}