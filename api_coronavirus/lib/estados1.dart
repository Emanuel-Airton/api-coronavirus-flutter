import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:getflutter/getflutter.dart';

class Estados1 extends StatefulWidget {
  @override
  _Estados1State createState() => _Estados1State();
}

class _Estados1State extends State<Estados1> {
  String text;
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
                    Row(
                     children: [
                       Expanded(child: 
                        TextField(
                      controller: estadoController,
                      decoration: InputDecoration(
                          labelText: " Insira as iniciais do estado Ex: sp", labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      onSubmitted: (text) {
                        est = text;
                        setState(() {
                          // return Text(estado);
                        });
                      },
                    ),  
                       ),
                       
                    IconButton(icon: Icon(Icons.search, color: Colors.purple,),
                      onPressed: (){
                        setState(() {
                          est = estadoController.text;  
                        });
                      
                      })
                     ], 
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
                    Padding(padding: EdgeInsets.only(top: 20),
                    child:
                     GFButton(
                onPressed: (){
                  int index;
                  options(context, index); 
                },
                text: "Central de Atendimento",
                icon: Icon(Icons.phone_in_talk, color: Colors.white,),
                color: Colors.purple[300],
                blockButton: true,
                size: 40,
                type: GFButtonType.solid,
              ),
                    
                    )
                    
                    
                  ],
                )
                ),
              ),
              ) ;
             
            }
          }),
    );
  }

  void options(BuildContext context, int index){
    showModalBottomSheet(
      context: context,
     builder: (context){
       return BottomSheet(
         onClosing: (){ 

         },
         builder: (context){
            return 
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Text("Central de Atendimento", style: TextStyle(fontSize: 20, color: Colors.purple, fontWeight: FontWeight.w900),),
                  Padding(padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     FlatButton(
                    child: Text("Ministério da saúde", style: TextStyle(color: Colors.purple[300], fontSize: 20, fontWeight: FontWeight.w700),),
                    onPressed: ()async {
                      await _whpp();
                    },
                     ),
                     Image.asset('images/icone2.png', height: 30,)
                   ], 
                  ) 
                  
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       FlatButton(
                    child: Text("Disque Saude 136", style: TextStyle(color: Colors.purple[300], fontSize: 20, fontWeight: FontWeight.w700),),
                    onPressed: ()async{
                      await _diskSaude();
                    },
                     ),
                     Image.asset('images/icone3.png', height: 30,)


                    ],


                  )
                 
                ],
              ),
            );
          }
    
      
      );
  });
}
_whpp()async{
  const url = 'https://api.whatsapp.com/send?phone=556199380031&text=oi&source=&data=&app_absent=';
  if(await canLaunch(url)){
    await launch(url);
  }else{
    throw 'Não foi Possivel acessar $url';
  }
}
_diskSaude()async{
  const url2 = 'tel: 136';
  if(await canLaunch(url2)){
    await launch(url2);
  }else{
    throw 'Não foi Possivel acessar $url2';
  }
}
}
