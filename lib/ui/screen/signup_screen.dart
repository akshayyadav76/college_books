import 'package:college_books/data/provider/data_provider.dart';
import 'package:college_books/ui/widgets/button_widget.dart';
import 'package:college_books/ui/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool jobSekker = false;
  bool company = true;
  bool isLoading = false;
  bool passwordOcuredText = true;
  String text = "PERSONAL";
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstController.dispose();
    lastController.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    //final model = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: keyboardOpen ? 100 : size.height - 450,
                  color: Global.mediumBlue,
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 3.7 : -70.0,
                  child: WaveWidget(
                    size: size,
                    yOffset: size.height / 3.0,
                    color: Global.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
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
              ],
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Create An Account",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: ButtonWidget(
                                  title: "As a Job Seeker",
                                  hasBorder: jobSekker,
                                ),
                                onTap: () {
                                  setState(() {
                                    jobSekker = false;
                                    company = true;
                                    text = "PERSONAL";
                                  });
                                },
                              ),
                              GestureDetector(
                                child: ButtonWidget(
                                  title: "As a Company",
                                  hasBorder: company,
                                ),
                                onTap: () {
                                  setState(() {
                                    jobSekker = true;
                                    company = false;
                                    text = "COMPANY";
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "$text INFORMATION",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Text("s In",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Global.mediumBlue)),
                          SizedBox(height: 25),
                          TextFieldWidget(
                            controller: firstController,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Enter Your name";
                              }
                            },
                            hintText: 'First Name',
                            obscureText: false,
                            prefixIconData: Icons.mail_outline,
                            // suffixIconData: model.isValid ? Icons.check : null,
                            // onChanged: (value) {
                            //   model.isValidEmail(value);
                            // },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          company
                              ? TextFieldWidget(
                                  controller: lastController,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Enter your Last name";
                                    }
                                  },
                                  hintText: 'Last Name',
                                  obscureText: false,
                                  prefixIconData: Icons.mail_outline,
                                  // suffixIconData: model.isValid ? Icons.check : null,
                                  // onChanged: (value) {
                                  //   model.isValidEmail(value);
                                  // },
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFieldWidget(
                            controller: emailController,
                            validate: (String value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return "invalid email";
                              }
                              return null;
                            },
                            hintText: 'Email',
                            obscureText: false,
                            prefixIconData: Icons.mail_outline,
                            //suffixIconData: model.isValid ? Icons.check : null,
                            // onChanged: (value) {
                            //   model.isValidEmail(value);
                            // },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Consumer<HomeProvider>(
                                builder: (context, obj, child) =>
                                    TextFieldWidget(
                                  validate: (String value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return "invalid password or short";
                                    }
                                    return null;
                                  },
                                  //controller: passController,
                                  hintText: 'Password',
                                  obscureText: obj.isVisible ? false : true,
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
                                height: 10.0,
                              ),
                              // Text(
                              //   'Forgot password?',
                              //   style: TextStyle(
                              //     color: Global.mediumBlue,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            child: ButtonWidget(
                              title: 'Create',
                              hasBorder: false,
                            ),
                            onTap: () async {
                              var isValide = _formKey.currentState.validate();
                              if (isValide) {
                                setState(() {
                                  isLoading = true;
                                });
                                final msg = await context
                                    .read<DataProvider>()
                                    .resgisterUser(
                                        firstName: firstController.text,
                                        lastName: lastController.text,
                                        email: emailController.text,
                                        password: passController.text);

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
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            child: ButtonWidget(
                              title: 'LogIn',
                              hasBorder: true,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          ),
                          SizedBox(
                            height: 15,
                          )
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
      ]),
    );
  }
}
