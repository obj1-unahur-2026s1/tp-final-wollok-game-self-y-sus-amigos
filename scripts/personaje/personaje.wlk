import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionMejoras.gestorMejoras.*
//import gestorAnimaciones.*
//import gestorObjetos.*

object personaje
{
    // propiedades visuales y de posición básicos
    var property position = game.at(0, 0)
    var property destinoReservado = null
    var property image = "sprites\\utilidades\\transparente.png"
    var property nombre = "personaje"
    var property dirActual = "abj"

    // estados del personaje
    var property moviendose = false
    var property tpeando    = false 
    var property atacando   = false
    var property spawning   = false  

    var property monedas = 0
    var property intentos = 2
    var property tieneLlave = false

    method añadirMoneda(){
        monedas += gestorMejoras.multiplicadorMonedas()
    }

    method gastarMonedas(cantidad){
        monedas -= cantidad
    }

    method añadirIntento()
    {
        if(intentos < self.intentosMaximos())
            intentos += 1
    }

    method perderIntento(){
        intentos -= 1
    }

    method intentosMaximos()
    {
        return 2 + gestorMejoras.intentosExtra()
    }


    // spawn de jugador
    method spawn()
    {
        spawning = true
        position = game.at(position.x()-1, position.y())
        game.addVisual(self)
        
        const ruta = bancoImagenes.rutaAnimacionSimple("personaje", "pj", "spawn")

        animador.reproducirAdelante(self, ruta + "Spawn_", 13, 3,
        {
            position = game.at(position.x()+1, position.y())
            image = "sprites\\personaje\\pj\\mov\\" + dirActual + "\\pj_" + dirActual + ".png"
            spawning = false
        })

        const sonidoSpawn = game.sound("audio\\SFX\\spawn.mp3")
        sonidoSpawn.volume(gestorNivel.volumenEfectos())
        sonidoSpawn.play()
    }

    // direcciones de movimiento para el personaje
    method moverDerecha()   { self.iniciarMovimiento("der") }
    method moverIzquierda() { self.iniciarMovimiento("izq") }
    method moverArriba()    { self.iniciarMovimiento("arr") }
    method moverAbajo()     { self.iniciarMovimiento("abj") }

    method ataque()         { self.atacar(dirActual) }

    // métodos de control de lógica de movimiento e interacción
    method obtenerDestino(direccion) = self.obtenerDestinoDesde(position, direccion)

    method obtenerDestinoDesde(pos, direccion)
    {
        return
            if (direccion == "arr") pos.up(1)
            else if (direccion == "abj") pos.down(1)
            else if (direccion == "der") pos.right(1)
            else if (direccion == "izq") pos.left(1)
            else pos
    }
    
    method estáQuieto() = not moviendose 
                        and not spawning 
                        and not atacando 
                        and not tpeando 
                        and not transicion.transicionActiva()


    method actualizarPosicion(posicionDestino) {
        position = posicionDestino
    }

    method interact()
    {
        if (self.estáQuieto())
        {
            const destino = self.obtenerDestino(dirActual)
            const casilla = mapaObjetos.casilla(destino)
            casilla.alInteractuar(self)
        }
    }

    // métodos de ataque

    method casillasDeAtaque(dir)
    {
        const casillas = []
        var pos = self.position()

        (1..gestorMejoras.alcanceEspada()).forEach({ _ =>
            pos = self.obtenerDestinoDesde(pos, dir)
            casillas.add(pos)
        })

        return casillas
    }

    method atacar(dir)
    {
        if (self.estáQuieto())
        {
            atacando = true
            const destino = self.obtenerDestino(dir)
            const objetosDestino = mapaObjetos.casilla(destino).objetos()

            // gestión de sonidos
            
            const sonido = game.sound("audio\\SFX\\sword" + (1..3).anyOne() + ".mp3")
            sonido.volume(gestorNivel.volumenEfectos())
            sonido.play()
            
            if(objetosDestino.any({obj => obj.nombre() == "colision"}))
            {
                const sonido = game.sound("audio\\SFX\\swordMetal.mp3")
                sonido.volume(gestorNivel.volumenEfectos())
                sonido.play()
            }

            const frames = bancoImagenes.obtenerFrames("swrd", "ataque", dir)

            animador.realizarAnimacionDeAtaque(self, destino, frames, gestorMejoras.ticksAtaque(),{
                atacando = false

                self.casillasDeAtaque(dir).forEach({ casilla =>
                    const enemigo = gestorEnemigos.hayEnemigoEn(casilla)

                    if(enemigo != null)
                        enemigo.matar()
                })
            })
        }
    }

    method ocupaPosicion(pos) = position == pos or destinoReservado == pos

method iniciarMovimiento(dir)
{
    if (self.estáQuieto())
    {
        const destino = self.obtenerDestino(dir)
        const casilla = mapaObjetos.casilla(position)
        const casillaDestino = mapaObjetos.casilla(destino)

        if (not casillaDestino.puedeEntrar(self, dir))
        {
            dirActual = dir
            image = "sprites\\personaje\\pj\\mov\\" + dir + "\\pj_" + dir + ".png"
        }
        else
        {
            destinoReservado = destino   
            casilla.alSalir(self)
            self.moverHacia(destino, casillaDestino, dir)
        }
    }
}

method moverHacia(destino, casilla, dir)
{
    moviendose = true
    dirActual = dir
    
    const frames = bancoImagenes.obtenerFrames("pj", "mov", dir)

    animador.realizarAnimacionDeTransicion(self, destino, frames, gestorMejoras.ticksMovimiento(),
    {
        moviendose = false
        destinoReservado = null   
        image = "sprites\\personaje\\pj\\mov\\" + dir + "\\pj_" + dir + ".png"
        casilla.alEntrar(self)
    })
}

    method teletransportar(destino)
    {
        if(self.estáQuieto())
        {
            tpeando = true
            const frames = bancoImagenes.obtenerFrames("pj", "teleport", dirActual)
            
            animador.realizarAnimacionDeTransicion(self, destino, frames, 5,{
                image = "sprites\\personaje\\pj\\mov\\" + dirActual + "\\pj_" + dirActual + ".png"
                position = destino
                tpeando = false
            })
        }
    }
}