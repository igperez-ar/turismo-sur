# Turismo Sur

Es una aplicación desarrollada principalmente con las tecnologías Flutter y GraphQL para la materia Taller de Nuevas Tecnologías de la Universidad Nacional de Tierra del Fuego A.I.A.S.

## Funcionalidades
El siguiente conjunto de funcionalidades son las mínimas requeridas para la aprobación del trabajo, y fueron realizadas con la tecnología mencionada, utilizando la base de datos provista durante la cursada.

- **Alojamientos**
  - Listado
  - Mapa
  - Filtrado por nombre, localidad, categoría y clasificación
  - Ficha del alojamiento
  - Obtención de los datos mediante [API REST](http://postgrest.org/en/v6.0/)

- **Gastronómicos**
  - Listado
  - Mapa
  - Filtrado por nombre, especialidad, localidad y actividad
  - Ficha del gastronómico
  - Obtención de los datos mediante [API GraphQL](https://pub.dev/packages/graphql_flutter)
  
- **Favoritos**
  - Permitir al usuario poder *guardar* como favoritos tanto alojamientos como gastronómicos
  - Listado
  - Mapa
  - Filtrado por nombre
  - Acceso a la ficha del establecimiento
  - Agregar imágenes desde la cámara o la galería para agendarlas como recuerdos
  
- **Mapas**
  - Mostrar la posición del usuario
  
- **Autenticación**
  - Inicio de sesión *(No se requiere mecanismo formal de autenticación)*
  - Registro
  - Modificación de datos personales

- **Calificaciones**
  - Permitir al usuario dar una reseña y un puntaje *(en forma de 'Bueno', 'Regular', 'Malo')*
  - Resumen del puntaje del establecimiento

- **Chat**
  - Permitir al usuario ingresar a una sala donde todos los usuarios de la app puedan escribir 
  
 ***Para la presentación final del trabajo se puede utilizar un sólo tipo de api (REST o GraphQL) para implementar las calificaciones en ambos establecimientos.***
