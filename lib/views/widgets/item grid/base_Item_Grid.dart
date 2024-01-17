import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';

class BaseItemGrid
{
  int crossAxisGridCount(BuildContext context)
  {
    int value = (MediaQuery.of(context).size.width *.0025).round();
    return (value > 1 ? value : 1);
  }

  double gridCrossAxisSpacing()
  {
    return 12;
  }

  double gridMainAxisSpacing()
  {
    return 70;
  }

  Widget gridLoading(BuildContext context)
  {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(
            child: SizedBox(
              height: 40,
            ),
          ),
          Flexible(
            child: SpinKitRing(
              color: context
                  .watch<ColorProvider>()
                  .amplifyingColor
                  .accentColor,
              size: 100,
            ),
          ),
          const Flexible(
            child: SizedBox(
              height: 50,
            ),
          ),
          Flexible(
            child: Text(
              "   Loading... ",
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .accentColor,
                  fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }


  Widget gridError(BuildContext context, Object? error)
  {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Flexible(
            child: SizedBox(
              height: 40,
            ),
          ),
          Flexible(
            child: SpinKitRing(
              color: context
                  .watch<ColorProvider>()
                  .amplifyingColor
                  .accentColor,
              size: 100,
            ),
          ),
          const Flexible(
            child: SizedBox(
              height: 50,
            ),
          ),
          Flexible(
            child: Text(
              " ERROR: ${error}",
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .accentColor,
                  fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}



