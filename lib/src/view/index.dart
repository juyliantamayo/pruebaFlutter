import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pruebaFlutter/src/service/graphApi.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Widget listaCards = CircularProgressIndicator();
  double height;
  double width;
  @override
  void initState() {
    super.initState();
    ejecutarConsulta();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            backgroundColor: Colors.white,
            actions: [
              GNav(
                  curve: Curves.easeOutExpo, // tab animation curves
                  duration:
                      Duration(milliseconds: 900), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: Colors.grey[800], // unselected icon color
                  // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor: HexColor("#FEDD7C"),
                  // selected tab background color
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5), // navigation bar padding
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.chat_outlined,
                      text: 'Likes',
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.person_outline_outlined,
                      text: 'Profile',
                    )
                  ]),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: width / 20, top: height / 20),
                child: Text(
                  'CONTACTOS',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: listaCards,
                height: height - height / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> ejecutarConsulta() async {
    GraphApi graphApi = new GraphApi();
    GraphQLClient _client = graphApi.clientToQuery();
    QueryResult queryResult =
        await _client.query(QueryOptions(document: gql('''{albums(options:{}){
    data{user{name,email},photos{data{url}}}
  }}''')));
    print(queryResult.data["albums"]["data"]);
    List listaData = queryResult.data["albums"]["data"];
    setState(() {
      listaCards = ListView(
        children: listaData
            .map((data) => Container(
                  width: width,
                  child: Card(
                      color: HexColor("#FEDD7C"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.transparent,
                              width: width / 5,
                              child: Card(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60)),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      data["photos"]["data"][0]["url"]
                                          .toString(),
                                    )),
                              )),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  data["user"]["name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data["user"]["email"],
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: HexColor("#FEDD7C"),
                            size: 20,
                          ),
                        ],
                      )),
                ))
            .toList(),
      );
    });
  }
}
