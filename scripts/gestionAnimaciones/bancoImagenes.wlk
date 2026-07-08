class DefinicionAnimacion
{
    const property nombre
    const property cantidadFrames
    const property direcciones = ["arr","abj","der","izq"]
}

class PoolDirecciones
{
    const direcciones = new Dictionary()

    method agregarPool(direccion, pool)
    {
        direcciones.put(direccion, pool)
    }

    method pool(direccion) = direcciones.get(direccion)
}

class AnimacionesEntidad
{
    const animaciones = new Dictionary()

    method agregar(nombre, animacion) {
        animaciones.put(nombre, animacion)
    }

    method animacion(nombre) = animaciones.get(nombre)

    method pool(animacion, direccion) = self.animacion(animacion).pool(direccion)
}

class PoolFrames
{
    const property framesA = []
    const property framesB = []
}

object bancoImagenes
{
    const entidades = new Dictionary()

    // API publica

    method registrar(nombre, animacionesEntidad)
    {
        entidades.put(nombre,animacionesEntidad)
    }

    method entidad(nombre) = entidades.get(nombre)

    method obtenerFrames(entidad, accion, direccion) = self.entidad(entidad).pool(accion, direccion)

    method inicializar()
    {
        self.registrarPersonaje()
        self.registrarObjetos()
        self.registrarEnemigos()
    }

    // REGISTRO

    method registrarAnimacionesEntidad(carpeta, nombre, animaciones)
    {
        const entidad = new AnimacionesEntidad()

        animaciones.forEach({ datos =>

            entidad.agregar(
                datos.nombre(),
                self.crearAnimacionDireccional(
                    carpeta,
                    nombre,
                    datos.nombre(),
                    datos.cantidadFrames(),
                    datos.direcciones()
                )
            )
        })

        self.registrar(nombre, entidad)
    }

    method registrarPersonaje()
    {
        self.registrarAnimacionesEntidad("personaje", "pj", [
            new DefinicionAnimacion(nombre = "mov", cantidadFrames = 21),
            new DefinicionAnimacion(nombre = "teleport", cantidadFrames = 6)
        ])

        self.registrarAnimacionesEntidad("personaje","swrd", [
            new DefinicionAnimacion(nombre = "ataque", cantidadFrames = 9)
        ])
    }

    method registrarObjetos()
    {
        self.registrarAnimacionesEntidad("objetos", "caja", [
            new DefinicionAnimacion(nombre = "mov", cantidadFrames = 21)
        ])
    }

    method registrarEnemigos()
    {
        self.registrarAnimacionesEntidad("enemigos", "sapo", [
            new DefinicionAnimacion(nombre = "mov", cantidadFrames = 21)
        ])

        self.registrarAnimacionesEntidad("enemigos", "mur", [
            new DefinicionAnimacion(nombre = "mov", cantidadFrames = 21, direcciones = ["arr", "abj"])
        ])

        self.registrarAnimacionesEntidad("enemigos", "gato", [
            new DefinicionAnimacion(nombre = "mov", cantidadFrames = 21, direcciones = ["der", "izq"])
        ])
    }

    // Construccion

    method crearAnimacionDireccional(carpeta, entidad, accion, cantidadFrames, direcciones)
    {
        const animacion = new PoolDirecciones()

        direcciones.forEach({dir =>

            const pool = new PoolFrames()

            (1..cantidadFrames).forEach({ frame =>
                pool.framesA().add(
                    self.ruta(carpeta, entidad, accion, dir, "a", frame)
                )
                pool.framesB().add(
                    self.ruta(carpeta, entidad, accion, dir, "b", frame)
                )
            })

            animacion.agregarPool(dir, pool)
        })

        return animacion
    }

    // Utilidades

    method ruta(carpeta, entidad, accion, direccion, variante, frame)
    {
        return "sprites\\" +
            carpeta + "\\" +
            entidad + "\\" +
            accion + "\\" +
            direccion + "\\" +
            variante + "\\" +
            entidad + "_" +
            accion +  "_" +
            direccion + "_" +
            variante + "_" +
            frame + ".png"
    }

    method rutaAnimacionSimple(carpeta, entidad, accion)
    {
        return "sprites\\" +
            carpeta + "\\" +
            entidad + "\\" +
            accion + "\\"
    }
}