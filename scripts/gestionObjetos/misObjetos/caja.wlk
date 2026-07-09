import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.misObjetos.celdaVacia.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Caja inherits ObjetoMovible(nombre = "caja", image = "sprites\\objetos\\caja\\caja.png")
{
    var objetoAbajo = null 

    override method mover(destino, dir)
    {
        const posicionOriginal = position
        
        const proximoObjetoAbajo = mapaObjetos.hayObjetoEn(destino)

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

            const objetoARestaurar = if (objetoAbajo != null) objetoAbajo else new Vacia(position = posicionOriginal)
            mapaObjetos.añadirObjeto(objetoARestaurar)
            mapaObjetos.añadirObjeto(self)
        
            objetoAbajo = proximoObjetoAbajo

            if (botonActual != null) {
                //botonActual.soltar()
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