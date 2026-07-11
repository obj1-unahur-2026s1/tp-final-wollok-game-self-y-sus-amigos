import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionEnemigos.enemigos.Enemigo.*

class Gato inherits Enemigo(nombre = "gato", dirActual = "izq")
{
    override method formaDeMoverse()
    {   
        const destino = self.obtenerDestino(dirActual)
        const casillaDestino = mapaObjetos.casilla(destino)
        if (not self.puedeMoverseA(casillaDestino, dirActual))
        {
            if (dirActual == "izq") dirActual = "der" else dirActual = "izq"    
        }
        
    }
}