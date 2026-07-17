

class Casilla
{
    const property position 
    const property objetos = []

    method añadir(objeto)
    {
        objetos.add(objeto)
    }

    method remover(objeto)
    {
        objetos.remove(objeto)
    }

    method puedeEntrar(entidad, dir) = objetos.all({obj => obj.puedeEntrar(entidad, dir)})

    method alEntrar(entidad)       = objetos.forEach({ obj => obj.sePoneEncima(entidad)})
    method alSalir(entidad)        = objetos.forEach({ obj => obj.soltar(entidad) })
    method alInteractuar(entidad)  = objetos.forEach({ obj => obj.alInteractuar(entidad) })
    method configuracionFinal()    = objetos.forEach({ obj => obj.configuracionFinal() })

    method permitePasoLaser() = objetos.all({ o => o.dejaPasarLaser() })
}

object mapaObjetos
{
    const casillas = new Dictionary()

    method casilla(posicion)
    {
        return casillas.getOrElse(posicion, {
            const nueva = new Casilla(position = posicion)
            casillas.put(posicion, nueva)
            nueva
        })
    }

    method añadirObjeto(objeto, posicion)
    {
        if(posicion != game.at(0,0))
            self.casilla(posicion).añadir(objeto)
        else
            self.casilla( objeto.position() ).añadir(objeto)
    }

    method removerObjeto(objeto, posicion)
    {
        if(posicion != game.at(0,0) )
            self.casilla(posicion).remover(objeto)
        else
            self.casilla( objeto.position() ).remover(objeto)
    }

    method limpiarObjetos()
    {
        casillas.clear()
    }

    method configuracionFinal()
    {
        casillas.values().forEach({ casilla =>
            casilla.configuracionFinal()
        })
    }
}