object gestorEnemigos
{
    const property enemigosActivos = []

    method comenzarMovimiento()
    {
        game.onTick(1000, "movimientoSecuencialEnemigos",
        {
            if (!enemigosActivos.isEmpty()) 
            {
                const enemigo = enemigosActivos.anyOne()
                enemigo.mover()
            }
        })
    }

    method detenerMovimiento()
    {
        game.removeTickEvent("movimientoSecuencialEnemigos")
    }

    method añadirEnemigo(enemigo)
    {
        enemigosActivos.add(enemigo)
    }
    
    method sacarEnemigo(enemigo)
    { 
        enemigosActivos.remove(enemigo)
    }

    method borrarEnemigos()
    {
        enemigosActivos.clear()
    }

    method hayEnemigoEn(pos)
    {
        return enemigosActivos.findOrDefault({ e => e.position() == pos}, null)
    }

    method estaOcupado(pos)
    {
        return enemigosActivos.any({ enemigo => 
            enemigo.position() == pos
        })
    }
}