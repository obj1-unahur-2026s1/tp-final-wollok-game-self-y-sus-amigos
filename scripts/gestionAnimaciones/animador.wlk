import scripts.gestionAnimaciones.animaciones.AnimacionMovimiento.*
import scripts.gestionAnimaciones.animaciones.AnimacionAtaque.*
import scripts.gestionAnimaciones.animaciones.AnimacionDosCasillas.*
import scripts.gestionAnimaciones.animaciones.AnimacionSimple.*


/*
Administrador central de animaciones.

Responsabilidades:

- Actualizar todas las animaciones.
- Registrar nuevas animaciones.
- Eliminar animaciones finalizadas.
- Exponer una API sencilla para reproducir animaciones.
*/

object animador
{
    const property animacionesEntidades = []
    const property animacionesSimples = []

    method iniciar() {
        game.onTick(30, "relojGlobal",
        {
            self.actualizarAnimacionesSimples()
            self.actualizarAnimacionesEntidades()
        })
    }

    method detener() {
        game.removeTickEvent("relojGlobal")
    }

    method actualizarAnimacionesSimples()
    {
        animacionesSimples.forEach({ anim => anim.actualizar() })
            
        const completadasSimples = animacionesSimples.filter({ anim => anim.terminada() })
        animacionesSimples.removeAll(completadasSimples)
    }

    method actualizarAnimacionesEntidades()
    {
        const completadas = animacionesEntidades.filter({ anim => !anim.avanzarFrame() })
        animacionesEntidades.removeAll(completadas)
    }

    method iniciarAnimacion(animacion)
    {
        animacion.iniciar()
        animacionesEntidades.add(animacion)
    }

    // lanza una animacion de movimiento entre casillas
    method realizarAnimacionDeTransicion(entidad, destino, frames, velocidad, closure)
    {
        self.iniciarAnimacion(
            new AnimacionMovimiento(entidad = entidad, posicionDestino = destino, pool = frames, ticksPorFrame = velocidad, alTerminar = closure)
        )
    }

    // Lanza una animacion de ataque
    method realizarAnimacionDeAtaque(entidad, destino, frames, velocidad, closure)
    {
        self.iniciarAnimacion(
            new AnimacionAtaque(entidad = entidad, posicionDestino = destino, pool = frames, ticksPorFrame = velocidad, alTerminar = closure)
        )
    }
    
    // saber si esta haciendo alguna de las dos acciones de casillas
    method estaOcupado(entidad) {
        return animacionesEntidades.any({ anim => anim.entidad() == entidad })
    }

    method cancelarAnimacionesDe(entidad)
    {
        const animacionEncontrada = animacionesEntidades.findOrDefault({ anim => anim.entidad() == entidad }, null)
        
        if (animacionEncontrada != null)
        {
            animacionEncontrada.forzarFin()
            animacionesEntidades.remove(animacionEncontrada)
        }
    }

    // metodos para objetos estaticos
    method reproducir(entidad, ruta, cantidadFrames, velocidad, modo, closure)
    {
        self.detenerAnimacionSimple(entidad)
        const nuevaAnim = new AnimacionSimple(entidad = entidad, rutaBase = ruta, cantidadFrames = cantidadFrames, ticksPorFrame = velocidad, modo = modo, alTerminar = closure)
        animacionesSimples.add(nuevaAnim)
    }

    method reproducirLoop(entidad, rutaBase, cantidadFrames, velocidad)
    {
        self.reproducir(entidad, rutaBase, cantidadFrames, velocidad, modosAnimacion.loop(), {})
    }

    method reproducirAdelante(entidad, rutaBase, cantidadFrames, velocidad, closure)
    {
        self.reproducir(entidad, rutaBase, cantidadFrames, velocidad, modosAnimacion.forward(), closure)
    }

    method reproducirAtras(entidad, rutaBase, cantidadFrames, velocidad, closure)
    {
        self.reproducir(entidad, rutaBase, cantidadFrames, velocidad, modosAnimacion.reverse(), closure)
    }

    method detenerAnimacionSimple(entidad)
    {
        animacionesSimples.removeAll(animacionesSimples.filter({ a => a.entidad() == entidad }))
    }
}