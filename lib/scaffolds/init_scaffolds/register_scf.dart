import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class RegisterScaffold extends StatefulWidget {
  @override
  _RegisterScaffoldState createState() => _RegisterScaffoldState();
}

class _RegisterScaffoldState extends State<RegisterScaffold> {

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();


  bool boolEmail,boolPass,boolName;

  @override void initState() {
    boolEmail = boolPass = boolName = true;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();

    super.dispose();
  }

  Future<bool> validatingData() async{ //TODO: complete that we

    String email = emailController.text;
    String password = passController.text;
    String name = nameController.text;

    bool boolEmail = checkEmail(email);
    bool boolPass = password.length > 6;
    //bool boolName = await checkName();

    return true;

  }

  bool checkEmail(String email){
    int arroba = 0;
    if(email[0] == '.' || email[email.length-1] == '.') return false;
    for(int i = 0; i< email.length;i++){
      if(email[i] == '@') arroba++;
    }

    if(arroba != 1) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: CurrentTheme.primaryGradientColor,
            ),
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/bukusymbol.png'),
                  width: 200.0,
                  height: 200.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Container(
                      //color: Colors.white,
                      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CurrentTheme.background,
                          boxShadow: [BoxShadow(
                              color: CurrentTheme.shadow1,
                              blurRadius: 20,
                              offset: Offset(0,0)
                          ),],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          )),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: emailController,
                            cursorColor: CurrentTheme.textColor1,
                            style: TextStyle(color: CurrentTheme.textColor1),
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                errorText: boolEmail ? null: 'Invalid email, please correct it', //TODO: change null
                                labelStyle: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: CurrentTheme.textFieldHint,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CurrentTheme.primaryColor))),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            controller: passController,
                            cursorColor: CurrentTheme.textColor1,
                            obscureText: true,
                            style: TextStyle(color: CurrentTheme.textColor1),
                            decoration: InputDecoration(
                                errorText: boolPass ? null : 'Password too weak, min 6 characters',
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: CurrentTheme.textFieldHint,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CurrentTheme.primaryColor))),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: nameController,
                            cursorColor: CurrentTheme.textColor1,
                            style: TextStyle(color: CurrentTheme.textColor1),
                            decoration: InputDecoration(
                                labelText: 'NICK NAME',
                                labelStyle: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: CurrentTheme.textFieldHint,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: CurrentTheme.primaryColor))),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          GradientButton(
                            text: 'REGISTER',
                            tap: (){
                              MainUser().register(emailController.text, passController.text, nameController.text, context);

                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CurrentTheme.textColor1,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Go Back',
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: CurrentTheme.textColor1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
