import scripts.gestionObjetos.gestorObjetos.*

class Objeto
{
    var property nombre = ""
    var property position = game.at(0, 0)
    var property image = "sprites\\utilidades\\transparente.png"
    var property canal = 0

    method initialize()
    {
        mapaObjetos.añadirObjeto(self)
        game.addVisual(self)
    }

    method destruir()
    {
        game.removeVisual(self)
        mapaObjetos.removerObjeto(self)
    }

    method puedeEntrar(entidad, dir) = true

    method alInteractuar() {}
    method accionar() {}
    method sePoneEncima(entidad) {}
    method soltar() {} 
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

    method mover(destino, dir) {}
}

