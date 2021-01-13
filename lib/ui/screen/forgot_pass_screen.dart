import 'package:college_books/constant/globals.dart';
import 'package:college_books/data/provider/auth.dart';
import 'package:college_books/ui/widgets/button_widget.dart';
import 'package:college_books/ui/widgets/textfield_widget.dart';
import 'package:college_books/ui/widgets/wave_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'signup_screen.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final resetEmailContorller = TextEditingController();
  //final passController = TextEditingController();
  // bool passObscureText = true;
  bool isLoading = false;
  //bool rememberMe = false;

  @override
  void dispose() {
    resetEmailContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(children: <Widget>[
                Container(
                  height: keyboardOpen ? 100 : size.height * 0.3,
                  color: Global.mediumBlue,
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 5.2 : 0.0,
                  child: WaveWidget(
                    size: size,
                    yOffset: size.height / 4.5,
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
              ]),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("FORGET PASSWORD ?",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Global.mediumBlue)),
                                    SizedBox(height: 10),
                            Text(
                                "We will send you an email to reset your password.",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                    color: Global.mediumBlue)),
                            SizedBox(height: 25),
                            TextFieldWidget(
                              validate: (String value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return "invalid email";
                                }
                                return null;
                              },
                              controller: resetEmailContorller,
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
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: <Widget>[
                            //     Consumer<HomeProvider>(
                            //       builder: (context, obj, child) =>
                            //           TextFieldWidget(
                            //               validate: (String value) {
                            //                 if (value.isEmpty ||
                            //                     value.length < 5) {
                            //                   return "invalid password or short";
                            //                 }
                            //                 return null;
                            //               },
                            //               controller: passController,
                            //               hintText: 'Password',
                            //               obscureText:
                            //                   obj.isVisible ? false : true,
                            //               prefixIconData: Icons.lock_outline,
                            //               suffixIconData: obj.isVisible
                            //                   ? Icons.visibility
                            //                   : Icons.visibility_off),
                            //     ),
                            //     SizedBox(
                            //       height: 5.0,
                            //     ),
                            //     CheckboxListTile(
                            //       value: rememberMe,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           rememberMe = value;
                            //         });
                            //       },
                            //       title: Text("Remember me",
                            //           style: TextStyle(
                            //               fontSize: 15.0,
                            //               color: Global.mediumBlue)),
                            //       controlAffinity:
                            //           ListTileControlAffinity.leading,
                            //     ),
                            //     Text(
                            //       'Forgot password?',
                            //       style: TextStyle(
                            //         color: Global.mediumBlue,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20.0,
                            ),
                            ButtonWidget(
                              title: 'Submit',
                              hasBorder: false,
                              onTap: () async {
                                var check = _formKey.currentState.validate();
                                if (check) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var email = resetEmailContorller.text;
                          
                               final msg= await context.read<Auth>().resetPass(
                                          email:email,);
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
                                title: 'Back',
                                hasBorder: true,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
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
        ],
      ),
    );
  }
}
