import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.misObjetos.celdaVacia.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Caja inherits ObjetoMovible(nombre = "caja", image = "sprites\\objetos\\caja\\caja.png")
{
    override method mover(destino, dir)
    {
        const posicionOriginal = position
        const objetoPosicionActual = mapaObjetos.hayObjetoEn(position)
        const objetoPosicionDestino = mapaObjetos.hayObjetoEn(destino)

        const sonido = game.sound("audio\\SFX\\empujar.mp3")
        sonido.volume(0.4)
        sonido.play()

        const botonActual = game.getObjectsIn(posicionOriginal).findOrElse(
                { o => o.nombre() == "boton" }, 
                { null }
            )

        const frames = bancoImagenes.obtenerFrames("caja", "mov", dir)

        animador.realizarAnimacionDeTransicion(self, destino, frames, {
            image = "sprites\\objetos\\caja\\caja.png"

            position = destino 
            mapaObjetos.añadirObjeto(self)
            mapaObjetos.removerObjeto(new Vacia(position = posicionOriginal))


            if (botonActual != null) {
                botonActual.soltar()
            }
            
            const botonDestino = game.getObjectsIn(destino).findOrElse(
                { o => o.nombre() == "boton" }, 
                { null }
            )

            if (botonDestino != null) {
                botonDestino.sePoneEncima(self)
            }

            mapaObjetos.actualizarLaseres()

            game.removeVisual(self)
            game.addVisual(self)
        })
    }

    override method puedeEntrar(entidad, dir)
    {
        const destino = self.obtenerDestino(dir)

        if (!mapaObjetos.hayObjetoEn(destino).puedeEntrar(entidad, dir)) {
            return false
        }

        self.mover(destino, dir)
        return true
    }
}