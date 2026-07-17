import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionObjetos.gestorCanales.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionSonidos.gestorSonidos.*

class Portal inherits Objeto(nombre = "portal")
{
    var property dirDestino = null
    var entity = null

    override method initialize()
    {
        super()
        gestorCanales.registrar(self, canal)
        const ruta = bancoImagenes.rutaAnimacionSimple("objetos", "portal", "idle") + "portal_"
        animador.reproducirLoop(self, ruta, 3, 8)
    }

    override method accionar()
    {
        if (entity != null) 
        {
            const portalDestino = gestorCanales.obtenerCompañeroDe(canal, self)

            if (portalDestino != null) {
                entity.teletransportar(portalDestino.position())
                const tp = "tp_" + (1..2).anyOne()
                gestorSonidos.reproducirSonido(tp, "objetos")
            }

            entity = null 
        }
    }

    override method sePoneEncima(entidad)
    {
        entity = entidad
        gestorCanales.notificarAccion(canal)
    }
}