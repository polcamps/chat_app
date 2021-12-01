

import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{

  Usuario? usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners(); //Es per notificar a tots els listeners del provider que aixo esta canviant
  }  
  //final usuario??

  //Getters del token de forma estática
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final _token = await _storage.read(key: "token");
    return _token ?? "";
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  Future<bool> login(String email, String password) async{

    this.autenticando = true;
    
    final _data = {
      "email" : email,
      "password" : password
    };

    final _resp = await http.post(Uri.parse("${Environment.apiUrl}/login"), 
      body: jsonEncode(_data),
      headers: {"Content-Type": "application/json"} 
    );

    if(_resp.statusCode == 200){
      final _loginResponse = loginResponseFromJson(_resp.body);
      this.usuario = _loginResponse.usuario;
      await this._guardarToken(_loginResponse.token);
    }

    this.autenticando = false;
    return _resp.statusCode == 200;
  }

  Future<dynamic> register(String nombre, String email, String password) async{

    this.autenticando = true;
    
    final _data = {
      "nombre": nombre,
      "email" : email,
      "password" : password
    };

    final _resp = await http.post(Uri.parse("${Environment.apiUrl}/login/new"), 
      body: jsonEncode(_data),
      headers: {"Content-Type": "application/json"} 
    );

    if(_resp.statusCode == 200){
      final _loginResponse = loginResponseFromJson(_resp.body);
      this.usuario = _loginResponse.usuario;
      await this._guardarToken(_loginResponse.token);
    }

    this.autenticando = false;

    return _resp.statusCode == 200 ? true: jsonDecode(_resp.body)["msg"];
  }

  Future<bool> isLoggedIn() async{
    final _token = await this._storage.read(key: "token");
    //final

    final _resp = await http.get(Uri.parse("${Environment.apiUrl}/login/renew"),
      headers: {
        "Content-Type": "application/json",
        "x-token": _token ?? ""
      } 
    );

    if(_resp.statusCode == 200){
      final _loginResponse = loginResponseFromJson(_resp.body);
      this.usuario = _loginResponse.usuario;
      await this._guardarToken(_loginResponse.token);
      //print(_token);
    }
    else{
      this._logOut();
    }

    return _resp.statusCode == 200;
  }

  Future _guardarToken(String token) async{
    await _storage.write(key: "token", value: token);
  }

  Future _logOut() async{
    await _storage.delete(key: "token");
  }
}