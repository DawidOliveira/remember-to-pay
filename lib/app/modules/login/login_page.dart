import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/modules/login/widgets/input_login_widget.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FAÇA O LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InputLoginWidget.email(
                            validator: (value) {
                              if (value != null &&
                                  value.length > 5 &&
                                  value.contains('@')) {
                                return null;
                              }
                              return 'E-mail inválido, verifique se digitou corretamente!';
                            },
                            textEditingController: controller.email,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputLoginWidget.pass(
                            validator: (value) {
                              if (value != null && value.length > 5) {
                                return null;
                              }
                              return 'Senha inválida, deve conter no mínimo 6 caracteres!';
                            },
                            textEditingController: controller.pass,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Text(
                                'Esqueceu a senha?',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RxBuilder(
                              builder: (_) => AnimatedSize(
                                duration: Duration(milliseconds: 200),
                                vsync: this,
                                curve: Curves.linear,
                                child: Container(
                                  width: controller.widthButton.value,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.signIn(context);
                                    },
                                    child: !controller.loading.value
                                        ? Text(
                                            'ACESSAR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "OU",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.googlePlusG),
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Login com o Google'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta?',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoute.SIGNUP);
                      },
                      child: Text('Cadastre-se'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
