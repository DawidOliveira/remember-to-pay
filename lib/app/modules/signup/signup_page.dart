import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/input_signup_widget.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
                            'CADASTRE-SE',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
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
                          Center(
                            child: RxBuilder(
                              builder: (_) => AnimatedSize(
                                duration: Duration(milliseconds: 300),
                                vsync: this,
                                curve: Curves.linear,
                                child: SizedBox(
                                  width: controller.widthButton.value,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.signUp(context);
                                    },
                                    child: !controller.loading.value
                                        ? Text(
                                            'CADASTRAR',
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
