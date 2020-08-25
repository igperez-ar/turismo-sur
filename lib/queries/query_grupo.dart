class QueryGrupo {

  static String getAll = """
    query getAll(\$usuarioId: bigint!) {
      grupos(where: {id: {}, miembros: {usuario: {id: {_eq: \$usuarioId}}}}) {
        id
        nombre
        descripcion
        foto
        individual
        miembros {
          id
          role {
            id
            nombre
            valor
          }
          usuario {
            id
            nombre
            username
            foto
            descripcion
          }
        }
      }
    }
  """;

  static String getOne = """
    query getOne(\$grupo: Int!) {
      grupos(where: {id: {_eq: \$grupo}}) {
        id
        nombre
        descripcion
        foto
        individual
        miembros {
          id
          role {
            id
            nombre
            valor
          }
          usuario {
            id
            nombre
            username
            foto
            descripcion
          }
        }
      }
    }
  """;

  static String getMensajes = """
    query getMensajes(\$grupo: Int!) {
      grupos(where: {id: {_eq: \$grupo}}) {
        mensajes {
          id
          contenido
          eliminado
          miembro {
            id
            usuario {
              id
              username
            }
          }
        }
      }
    }
  """;
}