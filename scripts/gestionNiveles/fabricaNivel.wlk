import scripts.gestionObjetos.misObjetos.colision.*
import scripts.gestionObjetos.misObjetos.moneda.*
import scripts.gestionObjetos.misObjetos.pinchos.*
import scripts.gestionObjetos.misObjetos.palanca.*
import scripts.gestionObjetos.misObjetos.puerta.*
import scripts.gestionObjetos.misObjetos.caja.*
import scripts.gestionObjetos.misObjetos.portal.*
import scripts.gestionObjetos.misObjetos.boton.*
import scripts.gestionObjetos.misObjetos.laser.*
import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionEnemigos.enemigos.sapo.*
import scripts.gestionEnemigos.enemigos.murcielago.*
import scripts.gestionEnemigos.enemigos.gato.*

import scripts.personaje.personaje.personaje

/*
Este archivo define los identificadores (IDs) utilizados por los niveles y
cómo la fábrica convierte cada ID en un objeto del juego.

Cada celda del nivel contiene un número entero.

Los IDs simples representan directamente un tipo de objeto:

    Objetos
        0   = Celda vacía
        0.1 = Celda bloqueada (no transitable)
        1   = Colisión
        2   = Moneda
        3   = Pinchos
        4   = Palanca
        6   = Caja
        7   = Portal
        8   = Botón

        51  = Puerta horizontal
        52  = Puerta vertical

        800 = Láser hacia arriba
        810 = Láser hacia abajo
        820 = Láser hacia la derecha
        830 = Láser hacia la izquierda

    Enemigos
        90 = Sapo
        91 = Murciélago
        92 = Gato

    Personaje
        99 = Posición inicial del jugador


------------------------------------------------------------
Canales
------------------------------------------------------------

Algunos objetos (palancas, botones, puertas, pinchos, láseres, etc.)
pueden pertenecer a un canal.

El canal se codifica agregando un dígito al final del ID.

Ejemplos:

    31 -> Pinchos del canal 1
    34 -> Pinchos del canal 4

    81 -> Botón del canal 1
    85 -> Botón del canal 5

    521 -> Puerta vertical del canal 1
    525 -> Puerta vertical del canal 5

Cuando la fábrica recibe un ID que no existe exactamente, intenta
interpretarlo de la siguiente forma:

    objeto = id / 10
    canal  = id % 10

Si existe un constructor para "objeto", crea la instancia utilizando el
canal obtenido.

De esta forma no es necesario registrar un constructor para cada posible
canal, sino solamente para el tipo base del objeto.
*/

object fabricaNivel
{
    const constructores = new Dictionary()

    method inicializar()
    {
        // Objetos
        //constructores.put(0, { p,c => new Vacia(position = p)})
        //constructores.put(0.1, { p,c => new Vacia(position = p, puedeEntrar = false)})
        constructores.put(1, { p,c => new Colision(position = p) })

        constructores.put(2, { p,c => new Moneda(position = p) })
        constructores.put(3, { p,c => new Pinchos(position = p, canal = c) })
        constructores.put(4, { p,c => new Palanca(position = p, canal = c) })

        constructores.put(51, { p,c => new Puerta(position = p, canal = c, direccion = "horizontal") })
        constructores.put(52, { p,c => new Puerta(position = p, canal = c, direccion = "vertical") })

        constructores.put(6, { p,c => new Caja(position = p) })
        constructores.put(7, { p,c => new Portal(position = p) })
        constructores.put(8, { p,c => new Boton(position = p, canal = c) })

        constructores.put(800, { p,c => new Laser(position = p, canal = c, direccion = "arr") })
        constructores.put(810, { p,c => new Laser(position = p, canal = c, direccion = "abj") })
        constructores.put(820, { p,c => new Laser(position = p, canal = c, direccion = "der") })
        constructores.put(830, { p,c => new Laser(position = p, canal = c, direccion = "izq") })

        // Enemigos (si crece se puede separar en una fabrica de enemigos)
        constructores.put(90, { p,c => new Sapo(position = p) })
        constructores.put(91, { p,c => new Mur(position = p) })
        constructores.put(92, { p,c => new Gato(position = p) })

        // Personaje  (Quizas seria mejor determinar la posicion inicial del jugador en el propio nivel y no aqui, es provisional)
        constructores.put(99, {
            p,c => personaje.position(p)
        })
    }

    method crear(id, posicion)
    {
        // Existe id tal cual
        if (constructores.containsKey(id))
        {
            // canal 0 (no tiene canal)
            constructores.get(id).apply(posicion, 0)
        }
        else
        {
            // separar usando matematica
            const objetoID = id.div(10)
            const canalID  = id % 10

            if (constructores.containsKey(objetoID))
                constructores.get(objetoID).apply(posicion, canalID)
        }
    }
}