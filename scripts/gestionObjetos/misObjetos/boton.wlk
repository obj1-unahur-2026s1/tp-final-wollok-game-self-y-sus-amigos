import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Boton inherits Objeto(nombre = "boton", image = "sprites\\objetos\\boton\\boton_sinPulsar.png")
{
    var property pisado = false
    
    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method sePoneEncima(entidad)
    {
        if(not pisado)
        {
            pisado = true
            gestorCanales.notificarAccion(canal)

            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAdelante(self, ruta, 7, 1,
            {
                image = "sprites\\objetos\\boton\\boton_pulsado.png"
            })
        }
    }

    override method soltar(entidad)
    {
        if(pisado)
        {
            pisado = false
            gestorCanales.notificarAccion(canal)
            
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAtras(self, ruta, 7, 1,
            {
                image = "sprites\\objetos\\boton\\boton_sinPulsar.png"
            })
        }
    }
}