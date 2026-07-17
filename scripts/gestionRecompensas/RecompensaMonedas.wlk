class RecompensaMonedas
{
    const property cantidad

    method entregar(personaje)
    {
        personaje.añadirMoneda(cantidad)
    }
}