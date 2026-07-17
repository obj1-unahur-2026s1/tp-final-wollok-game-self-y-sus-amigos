import Mejora.*
import scripts.gestionMejoras.gestorMejoras.*

object espadaLarga inherits Mejora
{
    override method nombre()      = "espada larga"
    override method descripcion() = "Aumenta las casillas de efecto de la espada"
    override method maximoAcumulacion() = 3

    override method aplicar()
    {
        gestorMejoras.alcanceEspada(gestorMejoras.alcanceEspada() + 1)
    } 
}