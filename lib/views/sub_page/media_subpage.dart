  import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:amplify/views/Test/color_Test.dart';
import 'package:amplify/views/Test/color_Test2.dart';
import 'package:amplify/views/widgets/item%20grid/grid_Seperator.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../widgets/item grid/base_Item_Grid.dart';
import '../widgets/item grid/media_grid_item.dart';

class MediaSubpage extends StatefulWidget {
  const MediaSubpage({super.key});

  @override
  State<MediaSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<MediaSubpage> {
  late MediaDBModel mediaDBModel;
  late Future<List<Media>> medias;
  late MediaGroup mediaGroup;
  List<Future<List<ImageProvider>>> images = [];
  ColorScheme sceme  = ColorScheme.dark();

  List<String> things = ["Thing1", "Thing2", "Thing4"];
  int Thingcount = 0;

  void getPictures() async
  {
    images = [];
    for (var media in await medias)
    {
      images.add(mediaDBModel.getMediaImages(media));
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    mediaGroup = arguments['mediaGroups'];
    mediaDBModel = MediaDBModel();

    medias =  mediaDBModel.getMediaFromGroup(mediaGroup);
    getPictures();
  }
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    BaseItemGrid baseItemGrid = BaseItemGrid();

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: medias,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Media>> snapshot) {
                if (snapshot.data != null) {
                  return Flexible(
                    flex: 15,
                    child: ListView(
                    children: [
                      GridSeparator(icon: Icons.album),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount:
                      baseItemGrid.crossAxisGridCount(context),
                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                      children: [
                        for (final (index, media) in snapshot.data!.indexed)

                          if(images.isNotEmpty)
                            FutureBuilder(
                              future: images[index],
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ImageProvider>> snapshot) {
                                if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                {
                                  return MediaGridItem(name:  "${media.trackNumber != null ? "${media.trackNumber} - " : ""} ${ media.mediaName ?? ""}", mainOnPress: (){
                                    player.play(DeviceFileSource(media.mediaPath.path));
                                    PaletteGenerator.fromImageProvider(snapshot.data![0]).then((value){
                                      context.read<ColorProvider>().updateWithPalette(value);
                                    });
                                    }, contextMenuOnPress: (){}, images: snapshot.data, subtext: "",);
                                }
                                else
                                {
                                  return MediaGridItem(name: media.mediaName ?? " ", mainOnPress: (){
                                    player.play(DeviceFileSource(media.mediaPath.path));}, contextMenuOnPress: (){}, subtext: "Test");
                                }
                              },
                )],
                            ),
                      GridSeparator(icon:  Icons.person,),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount:
                        baseItemGrid.crossAxisGridCount(context),
                        crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                        mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                        children: [
                          for (final (index, media) in snapshot.data!.indexed)

                            if(images.isNotEmpty)
                              FutureBuilder(
                                future: images[index],
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<ImageProvider>> snapshot) {
                                  if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                  {
                                    return MediaGridItem(name:  "${media.trackNumber != null ? "${media.trackNumber} - " : ""} ${ media.mediaName ?? ""}", mainOnPress: (){player.play(DeviceFileSource(media.mediaPath.path));
                                    }, contextMenuOnPress: (){}, images: snapshot.data, subtext: "",);
                                  }
                                  else
                                  {
                                    return MediaGridItem(name: media.mediaName ?? " ", mainOnPress: (){player.play(DeviceFileSource(media.mediaPath.path));}, contextMenuOnPress: (){}, subtext: "Test");
                                  }
                                },
                              )],
                      ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.hasError) {
                  return baseItemGrid.gridError(context, snapshot.error);
                }
                else {
                  return baseItemGrid.gridLoading(context);
                }
              })
        ],
      ),
    );
  }
}

void Setcolor(ImageProvider image, BuildContext context) async
{
  print(image);
  PaletteGenerator generator = await PaletteGenerator.fromImageProvider(image);

  ColorScheme scheme = await ColorScheme.fromImageProvider(provider: image, brightness: Brightness.light);

  print(scheme.primary);
  UpdateColor(context, scheme);

  print(scheme.onSecondary);
}

void UpdateColor(BuildContext context, ColorScheme scheme)
{
  print(scheme.onPrimary);
  context.read()<ColorProvider>().updateColors(scheme.primary);
  print("Test");
}
