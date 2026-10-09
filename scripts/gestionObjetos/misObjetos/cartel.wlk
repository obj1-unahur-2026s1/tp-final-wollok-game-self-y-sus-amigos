import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionSonidos.gestorSonidos.*

class Cartel inherits Objeto(nombre = "cartel", image = "sprites/objetos/cartel/cartel.png")
{
    override method initialize()
    {
        position = position.left(1)
    }
}