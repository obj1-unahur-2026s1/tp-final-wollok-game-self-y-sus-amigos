import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Puerta inherits Objeto(nombre = "Puerta")
{
    const property direccion
    var property abierto = false

    method posicionPuerta() =  if (direccion == "horizontal") self.position().right(1) else self.position().up(1)

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
        image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_cerrada.png"
    }

    override method dejaPasarLaser() = false 
    override method puedeEntrar(entidad, dir) = false

    override method accionar()
    {
        if (abierto) self.cerrar()
        else self.abrir()
    }

    method abrir()
    {
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "puerta", "abrir") + direccion + "\\puerta_" + direccion + "_"

        animador.reproducirAdelante(self, ruta, 8, 3, {
            image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_abierta.png"
            abierto = true
            
            //mapaObjetos.hayObjetoEn( self.posicionPuerta() ).puedeEntrar(true)
        })
    }

    method cerrar()
    {
        if (mapaObjetos.casilla( self.posicionPuerta() ).isEmpty())
        {
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "puerta", "abrir") + direccion + "\\puerta_" + direccion + "_"

            animador.reproducirAtras(self, ruta, 8, 3, {
                image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_cerrada.png"
                abierto = false

                //mapaObjetos.hayObjetoEn( self.posicionPuerta() ).puedeEntrar(false)
            })
        }
    }
}