import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {

  static final routeName = "register_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height*.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(titulo: "Registro"),
                _FormWidget(),
                Labels(
                  titulo: "¿Ya tienes una cuenta?",
                  subTitulo: "Ingresa ahora!",
                  ruta: LoginPage.routeName,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40), 
                  child: Text("Términos y condiciones de uso", style: TextStyle(fontWeight: FontWeight.w300))
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({ Key? key }) : super(key: key);

  @override
  __FormWidgetState createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            keybordType: TextInputType.name,
            prefixIcon: Icons.perm_identity,
            hintText: "Nombre",
            textController: _nameController,
          ),
          CustomInput(
            keybordType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline,
            hintText: "Email",
            textController: _emailController,
          ),
          CustomInput(
            prefixIcon: Icons.lock_outline,
            hintText: "Contraseña",
            textController: _passwordController,
            isPassword: true,
          ) ,
          BotonAzul(
            text: "Ingrese", 
            onPressed: (){
              print(_emailController.text);
              print(_passwordController.text);
            }
          )
        ]
      ),
    );
  }
}