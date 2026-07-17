import scripts.personaje.personaje.personaje

object contadorIntentos
{
    var property image = "sprites\\UI\\vida\\cora_2_2.png"
    const property position = game.at(0,10)

    method actualizar()
    {
        image = "sprites\\UI\\vida\\cora_" +  personaje.intentosMaximos()  +  "_" + personaje.intentos() + ".png"
    }

    method cargar() 
    {
        game.addVisual(self)
    }

    method descargar()
    {
        game.removeVisual(self)
    } 
}