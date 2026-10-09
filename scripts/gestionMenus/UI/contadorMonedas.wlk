import scripts.personaje.personaje.personaje

object contadorMonedas
{
    var property image = "sprites/UI/moneda/x.png"
    const numero1 = new Numero(position = game.at(19,10))
    const numero2 = new Numero(position = game.at(20,10))
    const property position = game.at(17,10)

    method actualizar()
    {
        numero1.image("sprites/UI/moneda/" + personaje.monedas().div(10) + ".png")
        numero2.image("sprites/UI/moneda/" + personaje.monedas() % 10 + ".png")
    }

    method cargar() 
    {
        game.addVisual(self)
        game.addVisual(numero1)
        game.addVisual(numero2)
    }

    method descargar()
    {
        game.removeVisual(self)
        game.removeVisual(numero1)
        game.removeVisual(numero2)
    } 
}

class Numero
{
    var property image = "sprites/UI/moneda/0.png"
    const property position
}