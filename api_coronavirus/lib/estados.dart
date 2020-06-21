/*import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//const req = "https://covid19-brazil-api.now.sh/api/report/v1";

void main() async {
  http.Response resposta = await http.get("https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp");
  //print(resposta.body);
  print((json.decode(resposta.body)));

  runApp(MaterialApp(
    home: estados(),
  ));
}

Future<Map> dados1() async {
  http.Response resposta = await http.get(req);
  return json.decode(resposta.body);
}

class estados extends StatefulWidget {
  @override
  _estadosState createState() => _estadosState();
}

class _estadosState extends State<estados> {
  
  String sp = "sp";
  String spCasos;
  String spMortes;
  String spSuspeitos;

  String rj;
  String rjCasos;
  String rjMortes;
  String rjSuspeitos;

  String ce;
  String ceCasos;
  String ceMortes;

  String pe;
  String peCasos;
  String peMortes;

  String ba;
  String baCasos;
  String baMortes;
  String baSuspeitos;

  String df;
  String dfCasos;
  String dfMortes;
  String dfSuspeitos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('Covid-19'),
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
            sp = snapshot.data["data"]["state"].toString();
            spCasos = snapshot.data["data"]["cases"].toString();
           /* spMortes = snapshot.data["data"][0]["deaths"].toString();
            spSuspeitos = snapshot.data["data"][0]["suspects"].toString();

            rj = snapshot.data["data"][1]["state"].toString();
            rjCasos = snapshot.data["data"][1]["cases"].toString();
            rjMortes = snapshot.data["data"][1]["deaths"].toString();
            rjSuspeitos = snapshot.data["data"][1]["suspects"].toString();

            ce = snapshot.data["data"][2]["state"].toString();
            ceCasos = snapshot.data["data"][2]["cases"].toString();
            ceMortes = snapshot.data["data"][2]["deaths"].toString();
            //spSuspeitos = snapshot.data["data"][0]["suspects"].toString();

            pe = snapshot.data["data"][3]["state"].toString();
            peCasos = snapshot.data["data"][3]["cases"].toString();
            peMortes = snapshot.data["data"][3]["deaths"].toString();

            ba = snapshot.data["data"][5]["state"].toString();
            baCasos = snapshot.data["data"][5]["cases"].toString();
            baMortes = snapshot.data["data"][5]["deaths"].toString();
            baSuspeitos = snapshot.data["data"][5]["suspects"].toString();

            df = snapshot.data["data"][13]["state"].toString();
            dfCasos = snapshot.data["data"][13]["cases"].toString();
            dfMortes = snapshot.data["data"][13]["deaths"].toString();
            dfSuspeitos = snapshot.data["data"][13]["suspects"].toString();
*/
            return SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //padding: EdgeInsets.fromLTRB(10, 10, 100, 10),
                children: <Widget>[
                  Text(
                    'Dados Por Estado',
                    style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Center(
            child: Image.asset(
              'images/covid.png',
              height: 180,
              width: double.infinity,
            ),
          ),
                  Container(
                    constraints:
                        BoxConstraints.expand(height: 80.0, width: 50.0),
                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                    child: Container(
                      constraints: BoxConstraints.expand(
                        height: 120.0,
                      ),

                      child: ButtonTheme(
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          onPressed: () => {showAlertDialog1(context)},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "São Paulo",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ), //Text
                          color: Colors.purple[200],
                        ), //RaisedButton
                      ),

                    ),
                  ),
                  Divider(color: Colors.white,),
                  ButtonTheme(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () => {showAlertDialog2(context)},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Rio de Janeiro",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ), //Text
                      color: Colors.purple[200],
                    ), //RaisedButton
                  ), //Button

                  Divider(color: Colors.white,),

                  ButtonTheme(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: () => {showAlertDialog3(context)},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Distrito Federal",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ), //Text
                      color: Colors.purple[200],
                    ), //RaisedButton
                  ), //Button

                  Divider(color: Colors.white,),

                  ButtonTheme(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(120, 10, 120, 10),
                      onPressed: () => {showAlertDialog4(context)},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Bahia",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ), //Text
                      color: Colors.purple[200],
                    ), //RaisedButton
                  ), //Button

                ],
              ),
            );

          }
        },
      ),
    );
  }

  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 20, color: Colors.purple),
      
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => estados()));
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      actionsPadding: EdgeInsets.fromLTRB(100, 50, 100, 50),
      title: Text(
        '$sp',
        style: TextStyle(color: Colors.purple, fontSize: 25),
      ),
      content: Text(
        "total de casos: $spCasos",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        okButton,
      ],
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

 /* showAlertDialog2(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 20, color: Colors.purple),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => estados()));
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      actionsPadding: EdgeInsets.fromLTRB(100, 50, 100, 50),
      title: Text(
        '$rj',
        style: TextStyle(color: Colors.purple, fontSize: 25),
      ),
      content: Text(
        "total de casos: $rjCasos\nnumero de mortes: $rjMortes\ncasos suspeitos: $rjSuspeitos",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialog3(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 20, color: Colors.purple),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => estados()));
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      actionsPadding: EdgeInsets.fromLTRB(100, 50, 100, 50),
      title: Text(
        '$df',
        style: TextStyle(color: Colors.purple, fontSize: 25),
      ),
      content: Text(
        "total de casos: $dfCasos\nnumero de mortes: $dfMortes\ncasos suspeitos: $dfSuspeitos",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        okButton,
      ],
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialog4(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 20, color: Colors.purple),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => estados()));
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      actionsPadding: EdgeInsets.fromLTRB(100, 50, 100, 50),
      title: Text(
        '$ba',
        style: TextStyle(color: Colors.purple, fontSize: 25),
      ),
      content: Text(
        "total de casos: $baCasos\nnumero de mortes: $baMortes\ncasos suspeitos: $baSuspeitos",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        okButton,
      ],
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
  */
}

*/