import scripts.gestionMenus.menus.menuTitulo.*
import scripts.gestionMenus.gestorMenu.*
import scripts.gestionNiveles.gestorNivel.*

object menuNiveles {
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
        //pantallaTitulo.mostrarFondoVacio()
        game.addVisual(sliderPaginas)
        game.addVisual(puntero)
        game.addVisual(self)
        self.aplicar()
    }

    method volver() {
        game.removeVisual(sliderPaginas)
        game.removeVisual(puntero)
        game.removeVisual(self)
        gestorMenu.abrir(menuTitulo)
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
        gestorNivel.cargarNivel(opcionActual)
    }
}