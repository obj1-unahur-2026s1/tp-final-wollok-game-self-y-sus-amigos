import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Boton inherits Objeto(nombre = "boton", image = "sprites\\objetos\\boton\\boton_sinPulsar.png")
{
    var property pisado = false
    
    override method initialize()
    {
        game.addVisual(self)
        gestorCanales.registrar(self, canal)
    }

    override method sePoneEncima(entidad)
    {
        if(not pisado)
        {
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAdelante(self, ruta, 7, 1,
            {
                pisado = true
                image = "sprites\\objetos\\boton\\boton_pulsado.png"
                gestorCanales.notificarAccion(canal)
            })
        }
    }

    override method soltar()
    {
        if(pisado)
        {
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAtras(self, ruta, 7, 1,
            {
                pisado = false
                image = "sprites\\objetos\\boton\\boton_sinPulsar.png"
                gestorCanales.notificarAccion(canal)
            })
        }
    }
}