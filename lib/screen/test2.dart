import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 8),
        child: Column(
          children: [
            box(
                title: "نوع ssمعامله",
                widget: Container(

                  color: Colors.deepPurple,child: Text("asdasd"),
                )),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 2)),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'نوع ملک',
              ),
            )
          ],
        ),
      ),
    );
  }

  Container box({required String title, required Widget widget}) {
    return Container( width: double.infinity,
      decoration: BoxDecoration(color: GlobalColor.colorBackground),
      child: Stack(
        children: <Widget>[
          Positioned.fill(top: 10,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: GlobalColor.colorPrimary, width: 1)),
                padding: EdgeInsets.all(10),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Wrap(children: [widget],),
                )),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: GlobalColor.colorAccent, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }

  Card card({required List<Widget> children}) {
    return Card(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: children,
        ));
  }
}
