import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext context)> appRoutes = {
  ChatPage.routeName: ( _ ) => ChatPage(),
  LoadingPage.routeName: ( _ ) => LoadingPage(),
  LoginPage.routeName: ( _ ) => LoginPage(),
  RegisterPage.routeName: ( _ ) => RegisterPage(),
  UsuariosPage.routeName: ( _ ) => UsuariosPage(),
};