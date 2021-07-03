import 'package:flutter/material.dart';
import 'package:voice_code/models/FileModel.dart';
import 'package:voice_code/models/language.dart';
import 'dart:convert';
import 'package:voice_code/models/GlotApi.dart';


class FileTap extends StatefulWidget {
  static const id = 'FileTap';
  String filecontent;
  final Language selectedLan;
  final FileModel newfile;
  FileTap({this.filecontent,@required this.selectedLan , @required this.newfile});
  @override
  _FileTapState createState() => _FileTapState();
}



class _FileTapState extends State<FileTap> {
  bool isCollapsed = false;
  String textFieldValue = '';
  String _response = 'Run to show Result';
  String _error = '';
  String content = '';
  GlotApi api ;
  FileModel newfile;
  Language selectedLan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFieldValue = widget.selectedLan.welcomeMessage;
    api = new GlotApi(widget.selectedLan.name.toLowerCase());
    selectedLan = new Language(widget.selectedLan.name, widget.selectedLan.imagepath , widget.selectedLan.extension,widget.selectedLan.welcomeMessage);
    newfile = new FileModel(widget.newfile.fileName,widget.newfile.fileExtension);
    content = widget.filecontent.toString();
  }


  @override
  Widget build(BuildContext context) {
    final double kwidth = ( MediaQuery.of(context).size.width);
    final double kheight = ( MediaQuery.of(context).size.height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.black12,),
      body: Material(
        color: const Color(0xff222223),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15 , top: 22 , bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      //Text('lan:${selectedLan.name}  , extention: ${selectedLan.extension}  , imagepath: ${selectedLan.imagepath}'),
                    Container(
                    color: Colors.white70,
                       padding: EdgeInsets.symmetric(horizontal: 6 , vertical: 3),
                        child: Text('${newfile.fileName}.${newfile.fileExtension}' , style: TextStyle(color: Colors.black))
                    ),
                    TextFormField(
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      initialValue: '$content',
                      onChanged: (value){
                        setState(() { textFieldValue = value;} );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                                backgroundColor: Colors.blueAccent,
                                child: Icon(Icons.save),
                                foregroundColor: Colors.white,
                                onPressed: () {
                                  newfile.writeCounter(textFieldValue);
                                }
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FloatingActionButton.extended(
                                backgroundColor: Colors.green,
                                icon: Icon(Icons.not_started_outlined),
                                label: Text('Run'),
                                foregroundColor: Colors.white,
                                onPressed: ()  {
                                  newfile.writeCounter(textFieldValue);
                                  print(selectedLan.name);
                                  api.filedata('${newfile.fileName}.${newfile.fileExtension}', textFieldValue);
                                  setState(() {
                                    api.getResponse().then((value) => {
                                      setState((){
                                        print(value);
                                        _response = jsonDecode(value)['stdout'];
                                        _error = jsonDecode(value)['stderr'] + " " + jsonDecode(value)['error'];
                                      })
                                    });
                                  });
                                  //print(_response);
                                }
                                ),

                          ],
                        ),
                      ),
                    ),
                    Text(_response == '' || _response == null ? 'Loading' : _response),
                    Text(_error == '' || _error == null ? '' : _error ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                right: 0,
                left: 0,
                top: isCollapsed? - 0.4*kheight : kheight,
                bottom: isCollapsed? - 0.4*kheight: kheight,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                  child: Transform.translate(
                    offset: Offset( 0 ,0),
                    child: Container(
                      width: kwidth,
                      height: kheight,
                      decoration: BoxDecoration(
                        color: const Color(0xcc292929),
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
