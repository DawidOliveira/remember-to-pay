import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginGoogleWidget extends StatelessWidget {
  const LoginGoogleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.googlePlusG),
        label: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Login com o Google'),
        ),
      ),
    );
  }
}
