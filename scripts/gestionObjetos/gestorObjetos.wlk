import scripts.gestionObjetos.misObjetos.celdaVacia.*

object mapaObjetos
{
    const objetos = new Dictionary()

    method añadirObjeto(objeto)
    {
        objetos.put(objeto.position(), objeto)
    }

    method removerObjeto(objeto)
    {
        const vacio = new Vacia(position = objeto.position())
        objetos.put(objeto.position(), vacio)
    }

    method hayObjetoEn(pos)
    {
        return objetos.getOrElse(pos, { new Vacia(position = pos) })
    }

    method hayCeldaVacia(pos) {
        return objetos.get(pos).nombre() == "vacia" 
    }

    method todosLosObjetos() {
        return objetos.values()
    }

    method limpiarObjetos() {
        objetos.clear()
    }

    method actualizarLaseres()
    {
        objetos.values()
            .filter({ o => o.nombre() == "laser" and o.encendido() })
            .forEach({ laser => laser.proyectarRayo() })
    }
}