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

    method puedeMoverseA(casilla)
    {
        const puedeEntrar = casilla.puedeEntrar(self, dirActual)
        const hayEnemigos = gestorEnemigos.estaOcupado(casilla.position())

        return not puedeEntrar and not hayEnemigos
    }

    method formaDeMoverse() {}

    method mover()
    {
        if (not estaEsperando)
        {
            const destino = self.obtenerDestino(dirActual)
            const casilla = mapaObjetos.casilla(destino)

            // decidir como se va mover
            self.formaDeMoverse()
            
            if (self.puedeMoverseA(casilla))
            {
                const frames = bancoImagenes.obtenerFrames(nombre, "mov", dirActual)
                
                animador.realizarAnimacionDeTransicion(self, destino, frames,{
                    position = destino
                    image = self.rutaImagen()
                    casilla.sePoneEncima(self)
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
        animador.reproducirAdelante(self, ruta, 6, 3, {})
    }
}