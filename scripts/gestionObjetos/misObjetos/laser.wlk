import scripts.gestionObjetos.misObjetos.Objeto.*

import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionObjetos.gestorObjetos.*

class Laser inherits Objeto(nombre = "laser")
{
    var property direccion
    var property encendido = false
    const hacesProyectados = []

    override method puedeEntrar(entidad, dir) = false

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
        image = "sprites\\objetos\\laser\\" + direccion + "\\laserOff_" + direccion + ".png"
    }

    override method accionar()
    {
        if (encendido)
            self.apagar()
        else 
            self.encender()
    }

    method encender()
    {
        encendido = true
        // Sonido
        const laserOn = game.sound("audio\\SFX\\laserOn.mp3")
        laserOn.volume(0.3)
        laserOn.play()

        // visual
        image = "sprites\\objetos\\laser\\" + direccion + "\\laserOn_" + direccion + ".png"
        
        self.proyectarRayo()
    }

    method apagar()
    {
        encendido = false

        // Sonido
        const laserOff = game.sound("audio\\SFX\\laserOff.mp3")
        laserOff.volume(0.3)
        laserOff.play()

        // visual
        image = "sprites\\objetos\\laser\\" + direccion + "\\laserOff_" + direccion + ".png"

        self.limpiarRayo()
    }

    method limpiarRayo()
    {
        hacesProyectados.forEach({ haz => haz.destruir() })
        hacesProyectados.clear()
    }

    method proyectarRayo()
    {
        self.limpiarRayo()
        
        const primerCelda = self.obtenerSiguientePosicion(position)
        self.evaluarCasilleroProvisional(primerCelda)
    }

    method evaluarCasilleroProvisional(posicionActual)
    {
        if (mapaObjetos.hayCeldaVacia(posicionActual))
        {
            const nuevoHaz = new HazDeLaser(position = posicionActual, direccion = direccion, emisor = self)
            hacesProyectados.add(nuevoHaz)
            
            const siguientePosicion = self.obtenerSiguientePosicion(posicionActual)
            
            // se llama denuevo para continuar con el bucle
            self.evaluarCasilleroProvisional(siguientePosicion)
        }

        // sale del bucle
    }

    method obtenerSiguientePosicion(pos)
    {
        return
            if      (direccion == "arr")  pos.up(1)
            else if (direccion == "abj")  pos.down(1)
            else if (direccion == "der")  pos.right(1)
            else if (direccion == "izq")  pos.left(1)
            else pos
    }
}

class HazDeLaser inherits Objeto(nombre = "hazDeLaser")
{
    var property direccion
    var property encendido = true
    const property emisor

    override method initialize()
    {
        game.addVisual(self)
        self.actualizarVisual()
    }

    override method destruir()
    {
        game.removeVisual(self)
    }

    method tipoDeHaz()
    {
        if(direccion == "arr" or direccion == "abj") return "vertical"
        else return "horizontal"
    } 

    method actualizarVisual()
    {
        if (encendido) {
            image = "sprites\\objetos\\laser\\hazDeLaser_" + self.tipoDeHaz() + ".png"
        }
        else {
            image = "sprites\\utilidades\\transparente.png"
        }
    }
}