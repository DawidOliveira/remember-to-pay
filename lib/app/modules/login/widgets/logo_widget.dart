import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .4,
        child: Image.asset(
          'assets/images/logo.png',
          width: double.infinity,
        ),
      ),
    );
  }
}
