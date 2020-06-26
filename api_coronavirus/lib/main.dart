import 'dart:convert';
//import 'dart:html';
import 'package:api_coronavirus/estados1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

//const req = "https://covid19-brazil-api.now.sh/api/report/v1";
const req = "https://covid19-brazil-api.now.sh/api/report/v1/brazil";


//const reqSP = "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp";

void main() async {
  http.Response resposta = await http.get(req);
  //print(resposta.body);
  print((json.decode(resposta.body)));

  runApp(MaterialApp(
    home: init(),
  ));
}

Future<Map> dados1() async {
  http.Response resposta = await http.get(req);
  return json.decode(resposta.body);
}

class init extends StatefulWidget {
  @override
  _initState createState() => _initState();
}

class _initState extends State<init> {
  
 String br;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text('Dados no Brasil'),
        centerTitle: true,
      ),

      
      body: FutureBuilder<Map>(
        future: dados1(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(300, 0, 100, 0)),
                Text(
                  'Carregando Dados...',
                  style: TextStyle(color: Colors.purple, fontSize: 30),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                  width: 50.0,
                  height: 50.0,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar!",
                  style: TextStyle(color: Colors.purple, fontSize: 30)),
            );
          } else {
            br = snapshot.data["data"]["country"].toString();
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                //padding: EdgeInsets.fromLTRB(10, 10, 100, 10),
                children: <Widget>[
                  
                  Center(
            child: Image.asset(
              'images/covid.png',
              height: 180,
              width: double.infinity,
            ),
          ),Divider(color: Colors.white, height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text("Casos: ", style: TextStyle(color: Colors.purple[700], fontSize: 40, fontWeight: FontWeight.w500),),                        Icon(
                    Icons.assignment,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  Text(snapshot.data["data"]["confirmed"].toString(), style: TextStyle(color: Colors.blue, fontSize: 40),),
                    ],                    
                  ),Divider(color: Colors.purple, height: 0, thickness: 2, indent: 20, endIndent: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text("Mortes: ", style: TextStyle(color: Colors.purple[700], fontSize: 40, fontWeight: FontWeight.w500),),                        Icon(
                    Icons.sentiment_very_dissatisfied,
                    size: 40.0,
                    color: Colors.red,
                  ),
                  Text(snapshot.data["data"]["deaths"].toString(), style: TextStyle(color: Colors.red, fontSize: 40),),
                    ],                    
                  ),Divider(color: Colors.purple, height: 0, thickness: 2, indent: 20, endIndent: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text("Recuperados: ", style: TextStyle(color: Colors.purple[700], fontSize: 25, fontWeight: FontWeight.w500),),                        Icon(
                    Icons.sentiment_very_satisfied,
                    size: 40.0,
                    color: Colors.green,
                  ),
                  Text(snapshot.data["data"]["recovered"].toString(), style: TextStyle(color: Colors.green, fontSize: 40),),
                    ],                    
                  ),Divider(color: Colors.purple, height: 0, thickness: 2, indent: 20, endIndent: 20,),
                  Divider(color: Colors.white, height: 20,
                  
                   ),
                  Container(
                    constraints:
                        BoxConstraints.expand(height: 80.0, width: 50.0),
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                    child: Container(
                      constraints: BoxConstraints.expand(
                        height: 120.0,
                      ),

                      child:
                   ButtonTheme(
                    child: RaisedButton(
                     // padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                      onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=>new Estados1()))},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child:
                       Row(
                        children: <Widget>[
                          Text(
                        "              Estados",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Icon( Icons.public,
                          size: 25.0,
                          color: Colors.white,)
                        ],
                      ) , 
                      color: Colors.purple[300],
                      
                    ),
                    
                  ),
                     ),
                   ), 
                ],
            );

          
          }
        },
      ),
    );
  }

 
}
