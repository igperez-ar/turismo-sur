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
}