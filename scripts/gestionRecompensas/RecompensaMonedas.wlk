class RecompensaMonedas
{
    const property cantidad

    method entregar(personaje)
    {
        personaje.añadirMonedas(cantidad)
    }
}