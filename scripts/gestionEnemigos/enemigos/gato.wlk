import scripts.gestionEnemigos.enemigos.Enemigo.*

class Gato inherits Enemigo(nombre = "gato")
{
    override method formaDeMoverse()
    {
        dirActual = if (dirActual == "izq") "der" else "izq"
    }
}