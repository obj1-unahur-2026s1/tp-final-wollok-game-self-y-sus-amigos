import scripts.personaje.personaje.*
import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Boton inherits Objeto(nombre = "boton", image = "sprites\\objetos\\boton\\boton_sinPulsar.png")
{
    var property pisado = false
    var animando = false            
    var pulsacionPendiente = false  

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method sePoneEncima(entidad)
    {
        if (animando) 
        {
            pulsacionPendiente = true 
            return
        }

        else if (not pisado)
        {
            animando = true
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
            animador.reproducirAdelante(self, ruta, 7, 2,
            {
                pisado = true
                image = "sprites\\objetos\\boton\\boton_pulsado.png"
                gestorCanales.notificarAccion(canal)
                
                animando = false
                if (pulsacionPendiente) 
                {
                    pulsacionPendiente = false
                    self.soltar(personaje)
                }
            })
        }
    }

    override method soltar(entidad)
    {

        if (!(entidad.nombre() == "caja"))
        {
            if (animando) 
            {
                pulsacionPendiente = true
                return
            }

            else if (pisado)
            {
                animando = true
                const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "boton", "pulsar") + "boton_"
                animador.reproducirAtras(self, ruta, 7, 2,
                {
                    pisado = false
                    image = "sprites\\objetos\\boton\\boton_sinPulsar.png"
                    gestorCanales.notificarAccion(canal)
                    
                    animando = false
                    if (pulsacionPendiente) 
                    {
                        pulsacionPendiente = false
                        self.sePoneEncima(personaje)
                    }
                })
            }
        }

    }
}