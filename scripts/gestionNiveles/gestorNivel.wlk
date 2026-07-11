
import niveles.pantallaTitulo.*
import niveles.datosNivel1.*
import niveles.datosNivel2.*
import niveles.datosNivel3.*
import niveles.datosNivel4.*
import niveles.datosNivel5.*
import niveles.datosNivel7.*
import niveles.datosNivel11.*
import niveles.datosNivel12.*
import niveles.datosNivel13.*
import niveles.datosNivel14.*
import niveles.datosNivel15.*
import niveles.datosNivel16.*
import niveles.datosNivel17.*
import niveles.tienda.*


import transicionNivel.*
import fabricaNivel.*

import scripts.gestionAnimaciones.animador.*

import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionEnemigos.gestorEnemigos.*

object gestorNivel
{
    const niveles = [
        pantallaTitulo,
        nivel_1,
        nivel_2,
        nivel_3,
        nivel_4,
        nivel_5,
        nivel_7,
        nivel_11,
        nivel_12,
        nivel_13,
        nivel_14,
        nivel_15,
        nivel_16,
        nivel_17,
        tienda
    ]

    var property nivelActual = 0
    const property primerNivelConTienda = 4
    const property frecuenciaTienda = 1
    var property enTienda = false

    var property musicaActual = null
    var property volumenMusica = 0.3
    var property volumenEfectos = 0.3

    method debeIrATienda()
    {
        return
            nivelActual >= primerNivelConTienda and
            (nivelActual - primerNivelConTienda) % frecuenciaTienda == 0
    }

    method pasarNivel()
    {
        if(enTienda)
        {
            self.cargarNivel(nivelActual + 1)
        }
        else
        {
            if(self.debeIrATienda())
                self.cargarTienda()
            else
                self.cargarNivel(nivelActual + 1)
        }
    }

    method reiniciarNivel() {
        transicion.activar()
    }

    method cargarNivel(numero)
    {
        enTienda = false
        nivelActual = numero
        transicion.activar()
    }

    method cargarTienda()
    {
        enTienda = true
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
        const nivel =  if(enTienda) tienda else niveles.get(nivelActual)
        const mapa = nivel.mapaData()

        musicaActual = game.sound( nivel.musicasFondo().anyOne() )
        musicaActual.shouldLoop(true)
        musicaActual.volume(volumenMusica)
        musicaActual.play()

        nivel.iniciarNivel()

        // inicializacion de animaciones y movimiento de enemigos
        animador.iniciar()
        gestorEnemigos.comenzarMovimiento()

        // construccion del mapa
        if (not mapa.isEmpty()) {
            self.construirMapa(mapa)
            
            gestorEnemigos.enemigosActivos().forEach({e => e.actualizarVisuales()})
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

                if (celda != 0)
                {
                    fabricaNivel.crear(celda, game.at(posX,posY))   
                }
            })
        })
    }
}
