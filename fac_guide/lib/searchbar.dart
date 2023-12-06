import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:provider/provider.dart';
import 'place.dart';
import 'mapProvider.dart';

import 'search_model.dart'; // Import your SearchModel class

class MyFloatingSearchBar extends StatelessWidget {
  final FloatingSearchBarController controller;
  

  MyFloatingSearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<FloatingSearchBarAction> actions = <FloatingSearchBarAction>[
      FloatingSearchBarAction(
        child: CircularButton(
          icon: const Icon(Icons.directions),
          onPressed: () {

          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer<SearchModel>(
      builder: (BuildContext context, SearchModel model, _) =>
          FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        hint: 'Chercher sur le campus...',
        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
        iconColor: Theme.of(context).primaryColor,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        actions: actions,
        progress: model.isLoading,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: model.onQueryChanged,
        onKeyEvent: (KeyEvent keyEvent) {
          if (keyEvent.logicalKey == LogicalKeyboardKey.escape) {
            controller.query = '';
            controller.close();
          }
        },
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        builder: (BuildContext context, _) => MyExpandableBody(model),
      ),
    );
  }
}

class MyExpandableBody extends StatelessWidget {
  final SearchModel model;

  MyExpandableBody(this.model);

  @override
  Widget build(BuildContext context) {
    
    MapControllerProvider mapControllerProvider =
        Provider.of<MapControllerProvider>(context, listen: false);
    MapController mapController = mapControllerProvider.mapController;
            
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: ImplicitlyAnimatedList<Place>(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: model.suggestions,
          insertDuration: const Duration(milliseconds: 700),
          itemBuilder: (BuildContext context, Animation<double> animation,
              Place item, _) {
            return SizeFadeTransition(
              animation: animation,
              child: buildItem(context, item),
              
            );
          },
          updateItemBuilder:
              (BuildContext context, Animation<double> animation, Place item) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, item),
            );
          },
          areItemsTheSame: (Place a, Place b) => a == b,
        ),
      ),
    );
  }
}

Widget buildItem(BuildContext context, Place place) {
    
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    final SearchModel model = Provider.of<SearchModel>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
            onTap: () {
              FloatingSearchBar.of(context)?.close();
              Future<void>.delayed(
                const Duration(milliseconds: 500),
                () => model.clear(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 36,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: model.suggestions == history
                          ? const Icon(Icons.history, key: Key('history'))
                          : const Icon(Icons.place, key: Key('place')),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          place.numero,
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          place.nom,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        if (model.suggestions.isNotEmpty && place != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }
