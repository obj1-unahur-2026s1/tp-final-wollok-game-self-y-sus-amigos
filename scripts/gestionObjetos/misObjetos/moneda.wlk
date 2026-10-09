import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionSonidos.gestorSonidos.*

class Moneda inherits Objeto(nombre = "moneda", image = "sprites/objetos/moneda/moneda.png")
{
    override method initialize()
    {
        super()
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "moneda", "play")
        animador.reproducirLoop(self, ruta + "moneda_", 6, 5)
    }

    override method sePoneEncima(entidad)
    {
        if (entidad.nombre() == "personaje" )
        {
            // limpiar
            animador.detenerAnimacionSimple(self)
            game.removeVisual(self) 
            mapaObjetos.removerObjeto(self, game.at(0,0))

            // activar sonido
            gestorSonidos.reproducirSonido("agarrarMoneda", "objetos")

            // sumar moneda al jugador
            entidad.añadirMoneda(1)

            //contadorMonedas.actualizar()
        }
        
    }
}