import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:voice_code/models/userDetail.dart';
import 'package:voice_code/services/auth.dart';
import 'package:voice_code/services/user_service.dart';
import 'package:voice_code/constants.dart';
import 'Home.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {

  static const String id = 'SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  UserService _userService = new UserService();

  final _formKey = new GlobalKey<FormState>();

  String _username = "";
  String _email = "";
  String _password = "";
  String error = '';
  bool loading = false;

  UserDetail getUserData(uId) {
    return new UserDetail(username: _username, userId: uId, email: _email);
  }

  @override
  Widget build(BuildContext context) {

    final double kwidth = ( MediaQuery.of(context).size.width);
    final double kheight = ( MediaQuery.of(context).size.height);
    return Scaffold(
      //backgroundColor: const Color(0xffffffff),
      //resizeToAvoidBottomInset: false,
      body:ModalProgressHUD(
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
                    padding: EdgeInsets.only(right: 20 , left: 20, top : 180),
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
                            children:[
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration:  BoxDecoration(
                                        color: Colors.black45,
                                        border: Border.all(color: Colors.white10 , width: 2),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25) , bottomLeft: Radius.circular(25)),
                                      ),
                                      child: MaterialButton(
                                        clipBehavior: Clip.antiAlias,
                                        onPressed: (){
                                          Navigator.pushNamed(context, SignIn.id);
                                        },
                                        child: Text(
                                            'SignIn',
                                            style:TextStyle(
                                                color: Colors.white60
                                            )

                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 150,
                                      height: 42,
                                      decoration:BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white70 , width: 2),
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(25) , topRight: Radius.circular(25)),
                                      ),
                                      child: MaterialButton(
                                        onPressed: (){
                                          //Navigator.pushNamed(context, SignUp.id);
                                        },
                                        child: Text(
                                            'Signup',
                                            style:TextStyle(
                                                color: Colors.white
                                            )

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 2.5),
                                child: TextFormField(
                                  validator: (value) => value.isEmpty || value == null ? 'please enter a valid username' : null,
                                  onChanged: (value){
                                    setState(() => _username = value);
                                  },
                                  decoration: kRoundedTextField.copyWith(hintText: 'Username' , prefixIcon: Icon(Icons.portrait)),

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 2.5),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) => EmailValidator.validate(value) ? null : 'Please Enter a Valid Email' ,
                                  onChanged: (value){
                                    setState(() => _email = value);
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
                                    setState(() =>_password = value);
                                  },
                                  decoration: kRoundedTextField.copyWith(hintText: 'Enter your Password' , prefixIcon: Icon(Icons.vpn_key)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 2.5),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (value) => value != _password ? 'Please enter Correct confirmation Password' : null,
                                  onChanged: (value){

                                  },
                                  decoration: kRoundedTextField.copyWith(hintText: 'Confirm your Password' , prefixIcon: Icon(Icons.https)),
                                ),
                              ),

                              SizedBox(
                                height: 40.0,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                                ),
                                onPressed: () async {
                                  setState(() => loading = true);
                                  if(_formKey.currentState.validate()) {
                                    _auth.registerWithEmailAndPassword(_email, _password).then((result) async => {
                                      if(result != null){
                                        await _userService.add(getUserData(result.uid)).then((userDetails) => {
                                          if(userDetails != null){
                                            setState(() {
                                              loading = false;
                                             Navigator.pushNamed(context, Home.id);
                                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome $_username')));
                                            })
                                          }
                                        })
                                  }else{
                                        setState((){
                                          loading = false;
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid information')));
                                        })
                                  }
                                    });

                                  } //Navigator.pushNamed(context, Home.id);
                                },
                                child: Container(
                                  width: 100,
                                  child: Center(
                                    child: Text('SignUp',
                                      style: TextStyle(color: Colors.white70 , fontSize: 20 , ),
                                    ),
                                  ),
                                ),

                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                ),

            ],
          ),
      ),
    );
  }
}

// const String _svg_1t698s =
//     '<svg viewBox="0.0 0.0 42.2 42.2" ><path transform="translate(0.0, -91.96)" d="M 9.890617370605469 113.0550994873047 C 9.890617370605469 110.9642944335938 10.4666633605957 109.0057220458984 11.46743011474609 107.3286819458008 L 11.46743011474609 100.2150115966797 L 4.353765487670898 100.2150115966797 C 1.530405163764954 103.8817977905273 -3.814697038251325e-06 108.3506317138672 -3.814697038251325e-06 113.0550994873047 C -3.814697038251325e-06 117.7595672607422 1.530405163764954 122.2283935546875 4.353765487670898 125.8951873779297 L 11.46743011474609 125.8951873779297 L 11.46743011474609 118.7815246582031 C 10.4666633605957 117.1044769287109 9.890617370605469 115.1458892822266 9.890617370605469 113.0550994873047 Z" fill="#fbbd00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-179.85, -342.22)" d="M 200.9452972412109 374.5302429199219 L 195.9999847412109 379.4755554199219 L 200.9452972412109 384.4208679199219 C 205.6498565673828 384.4208679199219 210.1185913085938 382.8904724121094 213.7853698730469 380.0670776367188 L 213.7853698730469 372.9609985351563 L 206.6793060302734 372.9609985351563 C 204.9875946044922 373.9653930664063 203.0207672119141 374.5302429199219 200.9452972412109 374.5302429199219 Z" fill="#0f9d58" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-48.47, -298.65)" d="M 59.93666076660156 325.4769592285156 L 52.822998046875 332.5906066894531 C 53.38198089599609 333.3165893554688 53.99066162109375 334.0118408203125 54.64929962158203 334.6705627441406 C 58.63455963134766 338.6557312011719 63.93321228027344 340.8505554199219 69.56922149658203 340.8505554199219 L 69.56922149658203 330.9599304199219 C 65.47911834716797 330.9599304199219 61.89434051513672 328.7575988769531 59.93666076660156 325.4769592285156 Z" fill="#31aa52" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-234.9, -181.06)" d="M 277.1000061035156 202.1601867675781 C 277.1000061035156 200.87646484375 276.9837646484375 199.5903625488281 276.7544860839844 198.3377075195313 L 276.5689697265625 197.3239898681641 L 255.9999847412109 197.3239898681641 L 255.9999847412109 207.2146148681641 L 266.0102844238281 207.2146148681641 C 265.0382080078125 209.1483306884766 263.5435791015625 210.7259521484375 261.7339172363281 211.8003997802734 L 268.8399963378906 218.906494140625 C 269.5659790039063 218.3475036621094 270.2611999511719 217.7388305664063 270.9198913574219 217.0801696777344 C 274.9051818847656 213.0948486328125 277.1000061035156 207.7961883544922 277.1000061035156 202.1601867675781 Z" fill="#3c79e6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-179.85, 0.0)" d="M 208.8715362548828 13.17372226715088 L 209.7457122802734 14.04788970947266 L 216.7394409179688 7.054230213165283 L 215.8652648925781 6.18006420135498 C 211.8800201416016 2.194803714752197 206.5813751220703 -7.62939453125e-06 200.9452819824219 -7.62939453125e-06 L 195.9999694824219 4.945302486419678 L 200.9452819824219 9.89061450958252 C 203.9393310546875 9.89061450958252 206.7542724609375 11.05655288696289 208.8715362548828 13.17372226715088 Z" fill="#cf2d48" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-48.47, 0.0)" d="M 69.56829833984375 9.890620231628418 L 69.56829833984375 0 C 63.93228912353516 0 58.63363647460938 2.194811105728149 54.64829254150391 6.179989814758301 C 53.98966217041016 6.838622093200684 53.38097381591797 7.53385066986084 52.82199096679688 8.259904861450195 L 59.93565368652344 15.37356853485107 C 61.89342498779297 12.09293174743652 65.47819519042969 9.890621185302734 69.56829833984375 9.890621185302734 Z" fill="#eb4132" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
// const String _svg_nq9ami =
//     '<svg viewBox="0.0 0.0 42.2 42.2" ><path transform="translate(0.0, 0.0)" d="M 39.87069702148438 -1.75302047864534e-05 L 2.327181577682495 -1.75302047864534e-05 C 1.041577935218811 0.00062639667885378 -0.0006152523565106094 1.043469548225403 -0.0002937604731414467 2.329386234283447 L -0.0002937604731414467 39.87289810180664 C 0.0003501664032228291 41.15849685668945 1.043193340301514 42.2006950378418 2.329110145568848 42.20037460327148 L 39.87073135375977 42.20037460327148 C 41.15697479248047 42.2006950378418 42.19981384277344 41.15818023681641 42.20013427734375 39.87193298339844 C 42.20013427734375 39.87161254882813 42.20013427734375 39.87129211425781 42.20013427734375 39.87096786499023 L 42.20013427734375 2.32745623588562 C 42.19948959350586 1.041852474212646 41.15665054321289 -0.0003405941242817789 39.87073135375977 -1.910229184431955e-05 Z M 39.87069702148438 -1.75302047864534e-05" fill="#4267b2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-189.94, -70.95)" d="M 219.0749053955078 113.1513442993164 L 219.0749053955078 96.83165740966797 L 224.5766143798828 96.83165740966797 L 225.4008331298828 90.44390869140625 L 219.0749053955078 90.44390869140625 L 219.0749053955078 86.37557220458984 C 219.0749053955078 84.53040313720703 219.587158203125 83.27313232421875 222.2330322265625 83.27313232421875 L 225.5862884521484 83.27313232421875 L 225.5862884521484 77.57534790039063 C 225.0028991699219 77.49775695800781 223.0012359619141 77.32421875 220.6721649169922 77.32421875 C 215.8092346191406 77.32421875 212.4810943603516 80.29143524169922 212.4810943603516 85.74294281005859 L 212.4810943603516 90.44393920898438 L 206.9999847412109 90.44393920898438 L 206.9999847412109 96.83169555664063 L 212.4810943603516 96.83169555664063 L 212.4810943603516 113.1513824462891 L 219.0749053955078 113.1513442993164 Z M 219.0749053955078 113.1513442993164" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
