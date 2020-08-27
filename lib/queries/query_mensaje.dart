class QueryMensajes {

  static String getAll = """
    subscription getAll(\$grupo: Int!) {
      mensajes(where: {grupo_id: {_eq: \$grupo}}, order_by: {created_at: asc}) {
        id
        contenido
        eliminado
        grupo_id
        created_at
        updated_at
        miembro {
          id
          usuario {
            id
            username
            nombre
            foto
            descripcion
          }
        }
      }
    }
  """;

  static String addMensaje = """
    mutation addMensaje(\$contenido: String!, \$grupo: Int!, \$miembro: Int!) {
      insert_mensajes(objects: {contenido: \$contenido, grupo_id: \$grupo, miembro_id: \$miembro}) {
        returning {
          id
          contenido
          eliminado
          miembro_id
          grupo_id
          created_at
          updated_at
        }
      }
    }
  """;
}