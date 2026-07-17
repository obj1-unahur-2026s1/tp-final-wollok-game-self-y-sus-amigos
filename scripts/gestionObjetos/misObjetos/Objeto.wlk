import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionSonidos.gestorSonidos.*

class Objeto
{
    var property nombre = ""
    var property position = game.at(0, 0)
    var property image = "sprites\\utilidades\\transparente.png"
    var property canal = 0

    method initialize()
    {
        mapaObjetos.añadirObjeto(self, game.at(0,0))
        game.addVisual(self)
    }

    method destruir()
    {
        game.removeVisual(self)
        mapaObjetos.removerObjeto(self, game.at(0,0))
    }

    method puedeEntrar(entidad, dir) = true
    method dejaPasarLaser() = true

    method sePoneEncima(entidad) {}
    method soltar(entidad) {} 
    method alInteractuar(entidad) {}
    method accionar() {}
    method configuracionFinal() {}
}

class ObjetoMovible inherits Objeto
{
    method obtenerDestino(direccion)
    {
        return
            if (direccion == "arr")      position.up(1)
            else if (direccion == "abj") position.down(1)
            else if (direccion == "der") position.right(1)
            else if (direccion == "izq") position.left(1)

            else position
    }
}

