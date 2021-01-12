
import 'package:college_books/ui/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../globals.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final loginContorller = TextEditingController();
  final passController = TextEditingController();
  bool passObscureText = true;
  bool isLoading = false;
  bool rememberMe = false;
  bool passwordOcuredText = true;

  @override
  void dispose() {
    loginContorller.dispose();
    passController.dispose();
    super.dispose();
  }
  // Widget buildLoading() => Stack(
  //       fit: StackFit.expand,
  //       children: [
  //         CustomPaint(painter: BackgroundPainter()),
  //         Center(child: CircularProgressIndicator()),
  //       ],
  //     );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: 
               Stack(
                children: [
                  Column(
                    children: [
                      Stack(children: <Widget>[
                        Container(
                          height: keyboardOpen ? 100 : size.height * 0.2,
                          color: Global.mediumBlue,
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                          top: keyboardOpen ? -size.height / 5.9 : 0.0,
                          child: WaveWidget(
                            size: size,
                            yOffset: size.height / 5.9,
                            color: Global.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Jobs Local',
                                style: TextStyle(
                                  color: Global.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Log In",
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Global.mediumBlue)),
                                    SizedBox(height: 25),
                                    TextFieldWidget(
                                      validate: (String value) {
                                        if (value.isEmpty ||
                                            !value.contains('@')) {
                                          return "invalid email";
                                        }
                                        return null;
                                      },
                                      controller: loginContorller,
                                      hintText: 'Email',
                                      obscureText: false,
                                      prefixIconData: Icons.mail_outline,
                                      // suffixIconData: model.isValid ? Icons.check : null,
                                      // onChanged: (value) {
                                      //   //  model.isValidEmail(value);
                                      //   print(value);
                                      // },
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Consumer<HomeProvider>(
                                          builder: (context, obj, child) =>
                                              TextFieldWidget(
                                            validate: (String value) {
                                              if (value.isEmpty ||
                                                  value.length < 5) {
                                                return "invalid password or short";
                                              }
                                              return null;
                                            },
                                            controller: passController,
                                            hintText: 'Password',
                                            obscureText: passwordOcuredText,
                                            //  obj.isVisible ? false : true,
                                            prefixIconData: Icons.lock_outline,
                                            suffixIconData: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  passwordOcuredText =
                                                      !passwordOcuredText;
                                                });
                                              },
                                              child: Icon(
                                                passwordOcuredText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                size: 18,
                                                color: Global.mediumBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        CheckboxListTile(
                                          dense: true,
                                          value: rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              rememberMe = value;
                                            });
                                          },
                                          title: Text("Remember me",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Global.mediumBlue)),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        ),
                                        GestureDetector(
                                          child: Text(
                                            'Forgot password?',
                                            style: TextStyle(
                                              color: Global.mediumBlue,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgetPassScreen()));
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    ButtonWidget(
                                      title: 'Login',
                                      hasBorder: false,
                                      onTap: () async {
                                        var check =
                                            _formKey.currentState.validate();
                                        if (check) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          var email = loginContorller.text;
                                          var password = passController.text;
                                          print("data $email");
                                          var msg = await context
                                              .read<DataProvider>()
                                              .login(
                                                  email: email,
                                                  password: password,
                                                  rememberMe: rememberMe);

                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (msg.contains("Login")) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Master()));
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            var alertDilag = AlertDialog(
                                              content: Text(msg),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("OK"))
                                              ],
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (_) => alertDilag);
                                          }
                                        }
                                      },
                                    ),
                                   
                                   
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                   
                                    
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    GestureDetector(
                                      child: ButtonWidget(
                                        title: 'Sign Up',
                                        hasBorder: true,
                                      ),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  isLoading
                      ? Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.grey.withOpacity(0.5),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ))
                      : SizedBox.shrink()
                ],),
              
            
          );
    
  }
}
