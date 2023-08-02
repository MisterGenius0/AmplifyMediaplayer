import 'package:amplifying_mediaplayer/views/widgets/main%20UI/common/amplifying_action_button.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/common/amplifying_dropdown.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/common/amplifying_textfield.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';

class SourceSettingsPage extends StatelessWidget {
  const SourceSettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    late TextEditingController _controller = TextEditingController();

    return AmplifyingScaffold(
      useNavBar: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: ListView(
          children:  [
            AmplifyingTextField(leadingText: "Collection Name", description: "This is the main name for this collection", controller: _controller, onSubmit: (value)=>{Text("$value")}),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AmplifyingActionButton(text: "Reload source", onPress: (){print("Test");}, backgroundColor: context
                    .read<ColorProvider>()
                    .amplifyingColor
                    .accentDarkerColor),
              ],
            ),
            AmplifyingDropdown(leadingText: "Combine Media By",items: ["Artust", "Album", "Year", "Composer", "Genre"], description: "This is a test widget",),
            AmplifyingDropdown(leadingText: "Primary Label",items: ["Sort type", "Artist count", "Disc count", "Album count", "Genre Count", "Composer count", "Track count", "Total time length"], description: "This is a test widget",),
            AmplifyingDropdown(leadingText: "Secondary Label",items: ["Sort type", "Artist count", "Disc count", "Album count", "Genre Count", "Composer count", "Track count", "Total time length"], description: "This is a test widget",),
            AmplifyingDropdown(leadingText: "Display Multiple Artworks",items: ["True", "False"], description: "This is a test widget", defaultSelected: "True",),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AmplifyingActionButton(text: "Save", onPress: (){print("Test");}, backgroundColor: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .accentDarkerColor),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
