object gestorCanales
{
    const canales = new Dictionary()

    method registrar(objeto, canal)
    {
        if (!canales.containsKey(canal)) {
            canales.put(canal, [])
        }

        canales.get(canal).add(objeto)
    }

    method notificarAccion(canal)
    {
        if (canales.containsKey(canal))
        {
            canales.get(canal).forEach { obj =>
                obj.accionar()
            }
        }
    }

    method obtenerCompañeroDe(canal, portalActual)
    {
        // Buscamos en la lista del canal el objeto que NO sea el portal actual
        return canales.get(canal).find({ obj => obj != portalActual })
    }
}
