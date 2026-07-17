import Nivel.*
import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*

object nivel_5 inherits Nivel
{
    override method mapaData() =
    [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,0 ,0 ,0 ],
        [0 ,0 ,1 ,0 ,0 ,0 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,1 ,0 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0 ,0,522,0 ,0 ,2 ,0 ,2 ,0,90,522,0 ,0 ,0 ,1 ,0 ],
        [0 ,1 ,0 ,81,0 ,1 ,1 ,1 ,0 ,0 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,91,0 ,1 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0,521,0 ,0 ,42,0 ,1 ,83,0 ,2 ,0 ,0 ,2 ,0 ,1 ,0 ],
        [0 ,1 ,0 ,0 ,6 ,0 ,1 ,1 ,1 ,1 ,1 ,0 ,1 ,1 ,1,513,1 ,1 ,1 ,1 ,0 ],
        [0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0 ,0 ,0 ,1 ,0 ],
        [0 ,0 ,1 ,0 ,0 ,99,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,0 ,0,102,1 ,0 ],
        [0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,1 ,1 ,1 ,0 ,0 ],
        [0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ]
    ]

    const tutorial1 = new Objeto(position = game.at(7,1))

    override method iniciarNivel() {
        super()
        game.addVisual(tutorial1)
        animador.reproducirLoop(tutorial1, bancoImagenes.rutaAnimacionSimple("UI", "tutorial", "tutorial5") + "tutorial_", 3, 10)
    }
}

