class QueryCalificacion {

  static String addCalificacion = """
    mutation addCalificacion(\$puntaje: Int!, \$comentario: String!, \$usuarioId: Int!, \$alojamientoId: Int, \$gastronomicoId: Int, \$destacableId: Int) {
      insert_calificaciones(objects: {puntaje: \$puntaje, comentario: \$comentario, usuario_id: \$usuarioId, alojamiento_id: \$alojamientoId, gastronomico_id: \$gastronomicoId, destacable_id: \$destacableId}) {
        affected_rows
      }
    }
  """;

  static String updateCalificacion = """
    mutation updateCalificacion(\$calificacionId: Int!, \$puntaje: Int!, \$comentario: String!, \$destacableId: Int) {
      update_calificaciones(where: {id: {_eq: \$calificacionId}}, _set: {puntaje: \$puntaje, comentario: \$comentario, destacable_id: \$destacableId}) {
        affected_rows
      }
    }
  """;

  static String deleteCalificacion = """
    mutation deleteCalificacion(\$calificacionId: Int!) {
      delete_calificaciones(where: {id: {_eq: \$calificacionId}}) {
        affected_rows
      }
    }
  """;

  static String getDestacables = """
    query getDestacables {
      destacables {
        id
        nombre
        foto
        tipo
      }
    }
  """;
}