import misMejoras.espadaLarga.*
import misMejoras.avaricia.*
import misMejoras.bendicionSuerte.*
import misMejoras.botasPinchos.*
import misMejoras.botasVelocidad.*
import misMejoras.botinMultiplicado.*
import misMejoras.descuentoCofres.*
import misMejoras.furiaVeloz.*
import misMejoras.intentosExtra.*
import misMejoras.recompensaCombate.*
import misMejoras.recompensaIntento.*
import misMejoras.tesoroVictoria.*
import scripts.gestionMenus.menus.menuMejoras.*


object gestorMejoras
{
    const property mejorasDisponibles = [
        espadaLarga,
        avaricia,
        bendicionSuerte,
        botasPinchos,
        botasVelocidad,
        botinMultiplicado,
        descuentoCofres,
        furiaVeloz,
        intentosExtra,
        recompensaCombate,
        recompensaIntento,
        tesoroVictoria
    ]
    
    const property mejorasObtenidas = new Dictionary()

    // Personaje
    var property bonusIntentosExtra = 0   // listo
    var property ticksMovimiento = 5 // listo

    // Enemigos
    var property bonusRecompensaIntento = 0 // listo
    var property bonusRecompensaCombate = 0 // listo

    // Espada
    var property alcanceEspada = 1  // listo
    var property ticksAtaque = 2    // listo

    // Economía
    var property monedasExtraCofres = 1    // listo
    var property multiplicadorMonedas = 1  // listo
    var property monedasFinalNivel = 0 // aun no

    var property bonusDescuentoCofres = 0  // listo

    // Suerte
    var property suerte = 5   // despues

    var property pasarPinchos = 0

    method agregar(mejora)
    {
        if (self.puedeObtener(mejora))
        {
            const cantidad = self.cantidad(mejora)

            mejorasObtenidas.put(
                mejora.nombre(),
                cantidad + 1
            )

            mejora.aplicar()

            menuMejoras.insertarObjeto(mejora)
        }
    }

    method puedeObtener(mejora)
    {
        return self.cantidad(mejora) < mejora.maximoAcumulacion()
    }

    method cantidad(mejora)
    {
        return mejorasObtenidas.getOrElse(mejora.nombre(), { 0 })
    }

    // metodos especiales
    method reducirTicksMovimiento(cantidad)
    {
        ticksMovimiento = 1.max(ticksMovimiento - cantidad)
    }

    method reducirTicksAtaque(cantidad)
    {
        ticksAtaque = 1.max(ticksAtaque - cantidad)
    }

    method mejoraAleatoria()
    {
        mejorasDisponibles.forEach({ m =>
            console.println(m.nombre())
        })

        const disponibles = mejorasDisponibles.filter({ m =>
            self.puedeObtener(m)
        })

        return disponibles.anyOne()
    }
}