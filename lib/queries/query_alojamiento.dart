class QueryAlojamiento {
  
  static String getAll = """
    {
      alojamientos {
        id
        nombre
        domicilio
        lat
        lng
        foto
        categoria {
          id
          valor
          estrellas
        }
        clasificacione {
          id
          nombre
        }
        localidade {
          id
          nombre
        }
      }
    }
  """;

  static String getCalificaciones = """
    query getCalificaciones(\$establecimientoId: Int!) {
      calificaciones(where: {alojamiento_id: {_eq: \$establecimientoId}}) {
        id
        puntaje
        comentario
        usuario {
          id
          username
          foto
        }
        destacable {
          id
          nombre
          foto
        }
        created_at
      }
    }
  """; 
}