class QueryUsuario {

  String addUsuario(String nombre, String username, String password, String email) {
    return """
      mutation {
        insert_usuarios(objects: [{nombre: "$nombre", username: "$username", password: "$password", email: "$email"}]) {
          returning {
            id
            nombre
            apellido
            foto
            email
            username
          }
        }
      }
    """;
  }

  String getAll() {
    return """
      {
        usuarios {
          id
          nombre
          apellido
          foto
          email
          username
          password
        }
      }
    """;
  }

  String getOne(String username) {
    return """
      {
        usuarios(where: {username: {_eq: "$username"}}) {
          id
          nombre
          apellido
          foto
          email
          username
          password
        }
      }
    """;
  }
}