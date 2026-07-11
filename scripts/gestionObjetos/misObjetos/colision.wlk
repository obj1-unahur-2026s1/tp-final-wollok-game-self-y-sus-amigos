import scripts.gestionObjetos.misObjetos.Objeto.*

class Colision inherits Objeto(nombre = "colision")
{
    override method dejaPasarLaser() = false 
    override method puedeEntrar(entidad, dir) = false
}