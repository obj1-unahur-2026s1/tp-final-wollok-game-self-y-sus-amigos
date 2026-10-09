import scripts.gestionAnimaciones.animaciones.AnimacionDosCasillas.AnimacionDosCasillas

class AnimacionAtaque inherits AnimacionDosCasillas
{
    var acumulado = 0

    override method avanzarFrame()
    {
        acumulado += 5

        if (acumulado < ticksPorFrame)
            return true

        const frames = (acumulado / ticksPorFrame).truncate(0)
        acumulado -= frames * ticksPorFrame
        frameActual += frames

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