import Nivel.*
import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

object nivel_2 inherits Nivel
{
    override method mapaData() =
    [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,1 ,99,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,1 ,0 ,0 ,2 ,2 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,2 ,2 ,0 ,90,0 ,0,102,1 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,92,0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
    ]

    const tutorial1 = new Objeto(position = game.at(11,7))

    override method iniciarNivel() {
        super()
        game.addVisual(tutorial1)
        animador.reproducirLoop(tutorial1, bancoImagenes.rutaAnimacionSimple("UI", "tutorial", "tutorial3") + "tutorial_", 2, 10)
    }
}

