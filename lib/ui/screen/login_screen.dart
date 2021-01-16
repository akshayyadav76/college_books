
import 'package:college_books/constant/globals.dart';
import 'package:college_books/data/provider/auth.dart';
import 'package:college_books/ui/widgets/button_widget.dart';
import 'package:college_books/ui/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import 'MyApp.dart';
import 'forgot_pass_screen.dart';
import 'signup_screen.dart';
import '../theme/extention.dart';

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
    bool jobSekker = false;
  bool company = true;

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
      body: Stack(
                children: [
                  Column(
                    children: [
                      Stack(children: <Widget>[
                        Container(
                          height: keyboardOpen ? size.height *0.1 : size.height * 0.2,
                         
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(200),
                          bottomLeft: Radius.circular(200), ),
                          ),
                        ),
                        // AnimatedPositioned(
                        //   duration: Duration(milliseconds: 500),
                        //   curve: Curves.linear,
                        //   top: keyboardOpen ? -size.height / 5.9 : 0.0,
                        //   child: WaveWidget(
                        //     size: size,
                        //     yOffset: size.height / 5.9,
                        //     color: Global.white,
                        //   ),
                        // ),
                        Padding(
                          padding: keyboardOpen?EdgeInsets.only(top: 15): EdgeInsets.only(top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'College Books',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 40.0.sp,
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
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 15.0.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10.h,),
                                    Text("Log In",
                                        style: TextStyle(
                                            fontSize: 30.0.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).accentColor)),
                                    SizedBox(height: 10.h),
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
                                      height: 5.0.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Consumer<Auth>(
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
                                                size: 12.h,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Theme(
                                          data: ThemeData(unselectedWidgetColor: Theme.of(context).accentColor),
                                          child: CheckboxListTile( 
                                            activeColor: Theme.of(context).accentColor,
                                            dense: true,
                                            value: rememberMe,
                                            checkColor: Theme.of(context).primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                rememberMe = value;
                                              });
                                            },
                                            title: Text("Remember me",
                                                style: TextStyle(
                                                    fontSize: 19.0.sp,
                                                    color: Theme.of(context).accentColor)),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Text(
                                            'Forgot password?',
                                            style: TextStyle(
                                              color: Theme.of(context).accentColor,
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
                                      height: 15.0.h,
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
                                              .read<Auth>()
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
                                                        MyApp()));
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
                                                    MyApp()));
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
