import Nivel.*
import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

object nivel_3 inherits Nivel
{
    override method mapaData() =
    [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,99,0 ,0 ,41,0 ,31,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,2 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ],
        [0 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,0 ,91,0,522,0 ,2 ,0 ,2,92,102,1 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,42,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
    ]

    const tutorial1 = new Objeto(position = game.at(14,1))

    override method iniciarNivel() {
        super()
        game.addVisual(tutorial1)
        animador.reproducirLoop(tutorial1, bancoImagenes.rutaAnimacionSimple("UI", "tutorial", "tutorial4") + "tutorial_", 2, 10)
    }
}

