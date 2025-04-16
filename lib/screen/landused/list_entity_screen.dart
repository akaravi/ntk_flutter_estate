import 'package:ntk_cms_flutter_base/src/controller/index.dart';
import 'package:ntk_cms_flutter_base/src/screen/generics/error_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_empty_screen.dart';

class EntityListScreen<model> extends StatefulWidget {
  final BaseListController<model> controller;
  String title;
  ListStateCreator<State<EntityListScreen>> stateCreator;

  @override
  State createState() => stateCreator();

  EntityListScreen._({
    Key? key,
    required this.controller,
    required this.title,
    required this.stateCreator,
  }) : super(key: key);

  EntityListScreen.withFilterScreen(
      {required this.controller, required this.title, super.key})
      : stateCreator = (() => _ListWithFilterState<model>());

  EntityListScreen.asGridScreen(
      {required this.controller,
      required this.title,
      required int crossAxs,
      super.key})
      : stateCreator = (() => _GridListFilterState(crossAxs));

  EntityListScreen.horizontalListWidget(
      {required this.controller, required this.title, super.key})
      : stateCreator = (() => _HorizontalListState());

  EntityListScreen.verticalListWidget(
      {required this.controller, required this.title, super.key})
      : stateCreator = (() => _HorizontalListState(isHorizontal: false));

  EntityListScreen.listOnly(
      {required this.controller, List<model>? listItems, super.key})
      : title = "",
        stateCreator = (() => _ListOnlyState<model>(listItems ?? []));


  floatingActionButton(BuildContext context) {}
}

typedef ListStateCreator<T extends State<EntityListScreen>> = T Function();

class _ListWithFilterState<model> extends State<EntityListScreen> {

  @override
  void initState() {
    widget.controller.initPageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
          onPressed: () => widget.controller.close(context),
        ),
        iconTheme:
            const IconThemeData(color: GlobalColor.colorAccent, size: 24),
        title: Text(
          widget.title,
          style: const TextStyle(color: GlobalColor.colorAccent),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.tune),
        //     onPressed: () {
        //       widget.controller.showFilters(context);
        //     },
        //   )
        // ],
      ),
      body: RefreshIndicator(
          onRefresh: () => Future.sync(
                () => widget.controller.pagingController.refresh(),
              ),
          child: PagingListener(
              controller: widget.controller.pagingController,
              builder: (context, state, fetchNextPage) =>
                  PagedListView(
                    padding: const EdgeInsets.all(8),
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate(
                      firstPageErrorIndicatorBuilder: (context) =>
                          ErrorIndicator(
                        error: widget.controller.pagingController.error,
                        onTryAgain: () =>
                            widget.controller.pagingController.refresh(),
                      ),
                      noItemsFoundIndicatorBuilder: (context) =>
                          SubEmptyScreen(),
                      itemBuilder: (context, item, index) =>
                          widget.controller.widgetAdapter(context, item, index),
                    ),
                  ))),
      floatingActionButton: widget.floatingActionButton(context),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.dispose();
  }
}

class _GridListFilterState extends State<EntityListScreen> {
  int crossAixes;

  _GridListFilterState(this.crossAixes);

  @override
  void initState() {
    widget.controller.initPageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
          onPressed: () => widget.controller.close(context),
        ),
        iconTheme:
            const IconThemeData(color: GlobalColor.colorAccent, size: 24),
        title: Text(
          widget.title,
          style: const TextStyle(color: GlobalColor.colorAccent),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.tune),
        //     onPressed: () {
        //       widget.controller.showFilters(context);
        //     },
        //   )
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => widget.controller.pagingController.refresh(),
        ),
        child:
        PagedGridView(
          state: widget.controller.pagingController.value,
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          fetchNextPage: widget.controller.pagingController.fetchNextPage,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: crossAixes,
          ),
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) =>
                widget.controller.widgetAdapter(context, item, index),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: widget.controller.pagingController.error,
              onTryAgain: () => widget.controller.pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const SubEmptyScreen(),
          ),
          padding: const EdgeInsets.all(8),
        ),
      ),
      floatingActionButton: widget.floatingActionButton(context),
    );
  }
}

class _HorizontalListState extends State<EntityListScreen> {
  bool? isHorizontal;

  _HorizontalListState({this.isHorizontal});

  @override
  void initState() {
    widget.controller.initPageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('');
    //   PagedListView.separated(
    //   scrollDirection: (isHorizontal ?? true) ? Axis.horizontal : Axis.vertical,
    //   pagingController: widget.controller.pagingController,
    //   builderDelegate: PagedChildBuilderDelegate(
    //     itemBuilder: (context, item, index) =>
    //         widget.controller.widgetAdapter(context, item, index),
    //     firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
    //       error: widget.controller.pagingController.error,
    //       onTryAgain: () => widget.controller.pagingController.refresh(),
    //     ),
    //     noItemsFoundIndicatorBuilder: (context) => const SubEmptyScreen(),
    //   ),
    //   padding: const EdgeInsets.all(8),
    //   separatorBuilder: (context, index) => const SizedBox(
    //     height: 16,
    //   ),
    // );
  }
}

class _ListOnlyState<model> extends State<EntityListScreen<model>> {
  List<model> items;

  _ListOnlyState(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.controller.widgetAdapter(context, items[index], index);
        });
  }
}
