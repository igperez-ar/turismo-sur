import 'package:graphql/client.dart';


class BaseProvider {

  static final String url = 'graphql-turismo.herokuapp.com/v1/graphql';

  static final HttpLink httpLink = HttpLink(
     uri: 'https://$url',
   );

  static final WebSocketLink webSocketLink = WebSocketLink(
    url: 'ws://$url',
    config: SocketClientConfig(
      autoReconnect: true,
    ),
  );

   static final Link link = httpLink.concat(webSocketLink);

   static GraphQLClient initailizeClient() {
      return GraphQLClient(
        cache: InMemoryCache(),
        link: link,
      );
   }
}