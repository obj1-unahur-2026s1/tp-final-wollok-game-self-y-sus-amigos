import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionMenus.menus.Menu.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionNiveles.gestorNivel.*

object menuNiveles inherits Menu(position = game.at(7, 2)) {
    const totalPaginas = 2
    const columnas = 5

    const sliderPaginas = new VisualMenu(position = game.at(7, 2), image = "sprites\\UI\\menu\\menuNiveles\\menuNivelesPage_1.png")
    const puntero = new VisualMenu(position = game.at(7, 2), image = "sprites\\UI\\menu\\menuNiveles\\menuNivelesPuntero_1.png")

    method opcionActualPuntero() = if (opcionActual > 10) opcionActual - 10 else opcionActual
    method paginaActual()        = (opcionActual - 1).div(10) + 1
    method fila()                = if (((opcionActual - 1) % 10) < columnas) 1 else 2
    method columna()             = ((opcionActual - 1) % columnas) + 1

    override method entrar() {
        gestorMenu.menuActual(self)
        game.addVisual(self)
        canPress = true
        game.addVisual(sliderPaginas)
        game.addVisual(puntero)
        self.aplicar()
    }

    override method volver() {
        super()
        game.removeVisual(sliderPaginas)
        game.removeVisual(puntero)
        game.removeVisual(self)
        gestorMenu.abrir(menuTitulo)
    }

    method moverA(pagina, fila, columna) {
        opcionActual = (pagina - 1) * 10 + (fila - 1) * columnas + columna
        self.aplicar()
        self.sonidoMover()
    }

    override method arriba()    { if (self.fila() == 2) self.moverA(self.paginaActual(), 1, self.columna()) }
    override method abajo()     { if (self.fila() == 1) self.moverA(self.paginaActual(), 2, self.columna()) }
    override method izquierda() {
        if (self.columna() > 1) self.moverA(self.paginaActual(), self.fila(), self.columna() - 1)
        else if (self.paginaActual() > 1) self.moverA(self.paginaActual() - 1, self.fila(), columnas)
    }
    override method derecha() {
        if (self.columna() < columnas) self.moverA(self.paginaActual(), self.fila(), self.columna() + 1)
        else if (self.paginaActual() < totalPaginas) self.moverA(self.paginaActual() + 1, self.fila(), 1)
    }

    method aplicar() {
        image = "sprites\\UI\\menu\\menuNiveles\\menuNiveles_" + self.paginaActual() + ".png"
        sliderPaginas.image("sprites\\UI\\menu\\menuNiveles\\menuNivelesPage_" + self.paginaActual() + ".png")
        puntero.image("sprites\\UI\\menu\\menuNiveles\\menuNivelesPuntero_" + self.opcionActualPuntero() + ".png")
    }

    override method aceptar() {
        if (canPress) {
            self.sonidoAceptar()
            gestorNivel.cargarNivel(opcionActual)
            gestorMenu.inMenu(false)
            canPress = false
        }
    }
}
