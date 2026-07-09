import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Baldosa inherits Objeto(nombre = "baldosa", image = "sprites\\objetos\\boton\\baldosa_1.png")
{
    var estadoActual = 1
    method estaRoto() = estadoActual > 5 

    override method initialize()
    {
        game.addVisual(self)
    }

    override method soltar()
    {
        if (!self.estaRoto())
        {
        estadoActual += 1
        image = "sprites\\objetos\\boton\\baldosa_" + estadoActual + ".png"
        }  
    }
}