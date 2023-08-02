import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingSettingLabel extends StatefulWidget {
  const AmplifyingSettingLabel({super.key, required this.child, this.leadingText, this.description, });

  final String? leadingText;
  final String? description;
  final Widget child;

  @override
  State<AmplifyingSettingLabel> createState() => _AmplifyingSettingLabelState();
}

class _AmplifyingSettingLabelState extends State<AmplifyingSettingLabel> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange()
  {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      focusNode: _focusNode,
      descendantsAreTraversable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.leadingText != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Text("${widget.leadingText}: ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      color: _focusNode.hasFocus ?
                      context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .whiteColor :
                      context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .accentLighterColor,
                    )),
              )
              : Container(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
      color: _focusNode.hasFocus? context
          .read<ColorProvider>()
          .amplifyingColor
          .whiteColor :
      context
          .read<ColorProvider>()
          .amplifyingColor
          .backgroundDarkColor,
      borderRadius: BorderRadius.circular(2)
      ),
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: context
                        .read<ColorProvider>()
                        .amplifyingColor
                        .backgroundDarkColor,
                    borderRadius: BorderRadius.circular(2)
                ),
                child: widget.child,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child:  widget.description != null
                ? Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Text("${widget.description}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    color: context
                        .read<ColorProvider>()
                        .amplifyingColor
                        .accentColor,
                  )),
            )
                : Container(),)
          //Edge padding to center the text field
        ],
      ),
    );
  }
}

class OnSubmit {}
