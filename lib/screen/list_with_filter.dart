import 'package:base/src/screen/generics/empty_list_indicator.dart';
import 'package:base/src/screen/generics/error_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:base/src/controller/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/sub_empty_screen.dart';

abstract class BaseListWithFilterScreen<model> extends StatefulWidget {
  final BaseListController<model> controller;
   String title;

   BaseListWithFilterScreen({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  floatingActionButton(BuildContext context) {
  }

  @override
  State createState() => _BaseListScreenState();
}

class _BaseListScreenState extends State<BaseListWithFilterScreen> {
  @override
  void initState() {
    widget.controller.initPageController();
    widget.controller.pagingController.addPageRequestListener((pageKey) {
      widget.controller.fetchPage(pageKey);
    });
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
        iconTheme: const IconThemeData(color: GlobalColor.colorAccent, size: 24),
        title: Text(
          widget.title,style: const TextStyle(color: GlobalColor.colorAccent),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              widget.controller.showFilters(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
              () => widget.controller.pagingController.refresh(),
        ),
        child: PagedListView.separated(
          pagingController: widget.controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) =>
                widget.controller.widgetAdapter(context, item, index),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              error: widget.controller.pagingController.error,
              onTryAgain: () => widget.controller.pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const SubEmptyScreen(),
          ),
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
        ),
      ),
      floatingActionButton: widget.floatingActionButton(context),);
  }
}

