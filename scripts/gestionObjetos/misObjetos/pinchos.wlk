import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionMejoras.gestorMejoras.*

class Pinchos inherits Objeto(nombre = "pinchos", image = "sprites\\objetos\\pinchos\\usar\\pinchosAbiertos.png")
{
    var property abierto = true
    var property puedeCerrar = true
    
    override method puedeEntrar(entidad,dir) = gestorMejoras.pasarPinchos() > 0

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method accionar()
    {
        if (abierto) self.cerrar()
        else self.abrir()
    }

    method abrir()
    {
        if (not puedeCerrar)
        {
            puedeCerrar = true
            abierto = true

            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "pinchos", "usar")
            const enemigoPosicion = gestorEnemigos.hayEnemigoEn(position)

            if(enemigoPosicion != null)
                enemigoPosicion.matar()

            animador.reproducirAdelante(self, ruta + "pinchosAbriendo_", 6, 2, {
                image = ruta + "pinchosAbiertos.png"
            })
        }
    }

    method cerrar()
    {
        if (puedeCerrar)
        {
            puedeCerrar = false
            abierto = false
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "pinchos", "usar")

            animador.reproducirAtras(self, ruta + "pinchosAbriendo_", 6, 2, {
                image = ruta + "pinchosCerrados.png"
            })
        }
    }
}