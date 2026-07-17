import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionSonidos.gestorSonidos.*
import scripts.gestionMenus.menus.menuCartelMejora.*

class RecompensaMejora
{
    const property mejora

    method entregar(personaje)
    {
        gestorMejoras.agregar(mejora)

        new MenuCartelMejora().mostrar(mejora, personaje)
    }
}
