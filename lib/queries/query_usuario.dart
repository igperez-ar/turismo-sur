class QueryUsuario {

  static String getAll = """
    {
      usuarios {
        id
        nombre
        descripcion
        foto
        email
        username
        password
      }
    }
  """;

  static String getOne = """
    query getOne(\$username: String!) {
      usuarios(where: {username: {_eq: \$username}}) {
        id
        nombre
        descripcion
        foto
        email
        username
        password
      }
    }
  """;

  static String addUsuario = """
    mutation addUsuario(\$nombre: String!, \$username: String!, \$password: String!, \$email: String!) {
      insert_usuarios(objects: [{nombre: \$nombre, username: \$username, password: \$password, email: \$email, miembros: {data: {rol_id: 3, grupo_id: 1}}}]) {
        returning {
          id
          nombre
          descripcion
          foto
          email
          username
          password
        }
      }
    }
  """;

  static String updateUsuario = """
    mutation updateUsuario(\$oldUsername: String!, \$nombre: String! \$foto: String! \$descripcion: String! \$email: String! \$newUsername: String! \$password: String!) {
      update_usuarios(where: {username: {_eq: \$oldUsername}}, _set: {nombre: \$nombre, foto: \$foto, descripcion: \$descripcion, email: \$email, username: \$newUsername, password: \$password}) {
        returning {
          id
          nombre
          foto
          descripcion
          email
          username
          password
        }
      }
    }
  """;
}