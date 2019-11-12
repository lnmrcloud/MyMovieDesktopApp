import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider{

  ///TOKEN FIREBASE DIEGO
  //String _firebaseToken = 'AIzaSyB9sNhT_IufSG0uCCLRZTS0Q_Pxtn5Oq-E';

  String _firebaseToken= 'AIzaSyD4pX10yhRR7W7y8omUO0ed6JnshdYZQl8';

  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    return decodedResp.containsKey('idToken')
            ? {'ok': true, 'message': 'Cuenta creada correctamente'}
            : {'ok': false, 'message': decodedResp['error']['message']};
  }

  Future<Map<String,dynamic>> login(String email, String password) async{
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

   

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    final id= decodedResp['localId'];
    

    //EL BODY PARA LA PETICION POST Y CREAR UN NUEVO PERFIL CON UN ID YA PROPORCIONADO
    final nuser = '{"fields": { "edad":{"stringValue":"0"},"apellido":{"stringValue":"apellido"},"nombre":{"stringValue":"nombre"} }}';


     //HACEMOS EL POST PARA LOS PERFILES DE USUARIO
      final resp2 = await http.post(
      'https://firestore.googleapis.com/v1/projects/prueba-b2fd7/databases/(default)/documents/perfiles?documentId='+id,
       body: nuser
       );

       //print(json.encode(nuser));

    return decodedResp.containsKey('idToken')
            ? {'ok': true, 'message': 'Se ingreso correctamente','id':id}
            : {'ok': false, 'message': decodedResp['error']['message']};
  }

}