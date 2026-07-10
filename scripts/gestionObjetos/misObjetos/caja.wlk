import scripts.personaje.personaje.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Caja inherits ObjetoMovible(nombre = "caja", image = "sprites\\objetos\\caja\\caja.png")
{
    var moviendose = false

    override method dejaPasarLaser() = false 

    override method puedeEntrar(entidad, dir) 
    {
        if (moviendose) return false 

        const destino = self.obtenerDestino(dir)
        const puedeEntrar = mapaObjetos.casilla(destino).puedeEntrar(entidad, dir) 
            and not gestorEnemigos.estaOcupado(destino) 
            and personaje.position() != destino

        if (puedeEntrar) self.mover(dir)

        return puedeEntrar
    }

    method actualizarPosicion(posicionDestino) { position = posicionDestino }
    method actualizarVisuales() { game.removeVisual(self); game.addVisual(self) }

    method mover(dir)
{
    const destino = self.obtenerDestino(dir)
    const casillaActual = mapaObjetos.casilla(position)
    const casillaDestino = mapaObjetos.casilla(destino)

    moviendose = true

    const sonido = game.sound("audio\\SFX\\empujar.mp3")
    sonido.volume(0.4)
    sonido.play()

    mapaObjetos.removerObjeto(self, position)
    mapaObjetos.añadirObjeto(self, destino)

    casillaDestino.alEntrar(self)
    casillaActual.alSalir(self)

    const frames = bancoImagenes.obtenerFrames("caja", "mov", dir)
    animador.realizarAnimacionDeTransicion(self, destino, frames, {
        image = "sprites\\objetos\\caja\\caja.png"
        game.removeVisual(self)
        game.addVisual(self)
        moviendose = false
    })
}
}