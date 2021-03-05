import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphApi {
  final HttpLink httpLink = HttpLink(
    'https://graphqlzero.almansi.me/api',
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
  }
}

class GraphQLConfiguration {}
