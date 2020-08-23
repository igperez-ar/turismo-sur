import 'package:graphql/client.dart';


class BaseProvider {

  static GraphQLClient create() {
    final httpLink = HttpLink(uri:'https://graphql-turismo.herokuapp.com/v1/graphql');
    final link = Link.from([httpLink]);

    return GraphQLClient(
      cache: InMemoryCache(), 
      link: link
    );
  }
}