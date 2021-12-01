import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:chat_app/providers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  static final routeName = "loading_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Cargando...'),
                SizedBox(height: 30),
                CircularProgressIndicator()
              ],
            )
          );
        },
      ),
   );
  }

  Future checkLoginState(BuildContext context) async{
    final _authService = Provider.of<AuthService>(context, listen: false);
    final _autenticado = await _authService.isLoggedIn();

    if(_autenticado){
      //TODO: Conectar al socket server
      //Navigator.pushReplacementNamed(context, UsuariosPage.routeName);
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __ , ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }
    else{
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __ , ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      ); 
    }
  }
}