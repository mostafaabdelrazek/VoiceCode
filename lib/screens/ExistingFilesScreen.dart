import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_code/models/language.dart';
import 'package:voice_code/models/FileModel.dart';
import 'package:voice_code/screens/CreateFileScreen.dart';

class ExistingFilesScreen extends StatefulWidget {
  static const String id = 'ExistingFilesScreen';
  final Language choosedLan;
  final dynamic files;
  ExistingFilesScreen({this.choosedLan , this.files});
  @override
  _ExistingFilesScreenState createState() => _ExistingFilesScreenState();
}

  dynamic files;
class _ExistingFilesScreenState extends State<ExistingFilesScreen> {
  Language selectedLan ;
  @override
  void initState(){
    super.initState();
    selectedLan = new Language(widget.choosedLan.name, widget.choosedLan.imagepath, widget.choosedLan.extension, widget.choosedLan.welcomeMessage);
    files = widget.files;
    print(files);
    print(widget.choosedLan.extension);
    // FileModel.getAllFiles(widget.choosedLan.extension.toString()).then(
    //     (val) => {
    //       files = val
    //     }
    // );
    print(files.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedLan.name),),
      body: Material(
        child: Stack(
          children: [
            files.length == 0 ? Text('you have no ${selectedLan.name} project yet') : DynamicList(),
            Padding(
              padding: EdgeInsets.only(right: 10,bottom: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute( builder:  (context) => CreateFileScreen(
                          choosedLan: selectedLan,
                        ))
                    );                  },
                  child: Text('Create A new File.${selectedLan.extension}'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DynamicList extends StatelessWidget{
  @override
  Widget build(context){
    final f = files;
    return ListView.builder(
      itemCount: f.length,
      itemBuilder: (context , index){
        return ListTile(
          title: new Text(f[index].toString()),
        );
      },
    );
  }
}


