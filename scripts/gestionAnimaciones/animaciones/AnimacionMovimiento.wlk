import AnimacionDosCasillas.*

class AnimacionMovimiento inherits AnimacionDosCasillas
{
    var acumulado = 0
    var posicionActualizada = false

    override method iniciar()
    {
        super()
        entidad.image("sprites/utilidades/transparente.png")
    }

    override method avanzarFrame()
    {
        acumulado += 5

        // todavía no alcanza para avanzar un frame
        if (acumulado < ticksPorFrame)
            return true

        // avanza los frames que correspondan (puede ser más de uno)
        const frames = (acumulado / ticksPorFrame).truncate(0)
        acumulado -= frames * ticksPorFrame
        frameActual += frames

        if (frameActual >= 11 and not posicionActualizada)
        {
            entidad.actualizarPosicion(posicionDestino)
            posicionActualizada = true
        }

        if (frameActual < pool.framesA().size())
        {
            tileA.image(pool.framesA().get(frameActual))
            tileB.image(pool.framesB().get(frameActual))
            return true
        }

        self.finalizar()
        return false
    }
}