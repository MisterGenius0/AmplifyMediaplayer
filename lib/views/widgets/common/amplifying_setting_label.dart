import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/amplifying_color_provider.dart';

class AmplifyingSettingLabel extends StatefulWidget {
  const AmplifyingSettingLabel({
    super.key,
    required this.child,
    this.leadingText,
    this.description,
    this.haveBackground = true,
    this.LeadingTextSuffixWidgets = const [],
    this.leadingTextSuffix = ": "}
      );

  final String? leadingText;
  final String leadingTextSuffix;
  final List<Widget> LeadingTextSuffixWidgets;
  final String? description;
  final Widget child;
  final bool haveBackground;

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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${widget.leadingText}${widget.leadingTextSuffix}",
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
                        )
                    ),
                    Row(
                      children: widget.LeadingTextSuffixWidgets.toList(),
                    )
                  ],
                ),
              )
              : Container(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
      color: widget.haveBackground ?  _focusNode.hasFocus? context
          .read<ColorProvider>()
          .amplifyingColor
          .whiteColor :
      context
          .read<ColorProvider>()
          .amplifyingColor
          .backgroundDarkColor : Colors.transparent,
      borderRadius: BorderRadius.circular(2)
      ),
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: widget.haveBackground ?  context
                        .read<ColorProvider>()
                        .amplifyingColor
                        .backgroundDarkColor : Colors.transparent,
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
