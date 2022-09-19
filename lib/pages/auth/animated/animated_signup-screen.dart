import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:producteve/layout/layout_screen.dart';
import 'package:producteve/pages/auth/animated/animated_login_screen.dart';
import 'package:producteve/resources/authentication_methods.dart';
import 'package:producteve/utils/utils.dart';
import 'widgets/component1.dart';
import 'widgets/component2.dart';
import 'widgets/scroll_behavior.dart';

class AnimatedSignupScreen extends StatefulWidget {
  const AnimatedSignupScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedSignupScreen> createState() => _AnimatedSignupScreenState();
}

class _AnimatedSignupScreenState extends State<AnimatedSignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationMethods _authenticationMethods = AuthenticationMethods();
  bool _isLoading = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    )..addListener(() {
        setState(() {});
      });
    _transform = Tween<double>(begin: 2, end: 1).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn));
    _controller.forward();
    super.initState();
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String output = await _authenticationMethods.signUpUser(
      name: _userNameController.text,
      address: _addressController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (output == 'success') {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LayoutScreen(),
          ));
    } else {
      if (!mounted) return;
      showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: output,
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: h,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffFEC37B),
                    Color(0xffFF4184),
                  ],
                ),
              ),
              child: _isLoading
                  ? const Loader()
                  : Opacity(
                      opacity: _opacity.value,
                      child: Transform.scale(
                        scale: _transform.value,
                        child: Container(
                          height: w * 1.1,
                          width: w * .9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 90,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(.7),
                                ),
                              ),
                              const SizedBox(),
                              Component1(
                                icon: Icons.account_circle_outlined,
                                hintText: 'User name',
                                isPassword: false,
                                isEmail: false,
                                controller: _userNameController,
                              ),
                              Component1(
                                icon: Icons.location_city,
                                hintText: 'Address',
                                isPassword: false,
                                isEmail: false,
                                controller: _addressController,
                              ),
                              Component1(
                                icon: Icons.email_outlined,
                                hintText: 'Email',
                                isPassword: false,
                                isEmail: true,
                                controller: _emailController,
                              ),
                              Component1(
                                icon: Icons.lock_outline,
                                hintText: 'Password',
                                isPassword: true,
                                isEmail: false,
                                controller: _passwordController,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Component2(
                                    string: 'SIGN UP',
                                    width: 2.6,
                                    voidCallback: () {
                                      signUpUser();
                                      HapticFeedback.lightImpact();
                                    },
                                  ),
                                  SizedBox(
                                    width: w / 25,
                                  ),
                                  Container(
                                    width: w / 2.6,
                                    alignment: Alignment.center,
                                    child: RichText(
                                      text: const TextSpan(
                                        text: 'Forgotten password!',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(),
                              RichText(
                                text: TextSpan(
                                  text: 'Already have an account?',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const AnimatedLoginScreen(),
                                      ));
                                    },
                                ),
                              ),
                              const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
