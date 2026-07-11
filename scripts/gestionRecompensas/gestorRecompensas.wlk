import RecompensaIntento.*
import RecompensaMejora.*
import RecompensaMonedas.*
import scripts.gestionMejoras.gestorMejoras.*
import scripts.gestionObjetos.misObjetos.moneda.*
import scripts.gestionObjetos.misObjetos.intento.*

object gestorRecompensas
{
    method recompensaNivel()
    {
        const numero = (1..100).anyOne()

        if (numero <= 70)
            return new RecompensaMonedas(cantidad = 10 + gestorMejoras.monedasExtraCofres())

        if (numero <= 90)
            return new RecompensaMonedas(cantidad = 25 + gestorMejoras.monedasExtraCofres())

        return new RecompensaIntento()
    }

    method recompensaTienda()
    {
        return new RecompensaMejora(
            mejora = gestorMejoras.mejoraAleatoria()
        )
    }

    method generarDrop(posicion)
    {
        const posibles = []

        if(gestorMejoras.bonusRecompensaCombate() > 0)
            posibles.add({ new Moneda(position = posicion) })

        if(gestorMejoras.bonusRecompensaIntento() > 0)
            posibles.add({ new Intento(position = posicion) })

        if(posibles.isNotEmpty())
            posibles.anyOne().apply()
    }
}

