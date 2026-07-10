import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionObjetos.gestorObjetos.*
import gestorEnemigos.*

class Enemigo
{
    var property nombre = ""
    var property position = game.at(0, 0)
    var property image = "default.png"
    var property dirActual = "abj"

    // estados
    var property estaEsperando = false

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

    method mover()
    {
        if (not estaEsperando)
        {
            // decidir como se va mover
            self.formaDeMoverse()

            const destino = self.obtenerDestino(dirActual)
            const casillaDestino = mapaObjetos.casilla(destino)
            const casillaActual = mapaObjetos.casilla(position)
            
            if (self.puedeMoverseA(casillaDestino, dirActual))
            {
                const frames = bancoImagenes.obtenerFrames(nombre, "mov", dirActual)

                casillaActual.alSalir(self)

                animador.realizarAnimacionDeTransicion(self, destino, frames,{
                    image = self.rutaImagen()
                    casillaDestino.alEntrar(self)
                })
            } 
            else
            {
                estaEsperando = true
                game.schedule(1500, { estaEsperando = false })
            }
        }
    }

    method matar()
    {
        gestorEnemigos.sacarEnemigo(self)

        const sonidoMuerte = game.sound("audio\\SFX\\enemigoMuerte.mp3")
        sonidoMuerte.volume(0.5)
        sonidoMuerte.play()

        animador.cancelarAnimacionesDe(self)

        const ruta = bancoImagenes.rutaAnimacionSimple("enemigos", "muerte", "play") + "enemigoMuerte_"
        animador.reproducirAdelante(self, ruta, 6, 3, {game.removeVisual(self)})
    }

    method actualizarVisuales(){
        game.removeVisual(self)
        game.addVisual(self)
    }
}