
import 'dart:async';
import 'dart:convert';
import 'package:example_flutter/src/utils/constants.dart';
import 'package:http/http.dart';
import 'package:example_flutter/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:example_flutter/src/widgets/custom_text_field.dart';
import 'package:example_flutter/src/widgets/custom_filled_button.dart';
import 'package:http/http.dart';


  UsuarioProvider _usuarioProvider = new UsuarioProvider();
  String idfinal="";
  String _nombre;
  String _apellido;

class Perfil_usuario extends StatefulWidget {


  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<Perfil_usuario> {

  String _idviajero='';
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://cdn2.iconfinder.com/data/icons/business-management-52/96/Artboard_20-512.png';

    _idviajero= ModalRoute.of(context).settings.arguments ?? '';
    idfinal=_idviajero;

    print(_idviajero);
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de Usuario"),
      ),
      body: FutureBuilder(
          future: traerDatos(_idviajero),
          builder: (context, snapshot) {
            final Map data = snapshot.data;
            print(snapshot);
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Error Ocurrio",
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ));
            } else if (snapshot.hasData) {
              Map r = snapshot.data;
              final f= r['fields'];
              final s1=f['nombre'];
              final s2=f['apellido'];
              final s3=f['edad'];
              final nombre= s1['stringValue'];
              final apellido= s2['stringValue'];
              final edad= s3['stringValue'];
              return Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: _height/12,),
                new CircleAvatar(radius:_width<_height? _width/8:_height/8,backgroundImage: NetworkImage(imgUrl),),
                new SizedBox(height: _height/25.0,),
                new Divider(height: _height/30,color: Colors.white,),
                new Row(
                  children: <Widget>[
                    rowCell('Nombre', nombre),
                    rowCell('Apellido', apellido),
                    rowCell('Edad', edad),
                  ],
                  ),
                  new Row(
                  children: <Widget>[
                    name_input(),
                    lastname_input()
                  ],
                  ),
                new Divider(height: _height/30,color: Colors.white),
                new Padding(padding: new EdgeInsets.only(left: _width/8, right: _width/8), 
                child: new FlatButton(
                  onPressed: (){
                    _actualizarDatos();
                  },
                  child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                    new Icon(Icons.person),
                    new SizedBox(width: _width/30,),
                    new Text('Actualizar Datos')
                  ],)),color: Colors.blue[50],),),
              ],
            ),
          );

            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );

    
  }



  /**Future<void> _descargar(String path) async {
    Pluggins de descarga de archivos aun no tiene soporte sobre desktop - flutter 2019

    Dio dio = Dio();

    final dirToSave = await getApplicationDocumentsDirectory();

    await dio.download(path, '${dirToSave.path}/myImage.jpg',
        onReceiveProgress: (rec, total) {
    });
  }
  **/
Future <Map> traerDatos(String id) async{

  final url = 'https://firestore.googleapis.com/v1/projects/prueba-b2fd7/databases/(default)/documents/perfiles/'+id+'';
  print(url);
  final response = await get(url);
  return json.decode(response.body);
    
  }

}


Widget name_input() => new Expanded(
    child: new Column(
    children: <Widget>[
      TextField(
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 17),
        hintText: 'Nombre',
        suffixIcon: Icon(Icons.person),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(20)),
      onChanged: (text) {
        _nombre=text;
        print(_nombre);
      }
      )
    
  ],));

  Widget lastname_input() => new Expanded(
    child: new Column(
    children: <Widget>[
      TextField(
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 17),
        hintText: 'Apellido',
        suffixIcon: Icon(Icons.person),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(20)),
      onChanged: (text) {
        _apellido=text;
        print(_apellido);
      }
      )
    
  ],));

  void _actualizarDatos() async{

    Map respuesta = await _usuarioProvider.actualizar(_nombre, _apellido, idfinal);

  }
  


  Widget rowCell(String header, String type) => new Expanded(
    child: new Column(
    children: <Widget>[
    new Text(header==null?'':header,style: new TextStyle(color: Colors.black),),
    new Text(type==null?'':type,style: new TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
  ],));



  