import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import Nivel.*
import scripts.gestionObjetos.misObjetos.Objeto.*

object nivel_1 inherits Nivel
{
    override method mapaData() =
    [
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,2 ,0 ,0 ,2 ,0 ,0 ,2 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,0 ,2 ,0 ,0 ,0 ,2 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,99,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
    ]

    const tutorial1 = new Objeto(position = game.at(13,2))
    const tutorial2 = new Objeto(position = game.at(13,7))

    override method iniciarNivel() {
        super()
        game.addVisual(tutorial1)
        game.addVisual(tutorial2)
        animador.reproducirLoop(tutorial1, bancoImagenes.rutaAnimacionSimple("UI", "tutorial", "tutorial1") + "tutorial_", 5, 10)
        animador.reproducirLoop(tutorial2, bancoImagenes.rutaAnimacionSimple("UI", "tutorial", "tutorial2") + "tutorial_", 5, 10)
    }
}

