import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

class Moneda inherits Objeto(nombre = "moneda", image = "sprites\\objetos\\moneda\\moneda.png")
{
    override method initialize()
    {
        super()
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "moneda", "play")
        animador.reproducirLoop(self, ruta + "moneda_", 6, 5)
    }

    override method sePoneEncima(entidad)
    {
        // limpiar
        animador.detenerAnimacionSimple(self)
        game.removeVisual(self) 
        mapaObjetos.removerObjeto(self, game.at(0,0))

        // activar sonido
        const moneda = game.sound("audio\\SFX\\agarrarMoneda.mp3")
        moneda.volume(0.5)
        moneda.play()

        // sumar moneda al jugador
        entidad.añadirMoneda()

        //contadorMonedas.actualizar()
    }
}