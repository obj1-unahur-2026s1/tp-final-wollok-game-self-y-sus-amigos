import niveles.datosNivel1.*
import niveles.datosNivel2.*
import niveles.datosNivel3.*
import niveles.pantallaTitulo.*

import transicionNivel.*
import fabricaNivel.*

import scripts.gestionAnimaciones.animador.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionEnemigos.gestorEnemigos.*

object gestorNivel
{
    const niveles = [
        pantallaTitulo,
        nivel_2,
        nivel_2,
        nivel_3
    ]

    var property nivelActual = 0
    var property musicaActual = null
    var property volumenMusica = 0.3
    var property volumenEfectos = 0.3

    method pasarNivel()
    {
        nivelActual += 1 
        transicion.activar()
    }

    method iniciarJuego()
    {
        self.cargarNivelActual()
    }

    method descargarNivel()
    {   
        animador.detener()
        gestorEnemigos.detenerMovimiento()

        mapaObjetos.limpiarObjetos()
        gestorEnemigos.borrarEnemigos()

        game.clear()

        if(musicaActual != null) musicaActual.stop()
    }

    method cargarNivelActual()
    {
        // referencias
        const nivel = niveles.get(nivelActual)
        const mapa = nivel.mapaData()

        musicaActual = game.sound( nivel.musicasFondo().anyOne() )
        musicaActual.shouldLoop(true)
        musicaActual.volume(0.1)
        musicaActual.play()

        nivel.iniciarNivel()

        // inicializacion de animaciones y movimiento de enemigos
        animador.iniciar()
        gestorEnemigos.comenzarMovimiento()

        // construccion del mapa
        if (not mapa.isEmpty()) {
            self.construirMapa(mapa)
        }
    }

    method construirMapa(mapa)
    {
        const altoMatriz = mapa.size()

        // Recorrer los índices de las filas (Eje Y)
        (0 .. altoMatriz - 1).forEach
        ({
            indexFila => 
            const fila = mapa.get(indexFila)
            const anchoFila = fila.size()

            (0 .. anchoFila - 1).forEach
            ({ 
                indexColumna =>
                const celda = fila.get(indexColumna)

                const posX = indexColumna
                const posY = altoMatriz - 1 - indexFila

                fabricaNivel.crear(celda, game.at(posX,posY))
            })
        })
    }
}
