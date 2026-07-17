import scripts.gestionObjetos.misObjetos.Objeto.*
import scripts.gestionObjetos.gestorObjetos.*
import scripts.gestionAnimaciones.animador.*
import scripts.gestionAnimaciones.bancoImagenes.*
import scripts.gestionNiveles.gestorNivel.*
import scripts.gestionSonidos.gestorSonidos.*

class Salida inherits Objeto(nombre = "salida", image = "sprites\\objetos\\salida\\salida_der.png")
{

    const property direccion 

    override method initialize(){
        super()
        image = "sprites\\objetos\\salida\\salida_" + direccion + ".png"
    }

    override method sePoneEncima(entidad)
    {
        if (entidad.nombre() == "personaje")
        {
            gestorNivel.pasarNivel()  
        }
    }
}