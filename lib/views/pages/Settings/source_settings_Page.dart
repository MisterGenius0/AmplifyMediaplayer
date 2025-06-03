import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/source_settings_controller.dart';
import 'package:amplify/models/source_model.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';
import 'package:amplify/views/widgets/other/amplifying_source_List.dart';
import 'package:amplify/views/widgets/common/amplifying_dropdown.dart';
import 'package:amplify/views/widgets/common/amplifying_textfield.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';

class SourceSettingsPage extends StatefulWidget {
  const SourceSettingsPage({super.key});

  @override
  State<SourceSettingsPage> createState() => _SourceSettingsPageState();
}

class _SourceSettingsPageState extends State<SourceSettingsPage> {

  @override
  Widget build(BuildContext context) {
    late TextEditingController controller = TextEditingController();

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    late MediaSource? source = arguments['mediaSource'];

    late String name = source?.sourceName ?? "Default Souce";
    late MediaGroups mediaGroups = source == null ? MediaGroups.album : source.mediaGroup;
    late MediaGroupLabels primaryLabel = source == null ? MediaGroupLabels.songCount : source.primaryLabel;
    late MediaGroupLabels secondaryLabel = source == null ?MediaGroupLabels.totalTime : source.secondaryLabel;
    late List<String> sourceDirectory = source == null ? [] : source.sourceDirectorys;

    // ignore: unused_local_variable
    String multipleArtworks = "False";
    SourceSettingsController saveSourceController = SourceSettingsController();

    return AmplifyingScaffold(
      useNavBar: false,
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                AmplifyingTextField(
                    leadingText: "Source Name",
                    description: "This is the main name for this Source",
                    controller: controller,
                    initalText: source?.sourceName ?? "",
                    onChanged: (value) =>
                        {Text(value), name = value}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    source != null ? AmplifyingMenuItem(
                        text: "Reload source",
                        icon: Icons.restart_alt_outlined,
                        onPressed: () {
                          saveSourceController.onReloadSource(source, context);
                        },
                      //TODO Add a background color to menu items
                      // TODO Also add the items can exspand horizontrally and center themselves
                        // backgroundColor: context
                        //     .read<ColorProvider>()
                        //     .amplifyingColor
                        //     .accentDarkerColor),
                    ) : Container(),
                  ],
                ),

                AmplifyingDropdown(
                    leadingText: "Combine Media By",
                    items: MediaGroups.values.map((e) => e.name).toList(),
                    description: "This is a test widget",
                    defaultSelected: source?.mediaGroup.name ?? mediaGroups.name,
                    onChanged: (e) {
                      mediaGroups = MediaGroups.values.byName(e!);
                    }),
                AmplifyingSourceList(initalList: sourceDirectory,),
                AmplifyingDropdown(
                    leadingText: "Primary Label",
                    items: MediaGroupLabels.values.map((e) => e.name).toList(),
                    description: "This is a test widget",
                    defaultSelected: source?.primaryLabel.name ?? primaryLabel.name,
                    onChanged: (e) {
                      primaryLabel = MediaGroupLabels.values.byName(e!);
                    }),
                AmplifyingDropdown(
                    leadingText: "Secondary Label",
                    items: MediaGroupLabels.values.map((e) => e.name).toList(),
                    defaultSelected: source?.secondaryLabel.name ?? secondaryLabel.name,
                    description: "This is a test widget",
                    onChanged: (e) {
                      secondaryLabel = MediaGroupLabels.values.byName(e!);
                    }),
                AmplifyingDropdown(
                    leadingText: "Display Multiple Artworks",
                    items: const ["True", "False"],
                    description: "This is a test widget",
                    defaultSelected: "True",
                    onChanged: (e) {
                      multipleArtworks = e as String;
                    }),

                const SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    source != null ? AmplifyingMenuItem(
                      text: "Delete Source",
                      icon: Icons.delete,
                      onPressed: () {
                        saveSourceController.onDeleteSource(source, context);
                      },
                      //TODO Add a background color to menu items
                      // TODO Also add the items can exspand horizontrally and center themselves
                      // backgroundColor: context
                      //     .read<ColorProvider>()
                      //     .amplifyingColor
                      //     .accentDarkerColor),
                    ) : Container(),
                  ],
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
          Container(
            color: context.watch<ColorProvider>().amplifyingColor.darkestColor,
            child: AmplifyingMenuItem(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                text: "Save",
                icon: Icons.save,
                onPressed: () {
                  saveSourceController.onSaveSource(context: context,
                    existingSource: source,
                    name: name,
                    mediaGroups: mediaGroups,
                    primaryLabel: primaryLabel,
                    secondaryLabel: secondaryLabel,
                    sourceDirectorys: sourceDirectory,
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
