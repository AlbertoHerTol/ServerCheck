import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/*-------------------------------------------------  PLANTILLA STATEFUL
class Formulario extends StatefulWidget{
  @override
  FormularioState createState(){
    print("CreateState de Formulario");
    return new FormularioState();
  }
}
class FormularioState extends State<Formulario>{
  @override
  Widget build (BuildContext context){
    return Text(" Hola");
  }
}
 */


class Inicio extends StatefulWidget{
  @override
  InicioState createState(){
    print("CreateState de Formulario");
    return new InicioState();
  }
}
class InicioState extends State<Inicio>{
  Icon _icono = Icon(Icons.check_circle, size:200);
  bool _check = true;
  TextEditingController _myController = TextEditingController();
  String _server = '';

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  Future<String> consultar() async {
    print("Lanza la consulta :-)");
    var respuesta = await http.get(_server); //await para que espere
    // sample info available in response
    int statusCode = respuesta.statusCode;
    Map<String, String> headers = respuesta.headers;
    String contentType = headers['content-type'];
    String js = respuesta.body;
    print(statusCode.toString()+"\n"+ headers.toString()+"\n"+ js.toString());
    print(respuesta.toString());
    return(js);
  }

  click(){
    _server=_myController.text;
    print('click button');
    var s = consultar().then((x){
      print('Entrando en then() Respuesta = '+x);
      setState((){
        if(x==('0')) _check=false;
        else _check=true;
        if (_check) _icono = Icon(Icons.check_circle, size:200);
        else _icono = Icon(Icons.warning, size:200);

      });
    });// la funcion asincrona usa then
    print(s.toString());

  }


  @override
  Widget build (BuildContext context){
    return ListView(
          padding: const EdgeInsets.all(8),
          children:[
            Container(
              padding: EdgeInsets.only(top:10),
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    _icono,
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:10),
              child:Row(children:[
                Expanded(child:
                TextField(
                  controller: _myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'URL',
                  ),
                ),
                ),
              ]
              ),
            ),
            Container(
                padding: EdgeInsets.only(top:10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                          ),
                          child:FlatButton(
                            onPressed: (){click();},
                            child: Text('Check'),
                          )
                      )
                  ]
                ),
            )
        ]
      );


  }
}