import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionSonidos.gestorSonidos.*

class Laser inherits Objeto(nombre = "laser")
{
    var property direccion
    var property encendido = true
    const casillasLinea = []
    const sensores = []
    const rayo = new RayoVisual()

    override method puedeEntrar(entidad, dir) = false

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
        image = "sprites/objetos/laser/" + direccion + "/laserOff_" + direccion + ".png"
    }

    override method configuracionFinal()
    {
        self.cachearCasillas()
        game.addVisual(rayo)
        self.encender()
    }

    // ---------- Cache de casillas y sensores ----------

    method cachearCasillas()
    {
        var pos = self.obtenerSiguientePosicion(position)
        casillasLinea.clear()
        sensores.clear()

        (1..20).forEach({ i =>
            const casilla = mapaObjetos.casilla(pos)
            const sensor = new SensorLaser(emisor = self, position = pos)

            casilla.añadir(sensor)
            casillasLinea.add(casilla)
            sensores.add(sensor)

            pos = self.obtenerSiguientePosicion(pos)
        })
    }

    // ---------- Estado ----------

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
        gestorSonidos.reproducirSonido("laserOn", "objetos")
        image = "sprites/objetos/laser/" + direccion + "/laserOn_" + direccion + ".png"
        self.proyectarRayo()
    }

    method apagar()
    {
        encendido = false
        gestorSonidos.reproducirSonido("laserOf", "objetos")
        image = "sprites/objetos/laser/" + direccion + "/laserOff_" + direccion + ".png"
        self.aplicarLargo(0)
    }

    // ---------- Proyección ----------

    method proyectarRayo()
    {
        if (encendido)
            self.aplicarLargo(self.largoDelRayo())
    }

    method largoDelRayo()
    {
        var largo = 0
        var sigue = true
        casillasLinea.forEach({ casilla =>
            if (sigue and casilla.permitePasoLaser())
                largo += 1
            else
                sigue = false
        })
        return largo
    }

    method aplicarLargo(largo)
    {
        // sensores: activos solo dentro del rayo
        (0..sensores.size() - 1).forEach({ i =>
            sensores.get(i).activo(i < largo)
        })

        // visual: una sola imagen del largo justo
        if (largo == 0)
        {
            rayo.image("sprites/utilidades/transparente.png")
        }
        else
        {
            rayo.position(self.posicionDelRayo(largo))
            rayo.image("sprites/objetos/laser/" + self.tipoDeHaz() + "/hazDeLaser_" + self.tipoDeHaz() + "_" + largo + ".png")
        }
    }

    // La imagen se ancla en su esquina inferior izquierda
    method posicionDelRayo(largo)
    {
        return
            if      (direccion == "izq")  position.left(largo)
            else if (direccion == "abj")  position.down(largo)
            else                          self.obtenerSiguientePosicion(position)
    }

    method tipoDeHaz()
    {
        return if (direccion == "arr" or direccion == "abj") "vertical" else "horizontal"
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

// Único visual del rayo
class RayoVisual
{
    var property position = game.at(0, 0)
    var property image = "sprites/utilidades/transparente.png"
}

// Objeto sin visual: solo vive dentro de la Casilla y detecta
class SensorLaser
{
    const property emisor
    const property position
    var property activo = false
    const property nombre = "sensorLaser"

    method puedeEntrar(entidad, dir) = true
    method dejaPasarLaser() = true
    method alInteractuar(entidad) {}
    method configuracionFinal() {}

    method sePoneEncima(entidad)
    {
        if (emisor.encendido())
        {
            if (activo and entidad.nombre() == "personaje")
                entidad.perderIntento()

            if (entidad.nombre() == "caja")
                game.schedule(500, { emisor.proyectarRayo() })
        }
    }

    method soltar(entidad)
    {
        if (emisor.encendido() and entidad.nombre() == "caja")
            emisor.proyectarRayo()
    }
}