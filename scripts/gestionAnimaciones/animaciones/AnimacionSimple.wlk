object modosAnimacion
{
    const property loop = "LOOP"
    const property forward = "FORWARD"
    const property reverse = "REVERSE"
}

class AnimacionSimple
{
    const property entidad
    const property rutaBase
    const property cantidadFrames
    const property ticksPorFrame
    const property modo            // "LOOP", "FORWARD" o "REVERSE"
    const property alTerminar      // bloque de código a ejecutar al final
    
    var frameActual = if (modo == "REVERSE") cantidadFrames + 1 else 0
    var ticks = 0
    var property terminada = false

    method actualizar()
    {
        if (not terminada)
        {
            ticks += 1
            if (ticks % ticksPorFrame == 0) {
                self.avanzarSegunModo()
            }
        }
    }

    method avanzarSegunModo()
    {
        if (modo == modosAnimacion.forward())
            self.avanzarForward()
        else if (modo == modosAnimacion.reverse())
            self.avanzarReverse()
        else 
            self.avanzarLoop()
    }

    method avanzarForward()
    {
        frameActual += 1

        if (frameActual <= cantidadFrames)
            self.mostrarFrame(frameActual)
        else
            self.finalizar()
    }

    method avanzarReverse()
    {
        frameActual -= 1

        if (frameActual > 0)
            self.mostrarFrame(frameActual)
        else 
            self.finalizar()
    }

    method avanzarLoop()
    {
        frameActual += 1

        if (frameActual > cantidadFrames) frameActual = 1

        self.mostrarFrame(frameActual)
    }

    method mostrarFrame(frame)
    {
        entidad.image(rutaBase + frame + ".png")
    }

    method finalizar()
    {
        terminada = true
        alTerminar.apply() // ejecuta el codigo al final
    }
}