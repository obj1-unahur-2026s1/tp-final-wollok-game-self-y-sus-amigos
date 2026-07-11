import scripts.gestionEnemigos.enemigos.Enemigo.*
import scripts.personaje.personaje.*
import scripts.gestionObjetos.gestorObjetos.*

class Sapo inherits Enemigo(nombre = "sapo", image = "sprites\\enemigos\\sapo\\mov\\abj\\sapo_abj.png")
{
    method intentarMoverseEn(dirPrincipal, dirSecundaria)
{
    const direcciones = [dirPrincipal, dirSecundaria]

    const dirElegida = direcciones.findOrDefault(
        { dir => self.puedeMoverseA(mapaObjetos.casilla(self.obtenerDestino(dir)), dir) },
        null
    )

    if (dirElegida != null) {
        dirActual = dirElegida
    }
}

    override method formaDeMoverse()
{
    const dx = personaje.position().x() - position.x()
    const dy = personaje.position().y() - position.y()
    const dirX = if (dx > 0) "der" else "izq"
    const dirY = if (dy > 0) "arr" else "abj"

    if (dy == 0)
        self.intentarMoverseEn(dirX, dirY)       
    else if (dx == 0)
        self.intentarMoverseEn(dirY, dirX)       
    else
    {
        const prefiereX = (1..2).anyOne() == 1   
        if (prefiereX)
            self.intentarMoverseEn(dirX, dirY)
        else
            self.intentarMoverseEn(dirY, dirX)
    }
}
}