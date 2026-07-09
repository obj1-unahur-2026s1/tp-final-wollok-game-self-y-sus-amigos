import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Caja inherits ObjetoMovible(nombre = "caja", image = "sprites\\objetos\\caja\\caja.png")
{
    override method dejaPasarLaser() = false 

    override method puedeEntrar(entidad, dir) 
    {
        const puedeEntrar = mapaObjetos.casilla( self.obtenerDestino(dir) ).puedeEntrar(entidad, dir)
        
        if(puedeEntrar)
            self.mover(dir)

        return puedeEntrar
    
    }

    // mover caja al entrar
    method mover(dir)
    {
        const destino = self.obtenerDestino(dir)
        
        const casillaActual = mapaObjetos.casilla(position)
        const casillaDestino = mapaObjetos.casilla(destino)

        // sonido
        const sonido = game.sound("audio\\SFX\\empujar.mp3")
        sonido.volume(0.4)
        sonido.play()

        mapaObjetos.removerObjeto(self, position)
        mapaObjetos.añadirObjeto(self, destino)

        casillaDestino.alEntrar(self)

        const frames = bancoImagenes.obtenerFrames("caja", "mov", dir)
        animador.realizarAnimacionDeTransicion(self, destino, frames, {

            position = destino

            // Actualizar visual
            image = "sprites\\objetos\\caja\\caja.png"
            game.removeVisual(self)
            game.addVisual(self)
        })
    }
}