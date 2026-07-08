import scripts.gestionEnemigos.enemigos.Enemigo.*
import scripts.personaje.personaje.*

class Sapo inherits Enemigo(nombre = "sapo", image = "sprites\\enemigos\\sapo\\mov\\abj\\sapo_abj.png")
{
    method intentarMoverseEn(dirPrincipal, dirSecundaria)
    {
        if (self.puedeMoverseA(dirPrincipal))       dirActual = dirPrincipal
        else if (self.puedeMoverseA(dirSecundaria)) dirActual = dirSecundaria
    }

    override method formaDeMoverse()
    {
        const dx = personaje.position().x() - position.x()
        const dy = personaje.position().y() - position.y()
        const dirX = if (dx > 0) "der" else "izq"
        const dirY = if (dy > 0) "arr" else "abj"

        const prefiereX = (1..2).anyOne() == 1

        if (prefiereX)
            self.intentarMoverseEn(dirX, dirY)
        else
            self.intentarMoverseEn(dirY, dirX)
    }
}