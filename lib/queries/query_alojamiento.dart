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
}