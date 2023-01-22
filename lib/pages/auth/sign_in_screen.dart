import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:producteve/utils/constants.dart';
import 'package:producteve/utils/utils.dart';
import 'package:producteve/widgets/custom_main_button.dart';
import 'package:producteve/widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = Utils().getScreenSize();
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                amazonLogo,
                height: screenSize.height * 0.10, //* h / 10,
              ),
              Container(
                height: screenSize.height * 0.5,
                width: screenSize.width * 0.8,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                      ),
                    ),
                    TextFieldWidget(
                      title: 'Email',
                      hintText: 'Enter your email',
                      controller: _emailController,
                      isObsecure: false,
                    ),
                    TextFieldWidget(
                      title: 'Password',
                      hintText: 'Enter your password',
                      controller: _passwordController,
                      isObsecure: true,
                    ),
                    CustomMainButton(
                      color: Colors.orange,
                      isLoading: false,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                      },
                      child: const Text('Sign In'),
                    ),
                    CustomMainButton(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {},
                      child: const Text('Create new account'),
                    ),
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
