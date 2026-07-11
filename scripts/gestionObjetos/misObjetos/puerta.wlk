import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Puerta inherits Objeto(nombre = "Puerta")
{
    const property direccion
    var property abierto = false
    var property puedeCerrar = true

    method posicionPuerta() =  if (direccion == "horizontal") self.position().right(1) else self.position().up(1)
    method actualizarPosicion() = if (direccion == "horizontal") position = position.left(1) else position = position.down(1)

    override method initialize()
    {
        super()
        self.actualizarPosicion()
        gestorCanales.registrar(self, canal)
        image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_cerrada.png"
        if (abierto)
        {
            self.cerrar()
        }
    }

    override method dejaPasarLaser() = false 
    override method puedeEntrar(entidad, dir) = abierto

    override method accionar()
    {
        if (abierto) self.cerrar()
        else self.abrir()
    }

    method abrir()
    { 
        if (puedeCerrar)
        {
    
            puedeCerrar = false
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "puerta", "abrir") + direccion + "\\puerta_" + direccion + "_"
            animador.reproducirAdelante(self, ruta, 8, 1, {
                image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_abierta.png"
                abierto = true
            })
        }
        
    }

    method cerrar()
    {
        if (not puedeCerrar)
        {   
            const enemigo = gestorEnemigos.hayEnemigoEn(self.posicionPuerta())
                if(enemigo != null) enemigo.matar()

            puedeCerrar = true
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "puerta", "abrir") + direccion + "\\puerta_" + direccion + "_"
            animador.reproducirAtras(self, ruta, 8, 1, {
                image = "sprites\\objetos\\puerta\\abrir\\" + direccion + "\\puerta_cerrada.png"
                abierto = false
            })
        }
        
    }
}