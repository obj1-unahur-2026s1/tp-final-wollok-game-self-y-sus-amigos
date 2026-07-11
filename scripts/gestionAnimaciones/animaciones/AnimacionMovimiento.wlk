import AnimacionDosCasillas.*

class AnimacionMovimiento inherits AnimacionDosCasillas
{
    override method iniciar()
    {
        super()
        entidad.image("sprites\\utilidades\\transparente.png")
    }

    override method avanzarFrame()
    {
        frameActual += 1

        if (frameActual < pool.framesA().size())
        {

            if (frameActual == 11)
            {
                entidad.actualizarPosicion(posicionDestino)
            }

            tileA.image(pool.framesA().get(frameActual))
            tileB.image(pool.framesB().get(frameActual))
            
            return true 
        }
        else
        {
            self.finalizar()
            return false 
        }
    }
}