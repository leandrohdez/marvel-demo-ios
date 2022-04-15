![Marvel Logo](README_FILES/marvel-logo.png)
# Marvel iOS App 

Aplicación iOS de ejemplo que hace uso del api de Marvel: (https://developer.marvel.com/docs)

## Arquitectura

El proyecto se ha diseñado en una arquitectura multicapas que definen los niveles de responsabilidad sobre las funcionalidades de la aplicación. Cada una de estas capas o niveles contiene un conjunto de clases con responsabilidades relacionadas con la capa a la que pertenecen. 

Las capas implicadas son: 

- Capa Presentación: 

Responsable de la correcta presentación de la información para el usuario teniendo en cuenta las condiciones y características del entorno, así como del dispositivo desde el que se consulta. En esta capa intervienen los objetos más próximos a la interacción con el usuario como son los componentes UI, las vistas y todos aquellos objetos que sirven de apoyo a esta tarea. 

Los objetos de esta capa también gestionan las navegaciones, los flujos, así como otras cuestiones adicionales propias de la interacción con el dispositivo como pueden ser los permisos, configuraciones, recursos, etc. 

- Capa Lógicas de negocio:  

Responsable de modelar y definir las condiciones, reglas del negocio. También es responsable de definir y ejecutar los casos de uso del negocio. En esta capa intervienen los objetos que modelan el negocio como son: las Entidades del negocio, las clases de Casos de Uso, Paquetes y Módulos de lógicas, etc. 

- Capa Acceso a datos:  

Responsable realizar las solicitudes de datos a las fuentes de información. En esta capa intervienen los objetos que realizan tareas para obtener, guardar, editar y eliminar información necesaria desde los casos de uso. 

