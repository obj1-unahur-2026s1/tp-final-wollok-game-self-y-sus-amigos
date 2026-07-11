import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionObjetos.gestorObjetos.*

class Laser inherits Objeto(nombre = "laser")
{
    var property direccion
    var property encendido = true
    const hacesProyectados = []

    var posicionHaz = self.obtenerSiguientePosicion(position)

    override method puedeEntrar(entidad, dir) = false

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)

        (1..20).forEach({ i =>
            const haz = new HazDeLaser(
                position = posicionHaz,
                direccion = direccion,
                emisor = self
            )

            hacesProyectados.add(haz)
            posicionHaz = self.obtenerSiguientePosicion(posicionHaz)
        })

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
        laserOn.volume(gestorNivel.volumenEfectos())
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
        laserOff.volume(gestorNivel.volumenEfectos())
        laserOff.play()

        // visual
        image = "sprites\\objetos\\laser\\" + direccion + "\\laserOff_" + direccion + ".png"

        self.limpiarRayo()
    }

    method limpiarRayo()
    {
        hacesProyectados.forEach({ haz =>
            haz.desactivar()
        })
    }

    method proyectarRayo()
{
    if (encendido)
    {
        self.limpiarRayo()
        self.proyectarDesde(
            self.obtenerSiguientePosicion(position),
            0
        )
    }
}

    method proyectarDesde(posicionActual, indice)
    {
        if (mapaObjetos.casilla(posicionActual).permitePasoLaser())
        {
            hacesProyectados.get(indice).activar()

            self.proyectarDesde(
                self.obtenerSiguientePosicion(posicionActual),
                indice + 1
            )
        }
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
    var property encendido = false
    const property emisor

    override method initialize()
    {
        super()
        self.actualizarVisual()
    }

    override method sePoneEncima(entidad) {
    if (encendido and entidad.nombre() == "caja") {
        game.schedule(500, {emisor.proyectarRayo()})
    }
}

override method soltar(entidad) {
    if (entidad.nombre() == "caja") {
        emisor.proyectarRayo()
    }
}

    method activar()
    {
        encendido = true
        self.actualizarVisual()
    }
    
    method desactivar()
    {
        encendido = false
        self.actualizarVisual()
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

    method tipoDeHaz()
    {
        if(direccion == "arr" or direccion == "abj") return "vertical"
        else return "horizontal"
    } 
}