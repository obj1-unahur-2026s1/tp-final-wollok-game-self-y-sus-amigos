import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionRecompensas.gestorRecompensas.*
import scripts.gestionSonidos.gestorSonidos.*

class Cofre inherits Objeto(nombre = "cofre", image = "sprites\\objetos\\cofre\\cofreCerrado.png")
{
    var property abierto = false

    override method puedeEntrar(entidad, dir) = false

    override method alInteractuar(entidad)
    {
        if (self.puedeAbrirse(entidad))
            self.abrir(entidad)
    }

    method puedeAbrirse(entidad) = false

    method entregarContenido(entidad)
    {
        gestorRecompensas.recompensaTienda().entregar(entidad)
    }

    method abrir(entidad)
    {
        if (not abierto)
        {
            abierto = true

            const ruta = bancoImagenes.rutaAnimacionSimple(
                "objetos",
                "cofre",
                "abrir"
            ) + "chest_"

            animador.reproducirAdelante(self, ruta, 5, 3, {
                image = "sprites\\objetos\\cofre\\cofreAbierto.png"
                self.entregarContenido(entidad)
            })
        }
    }
}