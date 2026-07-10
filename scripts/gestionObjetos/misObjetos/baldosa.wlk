import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Baldosa inherits Objeto(nombre = "baldosa", image = "sprites\\objetos\\boton\\baldosa_1.png")
{

    override method initialize()
    {
        game.addVisual(self)
    }

    override method soltar(entidad)
    {
        
    }
}