import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionEnemigos.enemigos.Enemigo.*

class Mur inherits Enemigo(nombre = "mur", dirActual = "arr")
{
    override method formaDeMoverse()
    {   
        const destino = self.obtenerDestino(dirActual)
        const casillaDestino = mapaObjetos.casilla(destino)
        if (not self.puedeMoverseA(casillaDestino))
        {
            if (dirActual == "arr") dirActual = "abj" else dirActual = "arr"    
        }
        
    }
}