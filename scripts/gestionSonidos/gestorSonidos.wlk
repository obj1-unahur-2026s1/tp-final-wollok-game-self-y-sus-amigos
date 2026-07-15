
object gestorSonidos {

    var musicaActual = null
    var property volumenEfectos = 0.3
    var property volumenMusica  = 0.3  

    method reproducirSonido(sonido, ruta) {
        const sound = game.sound(self.ruta(sonido, ruta))
        sound.volume(volumenEfectos)
        sound.play()
    }

    method reproducirMusica(musica) {
        musicaActual = game.sound(musica)
        musicaActual.shouldLoop(true)
        musicaActual.volume(volumenMusica)
        musicaActual.play()
    }

    method actualizarVolumenMusica() {
        musicaActual.volume(volumenMusica)
    }


    method pararMusica() {
        if (musicaActual != null) musicaActual.stop()
    }

    method ruta(sonido, ruta) = "audio\\SFX\\" + ruta + "\\" + sonido + ".mp3"

}