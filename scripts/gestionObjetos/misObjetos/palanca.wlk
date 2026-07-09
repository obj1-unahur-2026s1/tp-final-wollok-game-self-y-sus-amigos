import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Palanca inherits Objeto(nombre = "palanca", image = "sprites\\objetos\\palanca\\palancaCerrada.png")
{
    var property activada = false

    override method puedeEntrar(entidad,dir) = false

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method alInteractuar(entidad)
    {
        if (activada) self.cerrar()
        else self.abrir()
    }

    method abrir()
    {
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "palanca", "activar")

        animador.reproducirAdelante(self, ruta + "palanca_", 8, 3, {
            activada = true
            image = "sprites\\objetos\\palanca\\palancaAbierta.png"
            gestorCanales.notificarAccion(canal)
        })
        
    }

    method cerrar()
    {
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "palanca", "activar")

        animador.reproducirAtras(self, ruta + "palanca_", 8, 3, {
            activada = false
            image = "sprites\\objetos\\palanca\\palancaCerrada.png"
            gestorCanales.notificarAccion(canal)
        })
    }
}