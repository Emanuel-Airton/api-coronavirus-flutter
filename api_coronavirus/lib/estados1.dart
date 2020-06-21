import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Estados1 extends StatefulWidget {
  @override
  _Estados1State createState() => _Estados1State();
}

class _Estados1State extends State<Estados1> {
  String estado;
  String _cases;
  String _mortes;
  String _suspeitos;
  String est;
  final estadoController = TextEditingController();

  Future<Map> mapa() async {
    http.Response resposta = await http
        .get("https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/$est");
    return json.decode(resposta.body);
  }

  void _cont(String text) {
    estadoController.text = est;
  }

  /* @override
  void initState() {
    
    super.initState();
    est=estadoController.text;
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estados"),
        centerTitle: true,
        backgroundColor: Colors.purple[400],
      ),
      body: FutureBuilder<Map>(
          future: mapa(),
          builder: (contaxt, snapshot) {
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
              return Center(child: Text("Erro!!"));
            } else {
              estado = snapshot.data["state"].toString();
              _cases = snapshot.data["cases"].toString();
              _mortes = snapshot.data["deaths"].toString();
              _suspeitos = snapshot.data["suspects"].toString();
              return SingleChildScrollView(
                child:  Padding(
                padding: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 20),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    TextField(
                      controller: estadoController,
                      decoration: InputDecoration(
                          labelText: " Insira as iniciais do estado Ex: sp", labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      onSubmitted: (text) {
                        est = text;
                        setState(() {
                          // return Text(estado);
                        });
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      est == null ? " " : estado,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.purple),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Casos: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.blue)),
                        Icon(
                          Icons.assignment,
                          size: 50.0,
                          color: Colors.blue,
                        ),
                        Text(est == null ? "" : _cases,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.blue)),
                      ],
                    ),
                    Divider(
                      color: Colors.purple,
                      height: 0,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Mortes: ",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.sentiment_very_dissatisfied,
                          size: 50.0,
                          color: Colors.red,
                        ),
                        Text(est == null ? "" : _mortes,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.red)),
                      ],
                    ),
                    Divider(
                      color: Colors.purple,
                      height: 0,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Suspeitos: ",
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.sentiment_neutral,
                          size: 50.0,
                          color: Colors.yellow[800],
                        ),
                        Text(est == null ? "" : _suspeitos,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.yellow[800])),
                      ],
                    ),
                    Divider(
                      color: Colors.purple,
                      height: 0,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                )),
              ),
              ) ;
             
            }
          }),
    );
  }
}
