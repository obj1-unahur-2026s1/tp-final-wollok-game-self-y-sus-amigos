import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.gestorPausa.*
import scripts.gestionMenus.gestorMenu.*
import scripts.personaje.personaje.*


object gestorInput{
    
    method inMenu() = gestorMenu.inMenu()

    method up()         = if (self.inMenu())  {gestorMenu.menuActual().arriba()}    else {personaje.moverArriba()}

    method down()       = if (self.inMenu())  {gestorMenu.menuActual().abajo()}     else {personaje.moverAbajo()}

    method left()       = if (self.inMenu())  {gestorMenu.menuActual().izquierda()} else {personaje.moverIzquierda()}

    method right()      = if (self.inMenu())  {gestorMenu.menuActual().derecha()}   else {personaje.moverDerecha()}

    method enter()      = if (self.inMenu())  {gestorMenu.menuActual().aceptar()}   else {gestorPausa.pausar()}

    method space()      = if (self.inMenu())  {gestorMenu.menuActual().aceptar()}   else {personaje.ataque()}

    method backspace()  = if (self.inMenu())  {gestorMenu.menuActual().volver()}

    method pressE()     = if (!self.inMenu()) {personaje.interact()}

    method pressR()     = if (!self.inMenu()) {gestorNivel.reiniciarNivel()}
}