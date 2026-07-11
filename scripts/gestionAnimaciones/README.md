# Sistema de Animaciones

Este módulo es el encargado de administrar todas las animaciones del juego.

Su responsabilidad se divide en tres partes:

1. Cargar y organizar los sprites.
2. Crear instancias de animaciones.
3. Actualizar las animaciones cada frame.

---

# Arquitectura

```
Entidad
    │
    ▼
Solicita una animación
    │
    ▼
Banco de imágenes
    │
    ▼
Obtiene los sprites correspondientes
    │
    ▼
Se crea una Animación
    │
    ▼
Animador Global la actualiza cada tick
```

---

# Organización de sprites

Los sprites se organizan jerárquicamente.

```
Entidad
    Acción
        Dirección
            Frames
```

Ejemplo:

```
Jugador
│
├── caminar
│     ├── arriba
│     ├── abajo
│     ├── izquierda
│     └── derecha
│
└── atacar
      ├── arriba
      ├── abajo
      ├── izquierda
      └── derecha
```

Cada dirección contiene una lista de imágenes.

---

# Componentes

## bancoImagenes

Única responsabilidad:

- Cargar imágenes.
- Organizarlas.
- Devolver los frames solicitados.

No ejecuta animaciones.

---

## Animacion

Representa una animación en ejecución.

Ejemplos:

- caminar
- atacar
- abrir puerta

Cada animación conoce:

- frame actual
- velocidad
- duración
- estado

---

## animador

Actualiza todas las animaciones activas.

Cada tick:

- avanza frames
- elimina animaciones terminadas
- actualiza entidades

Nunca carga imágenes.

---

# Flujo completo

Cuando un enemigo comienza a caminar:

```
Sapo
    │
    ▼
solicita("caminar", "izquierda")
    │
    ▼
bancoImagenes
    │
    ▼
devuelve los frames
    │
    ▼
AnimacionMovimiento
    │
    ▼
animador registra la animación
    │
    ▼
cada tick avanza un frame
```

---

# Tipos de animaciones

AnimacionSimple

- Cambia sprites.

---

AnimacionMovimiento

- Cambia sprites.
- Interpola posición.

---

AnimacionAtaque

- Cambia sprites.
- Ejecuta lógica de ataque.

---

TileTransicion

- Animación utilizada para transiciones del mapa.

---

# Agregar una nueva animación

1. Agregar sprites.
2. Registrar sprites en bancoImagenes.
3. Crear la animación correspondiente (si es un tipo nuevo).
4. Solicitar la animación desde la entidad.

---

# Responsabilidades

bancoImagenes

✔ Cargar recursos

✘ Actualizar animaciones

✘ Mover entidades

---

animador

✔ Actualizar animaciones

✔ Eliminar animaciones terminadas

✘ Cargar imágenes

---

Animacion

✔ Estado de una animación

✔ Frame actual

✔ Tiempo

✘ Buscar sprites

✘ Administrar otras animaciones