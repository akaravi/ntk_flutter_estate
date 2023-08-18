import 'package:ntk_cms_flutter_base/src/index.dart';
import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/controller/edit_customer_order_controller.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/estate/estate_list_screen.dart';

import '../screen/generalized/dialogs.dart';

class CustomerOrderController
    extends BaseListController<EstateCustomerOrderModel> {
  Widget Function(BuildContext context, EstateCustomerOrderModel m, int index)?
      adapterCreatorFunction;

  CustomerOrderController({FilterModel? filter}) : super(filterModel: filter);

  @override
  Future<List<EstateCustomerOrderModel>> service(FilterModel filter) {
    return EstateCustomerOrderService().getAllEditor(filter);
  }

  @override
  void showFilters(BuildContext context) {
    // TODO: implement showFilters
  }

  @override
  Widget widgetAdapter(
      BuildContext context, EstateCustomerOrderModel m, int index) {
    if (adapterCreatorFunction != null) {
      return adapterCreatorFunction!(context, m, index);
    } else {
      return _ModelAdapter(model: m);
    }
  }

  static delete(BuildContext context, EstateCustomerOrderModel model) {
    DeleteDialog().showConfirm( context: context, delete: ()async => EstateCustomerOrderService().delete(model));
  }
}

// ignore: must_be_immutable
class _ModelAdapter extends StatelessWidget {
  EstateCustomerOrderModel model;

  _ModelAdapter({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(children: [
        Text(model.title ?? ""),
        Row(
          children: [
            button(
              title: GlobalString.result,
              color: Colors.green,
              icon: Icons.remove_red_eye_sharp,
              onPressed: () => BaseController().newPage(
                  context: context,
                  newWidget: (context) =>  EstateListScreen.withOrder(id: model.id ?? "")),
            ),
            button(
              title: GlobalString.edit,
              color: GlobalColor.colorPrimary,
              icon: Icons.edit,
              onPressed: () =>
                  EditCustomerOrderController.start(context, model.id ?? ""),
            ),
            button(
              title: GlobalString.delete,
              color: GlobalColor.colorError,
              icon: Icons.delete,
              onPressed: () =>CustomerOrderController.delete(context,model),
            ),
          ],
        )
      ]),
    );
  }

  button(
      {required title,
      required color,
      required icon,
      required void Function() onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: TextButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1.0, color: color),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: color),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                icon,
                color: color,
              )
            ],
          )),
    );
  }
}
