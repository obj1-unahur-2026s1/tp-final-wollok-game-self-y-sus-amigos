import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Baldosa inherits Objeto(nombre = "baldosa", image = "sprites\\objetos\\baldosa\\baldosa.png")
{
    var estaRoto = true

    override method puedeEntrar(entidad, dir) = estaRoto

    override method sePoneEncima(entidad) 
    {
        if (entidad.nombre() == "personaje")
        {
            const sonido = game.sound("audio\\SFX\\baldosa" + (1..3).anyOne() + ".mp3")
                sonido.volume(gestorNivel.volumenEfectos())
                sonido.play()
        }
    }

    override method soltar(entidad)
    {
        if (entidad.nombre() == "personaje")
        {
            const sonido = game.sound("audio\\SFX\\baldosa" + (1..3).anyOne() + ".mp3")
            sonido.volume(gestorNivel.volumenEfectos())
            sonido.play()
            estaRoto = false
            const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "baldosa", "romper") + "baldosa_"
            animador.reproducirAdelante(self, ruta, 7, 3,
            {
                const enemigo = gestorEnemigos.hayEnemigoEn(position)
                if(enemigo != null) enemigo.matar()
            })
        }
    }
}