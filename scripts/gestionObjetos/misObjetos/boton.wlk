import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Boton inherits Objeto(nombre = "boton", image = "sprites\\objetos\\boton\\boton_sinPulsar.png")
{
    var property pisado = false
    var enTransicion = false
    var pendiente = false   

    override method initialize() {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method sePoneEncima(entidad) {
        if (enTransicion) { pendiente = true; return }
        else if (not pisado) {
            enTransicion = true
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAdelante(self, ruta, 7, 2, {
                pisado = true
                enTransicion = false
                image = "sprites\\objetos\\boton\\boton_pulsado.png"
                gestorCanales.notificarAccion(canal)
                if (pendiente) { pendiente = false; self.soltar() }
            })
        }
    }

    override method soltar() {
        if (enTransicion) { pendiente = true; return }
        else if (pisado) {
            enTransicion = true
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAtras(self, ruta, 7, 2, {
                pisado = false
                enTransicion = false
                image = "sprites\\objetos\\boton\\boton_sinPulsar.png"
                gestorCanales.notificarAccion(canal)
                if (pendiente) { pendiente = false; self.sePoneEncima(null) }
            })
        }
    }

    method hayAlguienEncima() {
        return game.getObjectsIn(self.position()).any({ o => 
            o != self && o.nombre() != "vacia" && o.nombre() != "boton" 
        })
    }
}