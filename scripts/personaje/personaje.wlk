import scripts.gestionEnemigos.gestorEnemigos.*

import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*

import scripts.gestionObjetos.gestorObjetos.*
//import gestorAnimaciones.*
//import gestorObjetos.*

object personaje
{
    // propiedades visuales y de posición básicos
    var property position = game.at(0, 0)
    var property image = "sprites\\utilidades\\transparente.png"
    var property dirActual = "abj"

    // estados del personaje
    var property moviendose = false
    var property tpeando    = false 
    var property atacando   = false

    // inventario
    var property monedas = 0
    method añadirMoneda() { monedas += 1 }

    // spawn de jugador
    method spawn()
    {
        position = game.at(position.x()-1, position.y())
        game.addVisual(self)
        
        const ruta = bancoImagenes.rutaAnimacionSimple("personaje", "pj", "spawn")

        animador.reproducirAdelante(self, ruta + "Spawn_", 13, 3,
        {
            position = game.at(position.x()+1, position.y())
            image = "sprites\\personaje\\pj\\mov\\" + dirActual + "\\pj_" + dirActual + ".png"
        })

        const sonidoSpawn = game.sound("audio\\SFX\\spawn.mp3")
        sonidoSpawn.volume(0.6)
        sonidoSpawn.play()
    }

    // direcciones de movimiento para el personaje
    method moverDerecha()   { self.iniciarMovimiento("der") }
    method moverIzquierda() { self.iniciarMovimiento("izq") }
    method moverArriba()    { self.iniciarMovimiento("arr") }
    method moverAbajo()     { self.iniciarMovimiento("abj") }

    method ataque()         { self.atacar(dirActual) }

    // métodos de control de lógica de movimiento e interacción
    method obtenerDestino(direccion)
    {
        return
            if (direccion == "arr")      position.up(1)
            else if (direccion == "abj") position.down(1)
            else if (direccion == "der") position.right(1)
            else if (direccion == "izq") position.left(1)

            else position
    }

    method interact()
    {
        if (not atacando and not moviendose)
        {
            const destino = self.obtenerDestino(dirActual)
            const objetoDestino = mapaObjetos.hayObjetoEn(destino)
            objetoDestino.alInteractuar()
        }
    }

    // método de ataque
    method atacar(dir)
    {
        if (not atacando and not moviendose and not tpeando)
        {
            atacando = true
            const destino = self.obtenerDestino(dir)
            const objetoDestino = mapaObjetos.hayObjetoEn(destino) 

            // gestión de sonidos
            if(objetoDestino == null)
            {
                const sonido = game.sound("audio\\SFX\\sword" + (1..3).anyOne() + ".mp3")
                sonido.volume(0.3)
                sonido.play()
            }
            else if(objetoDestino.nombre() == "colision")
            {
                const sonido = game.sound("audio\\SFX\\swordMetal.mp3")
                sonido.volume(0.3)
                sonido.play()
            }

            const frames = bancoImagenes.obtenerFrames("swrd", "ataque", dir)

            animador.realizarAnimacionDeAtaque(self, destino, frames,{
                atacando = false

                const enemigo = gestorEnemigos.hayEnemigoEn(destino)
                if(enemigo != null) enemigo.matar()
            })
        }
    }

    method iniciarMovimiento(dir)
    {
        if (not moviendose and not atacando and not tpeando)
        {
            const destino = self.obtenerDestino(dir)
            const objetoDestino = mapaObjetos.hayObjetoEn(destino)

            if (objetoDestino != null and not objetoDestino.puedeEntrar(self, dir))
            {
                dirActual = dir
                image = "sprites\\personaje\\pj\\mov\\" + dir + "\\pj_" + dir + ".png"
            }
            else
                self.moverHacia(destino, objetoDestino, dir)
        }
    }

    method moverHacia(destino, objetoDestino, dir)
    {
        moviendose = true
        dirActual = dir
        
        const frames = bancoImagenes.obtenerFrames("pj", "mov", dir)

        animador.realizarAnimacionDeTransicion(self, destino, frames,
        {
            moviendose = false
            position = destino
            image = "sprites\\personaje\\pj\\mov\\" + dir + "\\pj_" + dir + ".png"

            objetoDestino.sePoneEncima(self)
        })
    }

    method teletransportar(destino)
    {
        if(not tpeando and not moviendose and not atacando)
        {
            tpeando = true
            const frames = bancoImagenes.obtenerFrames("pj", "teleport", dirActual)
            
            animador.realizarAnimacionDeTransicion(self, destino, frames, {
                image = "sprites\\personaje\\pj\\mov\\" + dirActual + "\\pj_" + dirActual + ".png"
                position = destino
                tpeando = false
            })
        }
    }
}