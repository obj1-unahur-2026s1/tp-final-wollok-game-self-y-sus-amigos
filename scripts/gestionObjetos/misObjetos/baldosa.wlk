import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.personaje.personaje.*

class Baldosa inherits Objeto(nombre = "baldosa", image = "sprites/objetos/baldosa/baldosa.png")
{
    var estaRoto = false
    override method dejaPasarLaser() = true

    override method puedeEntrar(entidad, dir) = not estaRoto

    override method sePoneEncima(entidad) 
    {
        if (entidad.nombre() == "personaje")
        {
            const sonido = "baldosa" + (1..3).anyOne()
            gestorSonidos.reproducirSonido(sonido, "objetos")

            if(estaRoto) entidad.perderIntento()
        }
    }

    override method soltar(entidad)
    {
        if (entidad.nombre() == "personaje")
        {
            const sonido = "baldosa" + (1..3).anyOne()
            gestorSonidos.reproducirSonido(sonido, "objetos")
            estaRoto = true
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "baldosa", "romper") + "baldosa_"
            animador.reproducirAdelante(self, ruta, 7, 3,
            {
                const enemigo = gestorEnemigos.hayEnemigoEn(position)
                if(enemigo != null) enemigo.matar()
                if(personaje.position() == position and personaje.vivo())
                    {
                        personaje.perderIntento()
                    }
            })
        }
    }
}