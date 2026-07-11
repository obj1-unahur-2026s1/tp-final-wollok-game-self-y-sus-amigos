import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionNiveles.transicionNivel.*
import scripts.gestionNiveles.gestorNivel.*
import gestorEnemigos.*

class Enemigo
{
    var property nombre = ""
    var property position = game.at(0, 0)
    var property image = "default.png"
    var property dirActual = "abj"

    // estados
    var property estaEsperando = false
    var property destinoReservado = null
    var property tpeando    = false
    var property moviendose = false 

    method rutaImagen() = "sprites\\enemigos\\" + nombre +"\\mov\\" + dirActual + "\\" + nombre + "_" + dirActual + ".png" 

    method initialize()
    {
        gestorEnemigos.añadirEnemigo(self)
        image = self.rutaImagen()
        game.addVisual(self)
    }

    method obtenerDestino(direccion)
    {
        return
            if      (direccion == "arr") position.up(1)
            else if (direccion == "abj") position.down(1)
            else if (direccion == "der") position.right(1)
            else if (direccion == "izq") position.left(1)

            else position
    }

    method actualizarPosicion(posicionDestino) {
        position = posicionDestino
    }

    method puedeMoverseA(casilla, dir)
{
        const puedeEntrar = casilla.puedeEntrar(self, dir)
        const hayEnemigos = gestorEnemigos.estaOcupado(casilla.position())

    return puedeEntrar and not hayEnemigos
}

    method formaDeMoverse() {}

    method estáQuieto() = not moviendose 
                            and not estaEsperando 
                            and not transicion.transicionActiva()
                            and not tpeando

    method ocupaPosicion(pos) = position == pos or destinoReservado == pos

    method mover()
    {
        if (self.estáQuieto())
        {
            moviendose = true
            self.formaDeMoverse()

            const casillaActual = mapaObjetos.casilla(position)
            const destino = self.obtenerDestino(dirActual)
            const casillaDestino = mapaObjetos.casilla(destino)
            
            if (self.puedeMoverseA(casillaDestino, dirActual))
            {
                const frames = bancoImagenes.obtenerFrames(nombre, "mov", dirActual)

                destinoReservado = destino
                casillaActual.alSalir(self)

                animador.realizarAnimacionDeTransicion(self, destino, frames,{
                    destinoReservado = null
                    image = self.rutaImagen()
                    casillaDestino.alEntrar(self)
                    moviendose = false
                })
            } 
            else
            {
                moviendose = false
                estaEsperando = true
                game.schedule(1500, { estaEsperando = false })
            }
        }
    }

    method matar()
    {
        gestorEnemigos.sacarEnemigo(self)

        const sonidoMuerte = game.sound("audio\\SFX\\enemigoMuerte.mp3")
        sonidoMuerte.volume(gestorNivel.volumenEfectos())
        sonidoMuerte.play()

        animador.cancelarAnimacionesDe(self)

        const ruta = bancoImagenes.rutaAnimacionSimple("enemigos", "muerte", "play") + "enemigoMuerte_"
        animador.reproducirAdelante(self, ruta, 6, 3, {game.removeVisual(self)})
    }

    method actualizarVisuales(){
        game.removeVisual(self)
        game.addVisual(self)
    }

    method teletransportar(destino)
    {
        if(not estaEsperando 
            and not transicion.transicionActiva()
            and not tpeando)
        {
            tpeando = true
            const frames = bancoImagenes.obtenerFrames(self.nombre(), "teleport", dirActual)
            
            animador.realizarAnimacionDeTransicion(self, destino, frames, {
                image = "sprites\\enemigos\\" + self.nombre() + "\\mov\\" + dirActual + "\\" + self.nombre() + "_" + dirActual + ".png"
                position = destino
                tpeando = false
            })
        }
    }
}