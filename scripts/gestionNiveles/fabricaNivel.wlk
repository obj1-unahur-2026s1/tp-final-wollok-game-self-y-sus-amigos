import scripts.gestionObjetos.misObjetos.cartel.*
import scripts.gestionObjetos.misObjetos.colision.*
import scripts.gestionObjetos.misObjetos.moneda.*
import scripts.gestionObjetos.misObjetos.pinchos.*
import scripts.gestionObjetos.misObjetos.palanca.*
import scripts.gestionObjetos.misObjetos.antorcha.*

import scripts.gestionObjetos.misObjetos.cofres.cofreNivel.*
import scripts.gestionObjetos.misObjetos.cofres.cofreTienda.*

import scripts.gestionObjetos.misObjetos.puerta.*
import scripts.gestionObjetos.misObjetos.caja.*
import scripts.gestionObjetos.misObjetos.salida.*
import scripts.gestionObjetos.misObjetos.portal.*
import scripts.gestionObjetos.misObjetos.baldosa.*
import scripts.gestionObjetos.misObjetos.boton.*
import scripts.gestionObjetos.misObjetos.laser.*
import scripts.gestionObjetos.misObjetos.llave.*

import scripts.gestionEnemigos.gestorEnemigos.*
import scripts.gestionEnemigos.enemigos.sapo.*
import scripts.gestionEnemigos.enemigos.murcielago.*
import scripts.gestionEnemigos.enemigos.gato.*

import scripts.personaje.personaje.personaje

/*
===============================================================================
FÁBRICA DE NIVELES
===============================================================================

Esta fábrica es la encargada de convertir los números (IDs) almacenados en los
archivos de los niveles en objetos reales del juego.

Cada celda del mapa contiene un número entero. Al cargar un nivel, la fábrica
lee ese número y crea automáticamente el objeto correspondiente en esa posición.

Ejemplo:

    2   -> Moneda
    30  -> Pinchos
    521 -> Puerta vertical del canal 1

De esta forma el editor de niveles únicamente necesita guardar números, mientras
que toda la lógica de creación queda centralizada en este archivo.

===============================================================================
TABLA DE IDS
===============================================================================

OBJETOS BÁSICOS

    0   = Celda vacía (no crea ningún objeto)

    1   = Colisión
            Bloque sólido que impide el movimiento.

    2   = Moneda
            Moneda recolectable.

    4   = Palanca
            Activa o desactiva un canal.

    6   = Caja
            Caja movible.

    7   = Portal
            Portal del nivel.

    8   = Botón
            Activa un canal mientras permanece presionado.

    9   = Llave
            Llave recolectable.

    10  = Cofre de nivel
            Contiene recompensas del nivel.

    11  = Cofre de tienda
            Cofre comprable con monedas.

    12  = Cartel
            Cartel decorativo o informativo.

    20  = Baldosa
            Piso especial.

-------------------------------------------------------------------------------

TRAMPAS

    30  = Pinchos abiertos

    31  = Pinchos cerrados

-------------------------------------------------------------------------------

PUERTAS

    51  = Puerta horizontal

    52  = Puerta vertical

    53  = Puerta horizontal abierta

    54  = Puerta vertical abierta

-------------------------------------------------------------------------------

LÁSERES

    800 = Dispara hacia arriba

    810 = Dispara hacia abajo

    820 = Dispara hacia la derecha

    830 = Dispara hacia la izquierda

-------------------------------------------------------------------------------

SALIDAS

    101 = Salida izquierda

    102 = Salida derecha

-------------------------------------------------------------------------------

ENEMIGOS

    90  = Sapo

    91  = Murciélago

    92  = Gato

-------------------------------------------------------------------------------

PERSONAJE

    99  = Posición inicial del jugador

===============================================================================
SISTEMA DE CANALES
===============================================================================

Algunos objetos pueden pertenecer a un canal para interactuar entre sí.

Actualmente utilizan canales:

    • Palancas
    • Botones
    • Puertas
    • Pinchos
    • Láseres
    • Baldosas (si corresponde)

El canal se representa agregando UN DÍGITO al final del ID.

Ejemplos:

    301  -> Pinchos del canal 1
    304  -> Pinchos del canal 4

    81   -> Botón del canal 1
    85   -> Botón del canal 5

    521  -> Puerta vertical del canal 1
    524  -> Puerta vertical del canal 4

    8203 -> Láser hacia la derecha del canal 3

===============================================================================
CÓMO FUNCIONA LA CREACIÓN
===============================================================================

Cuando se solicita crear un objeto, la fábrica sigue este orden:

1) Busca si existe exactamente ese ID.

    Ejemplo:

        90

    Existe, por lo que crea un Sapo.

-------------------------------------------------------------------------------

2) Si no existe exactamente, intenta interpretar el último dígito como canal.

    Para ello realiza:

        objeto = id.div(10)
        canal  = id % 10

    Ejemplo:

        id = 521

        objeto = 52
        canal  = 1

    Como el objeto 52 existe (Puerta vertical), crea una puerta utilizando
    el canal 1.

-------------------------------------------------------------------------------

Este sistema evita registrar un constructor para cada posible canal.

En lugar de registrar:

    521
    522
    523
    524
    525
    ...

solo es necesario registrar el ID base:

    52

y el canal se calcula automáticamente.

===============================================================================
VENTAJAS
===============================================================================

• Los niveles únicamente almacenan números.
• Todos los objetos se crean desde un único lugar.
• Agregar nuevos objetos resulta sencillo.
• El sistema de canales es automático.
• Se evita duplicar constructores para cada canal existente.
===============================================================================
*/
object fabricaNivel
{
    const constructores = new Dictionary()

    method inicializar()
    {
        // Objetos
        constructores.put(1, { p,c => new Colision(position = p) })

        constructores.put(2, { p,c => new Moneda(position = p) })

        constructores.put(30, { p,c => new Pinchos(position = p, canal = c) })
        constructores.put(31, { p,c => new Pinchos(position = p, canal = c, abierto = false) })

        constructores.put(4, { p,c => new Palanca(position = p, canal = c) })

        constructores.put(10, { p,c => new CofreNivel(position = p)})
        constructores.put(11, { p,c => new CofreTienda(position = p, precioBase = 20)})
        constructores.put(12, { p,c => new Cartel(position = p)})

        constructores.put(51, { p,c => new Puerta(position = p, canal = c, direccion = "horizontal") })
        constructores.put(52, { p,c => new Puerta(position = p, canal = c, direccion = "vertical") })
        constructores.put(53, { p,c => new Puerta(position = p, canal = c, direccion = "horizontal", abierto = true) })
        constructores.put(53, { p,c => new Puerta(position = p, canal = c, direccion = "vertical", abierto = true) })

        constructores.put(6, { p,c => new Caja(position = p) })
        constructores.put(7, { p,c => new Portal(position = p) })
        constructores.put(8, { p,c => new Boton(position = p, canal = c) })
        constructores.put(9, { p,c => new Llave(position = p) })

        constructores.put(800, { p,c => new Laser(position = p, canal = c, direccion = "arr") })
        constructores.put(810, { p,c => new Laser(position = p, canal = c, direccion = "abj") })
        constructores.put(820, { p,c => new Laser(position = p, canal = c, direccion = "der") })
        constructores.put(830, { p,c => new Laser(position = p, canal = c, direccion = "izq") })

        // Enemigos (si crece se puede separar en una fabrica de enemigos)
        constructores.put(90, { p,c => new Sapo(position = p) })
        constructores.put(91, { p,c => new Mur(position = p) })
        constructores.put(92, { p,c => new Gato(position = p) })

        constructores.put(101, { p,c => new Salida(position = p, canal = c, direccion = "izq") })
        constructores.put(102, { p,c => new Salida(position = p, canal = c, direccion = "der") })

        constructores.put(20, { p,c => new Baldosa(position = p, canal = c) })

        constructores.put(400, { p,c => new Antorcha(position = p) })
        constructores.put(401, { p,c => new Antorcha(position = p) })
        constructores.put(402, { p,c => new Antorcha(position = p) })
        constructores.put(403, { p,c => new Antorcha(position = p) })

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