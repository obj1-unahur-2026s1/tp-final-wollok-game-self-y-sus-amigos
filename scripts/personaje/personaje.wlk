import scripts.gestionMenus.menus.menuPausa.exit2
import scripts.gestionMenus.UI.contadorIntentos.contadorIntentos
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionMenus.UI.contadorMonedas.contadorMonedas
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
    var property vivo       = true 

    var property monedas = 0
    var property intentos = 2
    var property tieneLlave = false


    method reiniciarImagen()
    {
        image = "sprites\\personaje\\pj\\mov\\" + dirActual + "\\pj_" + dirActual + ".png"
    }

    method añadirMoneda(cantidad){
        monedas += cantidad + gestorMejoras.multiplicadorMonedas()

        console.println("Se AGREGARON " + cantidad + " monedas.")
        console.println("Monedas Actuales: " + monedas)
        contadorMonedas.actualizar()
    }

    method gastarMonedas(cantidad){
        monedas -= cantidad

        console.println("Se GASTARON " + cantidad + " monedas.")
        console.println("Monedas Actuales: " + monedas)
    }

    method añadirIntento()
    {
        if(intentos < self.intentosMaximos()){
            intentos += 1
            contadorIntentos.actualizar()
        }
    }

    method perderIntento()
    {
        vivo = false
        moviendose = true
        intentos -= 1

        gestorSonidos.reproducirSonido("personajeMuerte", "personaje")
        contadorIntentos.actualizar()
        contadorMonedas.actualizar()

        animador.cancelarAnimacionesDe(self)

        const ruta = bancoImagenes.rutaAnimacionSimple("personaje", "muerte", "play") + "personajeMuerte_"
        animador.reproducirAdelante(self, ruta, 6, 4, 
        {
            if(intentos <= 0)
            {
                exit2.entrar()
                intentos = 2
            }
            else
                gestorNivel.reiniciarNivel()
            moviendose = false
        })

    }

    method intentosMaximos()
    {
        return 2 + gestorMejoras.bonusIntentosExtra()
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
            vivo = true
        })

        gestorSonidos.reproducirSonido("spawn", "personaje")

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
            const sonidoAleatorio = "sword" + (1..3).anyOne()
            gestorSonidos.reproducirSonido(sonidoAleatorio, "personaje")
            
            if(objetosDestino.any({obj => obj.nombre() == "colision"}))
            {
                gestorSonidos.reproducirSonido("swordMetal", "personaje")
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