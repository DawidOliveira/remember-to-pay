import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../home_controller.dart';
import 'header_content_widget.dart';
import 'list_notes_widget.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  _HomeContentWidgetState createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.5),
                    Theme.of(context).primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: HeaderContentWidget(
                controller: widget.controller,
              ),
            ),
            RxBuilder(
              builder: (context) => TabBar(
                labelPadding: EdgeInsets.symmetric(vertical: 10),
                controller: tabController,
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      'Lembretes (${widget.controller.list.value.length})',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListNotesWidget(controller: widget.controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
