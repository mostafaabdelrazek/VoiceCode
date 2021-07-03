import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_code/constants.dart';
import 'package:voice_code/services/auth.dart';
import 'Home.dart';
import 'SignUp.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class SignIn extends StatefulWidget {

  static const  String id = 'SignIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // Future createAppFolder() async{
  //   final dir = await   ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOCUMENTS);
  //   print(dir);
  //  // return  Directory(path).create();
  // }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //createAppFolder();
  }


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //double height =;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final double kwidth = ( MediaQuery.of(context).size.width);
    final double kheight = ( MediaQuery.of(context).size.height);
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff222223),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 0),
                  child: Container(
                    width: ( kwidth ) * 0.65 ,
                    height: ( kheight ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xcc292929),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x21000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(( kwidth * 0.35), 0.0),
                  child: Container(
                    width: ( kwidth * 0.65),
                    height: ( kheight),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xcc292929),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x21000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(100,100),
                  child: Image.asset(
                    'assets/GP LOGO111.png',
                    width: 170.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 180 , left: 20 , right: 20),
                    child: Container(
                      height: kheight - 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.0),
                        color: const Color(0xff212121),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                          child: Column(
                        children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                 Container(
                                   width: 150,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.white70 , width: 2),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25) , bottomLeft: Radius.circular(25)),
                                  ),
                                  child: MaterialButton(
                                    clipBehavior: Clip.antiAlias,
                                    onPressed: (){},
                                    child: Text(
                                        'SignIn',
                                      style:TextStyle(
                                        color: Colors.white
                                      )

                                  ),
                                ),
                              ),

                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  border: Border.all(color: Colors.white10 , width: 2),
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(25) , bottomRight: Radius.circular(25)),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                   Navigator.pushNamed(context, SignUp.id);
                                  },
                                  child: Text(
                                      'Signup',
                                      style:TextStyle(
                                          color: Colors.white60
                                      )

                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                          SizedBox(
                            height: 35.0,
                          ),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 2.5),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => EmailValidator.validate(value) ? null : 'Please Enter a Valid Email',
                              onChanged: (value){
                                setState(() => email = value);
                              },
                              decoration: kRoundedTextField.copyWith(hintText: 'Enter your Email' , prefixIcon: Icon(Icons.email)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 2.5),
                            child: TextFormField(
                             obscureText: true,
                              validator: (value) => value.isEmpty || value == null ? 'please enter your password' : null,
                              onChanged: (value){
                               setState(() => password = value);
                              },
                              decoration: kRoundedTextField.copyWith(hintText: 'Enter your Password' , prefixIcon:  Icon(Icons.vpn_key)),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Forget your password ?' , style: TextStyle(color: Colors.white)),
                                Text('Remember Me!' ,style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),


                           ElevatedButton(
                             style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  if (result != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome ')));
                                    Navigator.pushNamed(context, Home.id);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email or Password')));
                                  }
                                  //print('hello');
                                  setState(() => loading = false);
                                }
                              },

                              child: Container(
                                width: 100,
                                child: Center(
                                  child: Text('Login',
                                  style: TextStyle(color: Colors.purple , fontSize: 20 , ),
                                  ),
                                ),
                              ),

                            ),

                        ],
                      ),
                    ),
                    ),
    ),
                ),

                //paste here
              ],
            ),
        ),
        );
  }
}
