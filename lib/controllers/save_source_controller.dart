import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/Source_model.dart';

void saveSourceController({
  required BuildContext context,
  MediaSource? existingSource,
  required String name,
  required MediaGroups mediaGroups,
  required MediaLabels primaryLabel,
  required MediaLabels secondaryLabel,
  required List<String> sourceDirectorys,
})
{
//Create Source
  MediaSource source = MediaSource(
      sourceName: name,
      mediaGroup: mediaGroups,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      sourceDirectorys: sourceDirectorys);

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


