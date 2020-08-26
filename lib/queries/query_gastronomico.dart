class QueryGastronomico {

  static String getAll = """
    {
      gastronomicos {
        id
        nombre
        domicilio
        foto
        lat
        lng
        especialidad_gastronomicos {
          especialidade {
            id
            nombre
          }
        }
        actividad_gastronomicos {
          actividade {
            id
            nombre
          }
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
      calificaciones(where: {gastronomico_id: {_eq: \$establecimientoId}}) {
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