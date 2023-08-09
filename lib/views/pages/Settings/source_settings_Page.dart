import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/controllers/media_controller.dart';
import 'package:amplifying_mediaplayer/models/Source_model.dart';
import 'package:amplifying_mediaplayer/views/widgets/amplifying_source_List.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_action_button.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_dropdown.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_textfield.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SourceSettingsPage extends StatelessWidget {
  const SourceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    late TextEditingController _controller = TextEditingController();

    late MediaSource source;
    late String _name = "Default Collection";
    late MediaGroups _mediaGroups = MediaGroups.album;
    late MediaLabels _primaryLabel = MediaLabels.songCount;
    late MediaLabels _secondaryLabel = MediaLabels.totalTime;

    String multipleArtworks = "False";

    return AmplifyingScaffold(
      useNavBar: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: ListView(
          children: [
            AmplifyingTextField(
                leadingText: "Collection Name",
                description: "This is the main name for this collection",
                controller: _controller,
                onChanged: (value) =>
                    {Text("$value"), _name = value}),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AmplifyingActionButton(
                    text: "Reload source",
                    onPress: () {
                    },
                    backgroundColor: context
                        .read<ColorProvider>()
                        .amplifyingColor
                        .accentDarkerColor),
              ],
            ),
            AmplifyingDropdown(
                leadingText: "Combine Media By",
                items: MediaGroups.values.map((e) => e.name).toList(),
                description: "This is a test widget",
                onChanged: (e) {
                  _mediaGroups = MediaGroups.values.byName(e!);
                }),
            AmplifyingSourceList(),
            AmplifyingDropdown(
                leadingText: "Primary Label",
                items: MediaLabels.values.map((e) => e.name).toList(),
                description: "This is a test widget",
                defaultSelected: _primaryLabel.name,
                onChanged: (e) {
                  _primaryLabel = MediaLabels.values.byName(e!);
                }),
            AmplifyingDropdown(
                leadingText: "Secondary Label",
                items: MediaLabels.values.map((e) => e.name).toList(),
                defaultSelected: _secondaryLabel.name,
                description: "This is a test widget",
                onChanged: (e) {
                  _secondaryLabel = MediaLabels.values.byName(e!);
                }),
            AmplifyingDropdown(
                leadingText: "Display Multiple Artworks",
                items: ["True", "False"],
                description: "This is a test widget",
                defaultSelected: "True",
                onChanged: (e) {
                  multipleArtworks = e as String;
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AmplifyingActionButton(
                      text: "Save",
                      onPress: () {
                        source = MediaSource(
                            sourceName: _name,
                            mediaGroup: _mediaGroups,
                            primaryLabel: _primaryLabel,
                            secondaryLabel: _secondaryLabel);
                        source.generateID();
                        context.read<MediaProvider>().sources.add(source);
                        context.read<MediaProvider>().SaveSources();
                        Navigator.pop(context);
                      },
                      backgroundColor: context
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
