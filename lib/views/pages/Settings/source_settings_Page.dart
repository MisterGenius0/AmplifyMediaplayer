import 'package:amplifying_mediaplayer/views/widgets/amplifying_textfield.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SourceSettingsPage extends StatelessWidget {
  const SourceSettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    late TextEditingController _controller = TextEditingController();

    return AmplifyingScaffold(
      useNavBar: false,
      body: ListView(
        children:  [
          Center(child: AmplifyingTextField(leadingText: "Collection Name", controller: _controller, OnSubmit: (value)=>{Text("$value")})),
          AmplifyingTextField(leadingText: "Collection Type", controller: _controller, OnSubmit: (value)=>{Text("$value")}),
          AmplifyingTextField(leadingText: "Collection Year", controller: _controller, OnSubmit: (value)=>{Text("$value")}),
          AmplifyingTextField(leadingText: "Collection Symbol", controller: _controller, OnSubmit: (value)=>{Text("$value")}),
          AmplifyingTextField(leadingText: "Collection Thing", controller: _controller, OnSubmit: (value)=>{Text("$value")}),
          AmplifyingTextField(leadingText: "Collection Name", controller: _controller, OnSubmit: (value)=>{Text("$value")}),
          TextField(
            controller: _controller,
            onSubmitted: (value){
              showDialog(context: context, builder: (BuildContext context){
                return Text("You submitted: $value", style: TextStyle(color: Colors.white, fontSize: 25, decoration: TextDecoration.none),);
              });
            },
          )

        ],
      ),
    );
  }
}
