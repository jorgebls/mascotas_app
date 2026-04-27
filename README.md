# Registro de Mascotas App

Una aplicación ágil y moderna desarrollada en **Flutter** para la gestión y registro de mascotas. Este proyecto demuestra la implementación de una arquitectura de base de datos dual, utilizando almacenamiento local para un rendimiento rápido y sincronización en la nube como respaldo de seguridad.

## ¿Para qué sirve?

La aplicación permite a los usuarios llevar un control detallado de sus mascotas o las de una veterinaria. Con una interfaz limpia y amigable, el usuario puede:

* **Registrar nuevas mascotas** indicando su nombre, tipo (perro, gato, etc.), peso, edad y un listado de las vacunas que ya se le han aplicado.
* **Visualizar** el listado completo de mascotas registradas en un formato de tarjetas estilo "Dashboard" (dividido en 4 columnas simétricas).
* **Editar** la información de cualquier mascota en tiempo real.

## Tecnologías y Arquitectura

Este proyecto destaca por el uso de tecnologías modernas en el ecosistema Flutter:

* **Flutter Web:** Compilado específicamente para ejecutarse de manera fluida en el navegador.
* **Drift (WebDatabase):** Base de datos local (basada en IndexedDB) que permite a la aplicación mostrar los datos al instante sin depender de la velocidad de la red.
* **Firebase Firestore:** Base de datos en la nube (NoSQL) que actúa como un espejo, guardando una copia de seguridad de cada registro de forma silenciosa.
* **Material Design 3:** Componentes de interfaz modernos como `FilterChip` interactivos, `AlertDialog` centrados y tarjetas con sombras sutiles.

## Requisitos Previos

Paa ejecutar este proyecto en tu máquina local, necesitas tener instalado:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (Configurado para desarrollo Web).
* Google Chrome (como emulador principal).
* Un editor de código como Visual Studio Code.


## ¿Cómo ejecutar la aplicación y Retos Superados?

**Nota Importante sobre el Entorno de Ejecución:**
Este proyecto fue adaptado de manera estratégica para ejecutarse de forma exclusiva en el entorno Web (Google Chrome) utilizando IndexedDB (`WebDatabase`).

**Pasos para ejecutar el proyecto en tu máquina:**

**1. Limpiar el proyecto (Recomendado):**
Para limpiar el caché y evitar conflictos con builds fallidos o rastros de código nativo.

```bash
flutter clean
```

**2. Instalar las dependencias:**
Descarga todos los paquetes necesarios.

```bash
flutter pub get
```

**3. Generar los archivos de la Base de Datos:**
Dado que el proyecto utiliza `drift` y modificamos la estructura de las tablas, es **estrictamente obligatorio** reconstruir los archivos internos antes de ejecutar la app.

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**4. Ejecutar en el navegador:**
Lanza la aplicación forzando el uso de Google Chrome como entorno de despliegue.

```bash
flutter run -d chrome
```

## Autores

* **Jorge Luis Bedoya Sanchez**
* **Valentina Rincon Granda**

---

**Universidad de Medellín | 2026**
