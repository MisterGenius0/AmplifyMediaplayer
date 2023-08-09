import 'package:amplifying_mediaplayer/controllers/media_controller.dart';
import 'package:amplifying_mediaplayer/models/Source_model.dart';
import 'package:amplifying_mediaplayer/views/widgets/amplifying_source_List.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';

import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_action_button.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_dropdown.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_textfield.dart';

class SourceSettingsPage extends StatelessWidget {
  const SourceSettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    late TextEditingController _controller = TextEditingController();

    MediaSource source = MediaSource(sourceName: "Test", mediaGroup: MediaGroups.album, primaryLabel: MediaLabels.albumArtestCount, secondaryLabel: MediaLabels.albumArtestCount);

    source.generateID();

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
            AmplifyingDropdown(leadingText: "Combine Media By",items: MediaGroups.values.map((e) => e.name).toList(), description: "This is a test widget",),
            AmplifyingSourceList(),
            AmplifyingDropdown(leadingText: "Primary Label",items: MediaLabels.values.map((e) => e.name).toList(), description: "This is a test widget",),
            AmplifyingDropdown(leadingText: "Secondary Label",items: MediaLabels.values.map((e) => e.name).toList(), description: "This is a test widget",),
            AmplifyingDropdown(leadingText: "Display Multiple Artworks",items: ["True", "False"], description: "This is a test widget", defaultSelected: "True",),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AmplifyingActionButton( text: "Save", onPress: (){ context.read<MediaProvider>().sources.add(source); context.read<MediaProvider>().SaveSources();}, backgroundColor: context
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
