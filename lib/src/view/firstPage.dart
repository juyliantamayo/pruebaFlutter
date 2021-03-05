import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pruebaFlutter/src/view/login.dart';
class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: HexColor("#FEDD7C"),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Center(
                  child: Container(
                margin: EdgeInsets.only(top: height / 5),
                height: height / 2,
                child: Column(
                  children: [
                    Text(
                      'userapp',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height / 20),
                      width: width / 1.5,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam ",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        
                        if (await Permission.location.request().isGranted) {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()),
                            );
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
                          color: HexColor('#1A1A1A'),
                          child: Center(
                            child: Text(
                              "IR A LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  "assets/png/download@3x.png",
                  width: width * 2,
                ),
              ),
            ],
          ),
        ));
  }
}
