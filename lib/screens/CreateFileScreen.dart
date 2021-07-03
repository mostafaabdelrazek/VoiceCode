import 'package:flutter/material.dart';
import 'package:voice_code/models/language.dart';
import 'package:voice_code/screens/FileTap.dart';
import 'package:voice_code/models/FileModel.dart';


class CreateFileScreen extends StatefulWidget {
  static String id = 'CreateFileScreen';
  final Language choosedLan;
  CreateFileScreen({@required this.choosedLan});
  @override
  _CreateFileScreenState createState() => _CreateFileScreenState();
}

class _CreateFileScreenState extends State<CreateFileScreen> {
  bool isCollapsed = false;
  Language selectedLanguage;
  String filename;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguage = new Language(
        widget.choosedLan.name,
        widget.choosedLan.imagepath,
        widget.choosedLan.extension,
        widget.choosedLan.welcomeMessage
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black12,),
      body: Material(
        color: const Color(0xff222223),
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'profile Image',
                    child: Container(
                      height: 180,
                      child: FittedBox(child: Icon(Icons.face , color: Color(0xffffffff),))
              ),
                  ),
                ),
                Row(

                  children: [
                    Flexible(
                      child: TextFormField(
                        validator: (value){
                          return value.isEmpty ? 'please name your File' : value.indexOf(' ') >= 0 ? 'file Name Ca\'n contain spaces' : null;
                        },
                           onChanged: (value){
                             filename = value;
                           },
                           decoration: InputDecoration(
                             hintText: 'Name your file here without .${selectedLanguage.extension}',
                           ),
                         ),
                    ),
                    Center(
                      child: Text('.${selectedLanguage.extension}' , style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize:22,
                      ),),
                    )
                  ],
                ),
                   SizedBox(
                     height: 20,
                   ),
                  ElevatedButton(
                     onPressed: () async{
                      if(_formKey.currentState.validate()){
                        String content = '';
                        FileModel newfile =  FileModel( filename , selectedLanguage.extension);
                        print(selectedLanguage.welcomeMessage);

                        await newfile.prepareFile(selectedLanguage.welcomeMessage);
                        content = await newfile.readCounter();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FileTap(
                          selectedLan: selectedLanguage,
                          filecontent: content,
                          newfile: newfile,
                        )));

                      }
                     },
                     child: Text('Create & Run ${selectedLanguage.name} Project'),
                   ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
