import 'package:amplifying_mediaplayer/controllers/providers/media_provider.dart';
import 'package:amplifying_mediaplayer/models/Source_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void saveSourceController({
  required BuildContext context,
  MediaSource? existingSource,
  required String name,
  required MediaGroups mediaGroups,
  required MediaLabels primaryLabel,
  required MediaLabels secondaryLabel
})
{
//Create Source
  MediaSource source = MediaSource(
      sourceName: name,
      mediaGroup: mediaGroups,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel);

if(existingSource == null)
  {
    source.generateID();
  }
else
  {
     context.read<MediaProvider>().sources.remove(existingSource);
    source.sourceID = existingSource.sourceID;
  }

context.read<MediaProvider>().saveSource(source);
Navigator.pop(context);
}


