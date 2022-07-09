 TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: openedTabPageList.map<Tab>((TabPage? tabPage) {
        var tabContent = Row(
          children: <Widget>[
            Text(Utils.isLocalEn(context)
                ? tabPage!.nameEn ?? ''
                : tabPage!.name ?? ''),
            if (!defaultTabs.contains(tabPage))
              Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: 25,
                  child: IconButton(
                    iconSize: 10,
                    splashRadius: 10,
                    onPressed: () => Utils.closeTab(tabPage),
                    icon: Icon(Icons.close),
                  ),
                ),
              )
          ],
        );
        return Tab(
          child: CryMenu(
            child: tabContent,
            onSelected: (dynamic v) {
              switch (v) {
                case TabMenuOption.close:
                  Utils.closeTab(tabPage);
                  break;
                case TabMenuOption.closeAll:
                  Utils.closeAllTab();
                  break;
                case TabMenuOption.closeOthers:
                  Utils.closeOtherTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheRight:
                  Utils.closeAllToTheRightTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheLeft:
                  Utils.closeAllToTheLeftTab(tabPage);
                  break;
              }
            },
            // itemBuilder: (context) => <PopupMenuEntry<TabMenuOption>>[
            //   if (!defaultTabs.contains(tabPage))
            //     PopupMenuItem(
            //       value: TabMenuOption.close,
            //       child: ListTile(
            //         title: Text('Close'),
            //       ),
            //     ),
            //   PopupMenuItem(
            //     value: TabMenuOption.closeAll,
            //     child: ListTile(
            //       title: Text('Close All'),
            //     ),
            //   ),
            //   PopupMenuItem(
            //     value: TabMenuOption.closeOthers,
            //     child: ListTile(
            //       title: Text('Close Others'),
            //     ),
            //   ),
            //   PopupMenuItem(
            //     value: TabMenuOption.closeAllToTheRight,
            //     child: ListTile(
            //       title: Text('Close All to the Right'),
            //     ),
            //   ),
            //   PopupMenuItem(
            //     value: TabMenuOption.closeAllToTheLeft,
            //     child: ListTile(
            //       title: Text('Close All to the Left'),
            //     ),
            //   ),
            // ],
          ),
        );
      }).toList(),
    );

    var content = Container(
      child: Expanded(
        child: IndexedStackLazy(
          index: currentIndex,
          children: openedTabPageList.map((TabPage? tabPage) {
            var page = tabPage!.url != null
                ? Routes.layoutPagesMap[tabPage.url!] ?? Container()
                : tabPage.widget ?? Container();
            return KeyedSubtree(
              child: page,
              key: Key('page-${tabPage.id}'),
            );
          }).toList(),
        ),
      ),
    );

    var result = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: context.theme.primaryColor,
            child: Row(
              children: <Widget>[
                Expanded(child: tabBar),
                IconButton(
                  onPressed: () => layoutController.toggleMaximize(),
                  icon: Icon(layoutController.isMaximize
                      ? Icons.close_fullscreen
                      : Icons.open_in_full),
                  iconSize: 20,
                  color: Colors.white,
                )
              ],
            ),
          ),
          content,
        ],
      ),
    );
    return result;
  }
}




import 'package:flutter/material.dart';

class IndexedStackLazy extends StatefulWidget {
  final int index;
  final List<Widget> children;

  IndexedStackLazy({Key? key, this.index = 0, required this.children}) : super(key: key);

  @override
  _IndexedStackLazyState createState() => _IndexedStackLazyState();
}

class _IndexedStackLazyState extends State<IndexedStackLazy> {
  List<Widget> children = <Widget>[];
  int index = 0;

  @override
  void initState() {
    children.add(widget.children[widget.index]);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IndexedStackLazy oldWidget) {
    List<Widget> newChildren = <Widget>[];
    for (int i = 0; i < widget.children.length; i++) {
      var w = widget.children[i];
      var existIndex = children.indexWhere((element) => element.key == w.key);
      if (existIndex > -1) {
        newChildren.add(children[existIndex]);
        if (widget.index == i) {
          index = newChildren.length - 1;
        }
      } else if (widget.index == i) {
        newChildren.add(w);
        index = newChildren.length - 1;
      }
    }
    children = newChildren;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: children,
    );
  }
}
