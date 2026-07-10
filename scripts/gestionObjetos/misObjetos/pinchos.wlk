import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionEnemigos.gestorEnemigos.*

class Pinchos inherits Objeto(nombre = "pinchos", image = "sprites\\objetos\\pinchos\\usar\\pinchosAbiertos.png")
{
    var property abierto = true
    var property puedeCerrar = true
    //const collision = new Colision(position = position)

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
    }

    override method puedeEntrar(entidad, dir) = !abierto

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
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "pinchos", "usar")
            const enemigoPosicion = gestorEnemigos.hayEnemigoEn(position)

            if(enemigoPosicion != null)
                enemigoPosicion.matar()

            animador.reproducirAdelante(self, ruta + "pinchosAbriendo_", 6, 2, {
                abierto = true
                image = ruta + "pinchosAbiertos.png"
                const enemigo = gestorEnemigos.hayEnemigoEn(position)
                if(enemigo != null) enemigo.matar()
            })
        }
    }

    method cerrar()
    {
        if (puedeCerrar)
        {
            puedeCerrar = false
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "pinchos", "usar")

            animador.reproducirAtras(self, ruta + "pinchosAbriendo_", 6, 2, {
                abierto = false
                image = ruta + "pinchosCerrados.png"
            })
        }
    }
}