import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionMenus.gestorPausa.*
import scripts.gestionMenus.gestorMenu.*
import scripts.personaje.personaje.*


object gestorInput{
    
    var property inMenu = true

    method up()         = if (inMenu)  {gestorMenu.menuActual().arriba()}    else {personaje.moverArriba()}

    method down()       = if (inMenu)  {gestorMenu.menuActual().abajo()}     else {personaje.moverIzquierda()}

    method left()       = if (inMenu)  {gestorMenu.menuActual().izquierda()} else {personaje.moverAbajo()}

    method right()      = if (inMenu)  {gestorMenu.menuActual().derecha()}   else {personaje.moverDerecha()}

    method enter()      = if (inMenu)  {gestorMenu.menuActual().aceptar()}   else {gestorPausa.pausar()}

    method space()      = if (inMenu)  {gestorMenu.menuActual().aceptar()}   else {personaje.ataque()}

    method backspace()  = if (inMenu)  {gestorMenu.menuActual().volver()}

    method pressE()     = if (!inMenu) {personaje.interact()}

    method pressR()     = if (!inMenu) {gestorNivel.reiniciarNivel()}
}