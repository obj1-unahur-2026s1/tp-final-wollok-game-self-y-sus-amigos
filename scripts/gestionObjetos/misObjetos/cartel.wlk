import scripts.gestionObjetos.misObjetos.Objeto.*

class Cartel inherits Objeto(nombre = "cartel", image = "sprites\\objetos\\cartel\\cartel.png")
{
    override method initialize()
    {
        game.addVisual(self)
    }
}