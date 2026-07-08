import scripts.gestionEnemigos.enemigos.Enemigo.*

class Mur inherits Enemigo(nombre = "mur")
{
    override method formaDeMoverse() {
        dirActual = if (dirActual == "abj") "arr" else "abj"
    }
}