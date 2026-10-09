import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionSonidos.gestorSonidos.*

class Llave inherits Objeto(nombre = "llave", image = "sprites/objetos/llave/llave.png")
{
    override method sePoneEncima(entidad)
    {
        game.removeVisual(self) 
        mapaObjetos.removerObjeto(self, game.at(0,0))

        // activar sonido
        const moneda = game.sound("audio/SFX/agarrarMoneda.mp3")
        moneda.volume(0.5)
        moneda.play()

        if (entidad.nombre() == "personaje") entidad.tieneLlave(true)
    }
}