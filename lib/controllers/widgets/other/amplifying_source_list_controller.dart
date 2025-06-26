import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/views/widgets/other/amplifying_source_List.dart';

class AmplifyingSourceListController
{
  Future<List<String?>> onPressAddSource(SourceFileType filetype) async
  {
    List<String?> endString = [];
    FileController fileController = new FileController();

    switch (filetype) {
      case SourceFileType.directory:
       await fileController.pickDirectory().then((value) => {
          if(value != null)
            {
              endString.add(value)
            }
        });
        break;

        case SourceFileType.file:
          await fileController.pickFile().then((value) => {
            if(value != null)
              {
                endString.addAll(value)
              }
          });
    }

    return endString;
  }
}