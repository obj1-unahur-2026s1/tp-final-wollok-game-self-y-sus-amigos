import scripts.gestionInput.teclado.*
import scripts.gestionMenus.UI.contadorIntentos.contadorIntentos
import scripts.gestionMenus.UI.contadorMonedas.contadorMonedas

class Nivel
{
    var property position = game.at(0,0)
    var property image = "sprites/niveles/" + self.toString() + ".png"
    var property controles = controlesMenu

    method musicasFondo() = [
        "audio/Musica/fondo1.mp3",
        "audio/Musica/fondo2.mp3",        
        "audio/Musica/fondo3.mp3",        
        "audio/Musica/fondo4.mp3",        
        "audio/Musica/fondo5.mp3",        
        "audio/Musica/fondo6.mp3",        
        "audio/Musica/fondo7.mp3",        
        "audio/Musica/fondo8.mp3",        
        "audio/Musica/fondo9.mp3",        
        "audio/Musica/fondo10.mp3",        
        "audio/Musica/fondo11.mp3",        
        "audio/Musica/fondo12.mp3"           
    ]

    method initialize(img)
    {
        if (img != null)
            image = img
        else
            image = "sprites/niveles/" + self.toString() + ".png"
    }

    method iniciarNivel()
    {
        controles.configurar()
        game.addVisual(self)
        contadorMonedas.cargar()
        contadorIntentos.cargar()
    }

    method mapaData() =
    [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
    ]
}

