class CasillaTransicion
{
    var property position
    var property image
}

class AnimacionDosCasillas
{
    const property entidad
    const property posicionDestino
    const property pool
    const property ticksPorFrame = 5
    const property alTerminar

    var property ticks = 0
    var property frameActual = 0
    
    const property tileA = new CasillaTransicion(position = entidad.position(), image = "")
    const property tileB = new CasillaTransicion(position = posicionDestino, image = "")

    method iniciar()
    {
        tileA.image(pool.framesA().get(0))
        tileB.image(pool.framesB().get(0))
        game.addVisual(tileA)
        game.addVisual(tileB)
    }

    method avanzarFrame()
    {
        ticks += 1

        if (ticks % ticksPorFrame != 0)
            return true

        frameActual += 1

        if (frameActual < pool.framesA().size())
        {
            tileA.image(pool.framesA().get(frameActual))
            tileB.image(pool.framesB().get(frameActual))
            return true
        }

        self.finalizar()
        return false
    }

    method finalizar()
    {
        game.removeVisual(tileA)
        game.removeVisual(tileB)
        alTerminar.apply() // Ejecutar el closure al final de la animacion
    }

    method forzarFin()
    {
        game.removeVisual(tileA)
        game.removeVisual(tileB)
        //entidad.imagenActual("")
    }
}