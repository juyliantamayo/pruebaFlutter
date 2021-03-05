import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pruebaFlutter/src/service/graphApi.dart';
import 'package:pruebaFlutter/src/view/index.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool banderaCirsularProgresIndicator = false;
  String user;
  String password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Scaffold(
            backgroundColor: HexColor("#FEDD7C"),
            body: SingleChildScrollView(
                child: Stack(children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: height / 2.5),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100)),
                      ),
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(top: height / 6),
                        width: width / 1.2,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width / 8,
                                  child: Icon(
                                    Icons.person_outline,
                                    color: HexColor("#FFDE7C"),
                                    size: 45,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: width / 19),
                                  width: width / 1.6,
                                  child: TextFormField(
                                    onChanged: (element) {
                                      user = element;
                                    },
                                    decoration:
                                        InputDecoration(hintText: "Username"),
                                    validator: (element) {
                                      return element;
                                    },
                                  ),
                                )
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: height / 19),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width / 8,
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: HexColor("#FFDE7C"),
                                        size: 45,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: width / 19),
                                      width: width / 1.6,
                                      child: TextFormField(
                                        obscureText: true,
                                        onChanged: (element) {
                                          password = element;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Password"),
                                        validator: (element) {
                                          return element;
                                        },
                                      ),
                                    )
                                  ],
                                )),
                            GestureDetector(
                              onTap: () {
                                if (user != null && password != null) {
                                  ejecutarConsulta();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: height / 18),
                                width: width / 1.6,
                                height: height / 12,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  color: HexColor('#FEDD7C'),
                                  child: Center(
                                    child: banderaCirsularProgresIndicator
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "SIGN IN",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: height / 25, left: width / 9),
                                child: Row(
                                  children: [
                                    Text(
                                      "Don’t have an account?  ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(
                                      "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: HexColor("#FEDD7C")),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
                  height: height / 1.6,
                  width: width * 2,
                ),
              ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Center(
                    child: Image.asset(
                  "assets/png/download.png",
                  scale: 2,
                )),
              ),
            ]))));
  }

  Future<void> ejecutarConsulta() async {
    GraphApi graphApi = new GraphApi();
    GraphQLClient _client = graphApi.clientToQuery();
    setState(() {
      banderaCirsularProgresIndicator = true;
    });
    QueryResult queryResult = await _client.query(
        QueryOptions(document: gql('''{users(options:{search:{q:"${user}"}}) {
      data{
        username,
        email,
        phone,
        name
      }
    }}''')));
    if (queryResult.data['users']['data'][0]["username"]
                .toString()
                .toLowerCase() ==
            user.toLowerCase() &&
        queryResult.data['users']['data'][0]["phone"]
                .toString()
                .toLowerCase() ==
            password.toLowerCase()) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Index()),
      );
    }
  }
}
