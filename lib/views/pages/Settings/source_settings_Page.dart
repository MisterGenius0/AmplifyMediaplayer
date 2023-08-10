import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:amplifying_mediaplayer/controllers/providers/media_provider.dart';
import 'package:amplifying_mediaplayer/controllers/save_source.dart';
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

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    late MediaSource? source = arguments['mediaSource'];

    late String _name = source?.sourceName ?? "Default Collection";
    late MediaGroups _mediaGroups = source == null ? MediaGroups.album : source.mediaGroup;
    late MediaLabels _primaryLabel = source == null ? MediaLabels.songCount : source.primaryLabel;
    late MediaLabels _secondaryLabel = source == null ?MediaLabels.totalTime : source.secondaryLabel;

    String multipleArtworks = "False";
print(source);
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
                initalText: source?.sourceName ?? "",
                onChanged: (value) =>
                    {Text(value), _name = value}),
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
                defaultSelected: source?.mediaGroup.name ?? _mediaGroups.name,
                onChanged: (e) {
                  _mediaGroups = MediaGroups.values.byName(e!);
                }),
            AmplifyingSourceList(),
            AmplifyingDropdown(
                leadingText: "Primary Label",
                items: MediaLabels.values.map((e) => e.name).toList(),
                description: "This is a test widget",
                defaultSelected: source?.primaryLabel.name ?? _primaryLabel.name,
                onChanged: (e) {
                  _primaryLabel = MediaLabels.values.byName(e!);
                }),
            AmplifyingDropdown(
                leadingText: "Secondary Label",
                items: MediaLabels.values.map((e) => e.name).toList(),
                defaultSelected: source?.secondaryLabel.name ?? _secondaryLabel.name,
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
                        saveSourceController(context: context,
                            existingSource: source,
                          name: _name,
                            mediaGroups: _mediaGroups,
                            primaryLabel: _primaryLabel,
                          secondaryLabel: _secondaryLabel,);
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
