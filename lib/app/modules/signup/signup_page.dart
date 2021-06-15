import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/input_signup_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
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
                        Modular.get<Config>().theme.value == 0
                            ? 'assets/images/logo.png'
                            : 'assets/images/logo-white.png',
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
                            'CADASTRE-SE',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InputSignUpWidget(
                            textEditingController: controller.name,
                            hint: 'Nome completo',
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value != null && value.length > 3) {
                                return null;
                              }
                              return 'O nome deve ter mais de 3 caracteres!';
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputSignUpWidget.email(
                            textEditingController: controller.email,
                            validator: (value) {
                              if (value != null &&
                                  value.length > 5 &&
                                  value.contains('@')) {
                                return null;
                              }
                              return 'E-mail inválido, verifique se digitou corretamente!';
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputSignUpWidget.pass(
                            textEditingController: controller.pass,
                            validator: (value) {
                              if (value != null && value.length > 5) {
                                return null;
                              }
                              return 'A senha deve ter mais de 6 caracteres!';
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.signUp();
                              },
                              child: Text(
                                'CADASTRAR',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                              onPressed: () async {
                                await controller.signUpWithGoogle();
                              },
                              icon: Icon(FontAwesomeIcons.googlePlusG),
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Cadastre-se com o Google'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
