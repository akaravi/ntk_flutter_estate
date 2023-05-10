import 'package:base/src/controller/ticket/new_ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class NewTicketScreen extends StatefulWidget {
  NewTicketScreen({Key? key}) : super(key: key);

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends BaseTicketPage<NewTicketScreen> {
  // Focus nodes are necessary
  final priorityFieldFocusNode = FocusNode();
  final departmentFieldFocusNode = FocusNode();
  NewTicketController controller = NewTicketController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
          onPressed: () => controller.close(context),
        ),
        iconTheme:
            const IconThemeData(color: GlobalColor.colorAccent, size: 24),
        title: Text(
          GlobalString.newTicket,
          style: const TextStyle(color: GlobalColor.colorAccent),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.attach_file),
        //     onPressed: () {
        //       controller.attach(context);
        //     },
        //   )
        // ],
      ),
      body: Column(
        children: [
          getHintWidget(
            title: GlobalString.fullName,
            error: controller.displayNameError(),
          ),
          getTextInputWidget(
              icon: Icons.person,
              hint: 'enter your name',
              textFieldController: controller.nameEditor),
          getHintWidget(
            title: 'Email',
            error: controller.displayEmailError(),
          ),
          getTextInputWidget(
              icon: Icons.alternate_email,
              hint: 'enter your email address',
              textFieldController: controller.emailEditor),
          getHintWidget(
            title: 'Mobile',
            error: controller.displayMobileError(),
          ),
          getTextInputWidget(
              icon: Icons.phone,
              hint: 'enter your mobile number',
              textFieldController: controller.mobileEditor),
          getHintWidget(
            title: 'Subject',
            error: controller.displaySubjectError(),
          ),
          getTextInputWidget(
              icon: Icons.person,
              hint: 'enter subject of your request',
              textFieldController: controller.subjectEditor),
          getHintWidget(
            title: 'Department',
            error: controller.displayDepartmentError(),
          ),
          getDropDownWidget(
              icon: Icons.group,
              hint: 'select desired department',
              focusNode: departmentFieldFocusNode,
              textFieldController: controller.departmentEditor,
              items: controller.departments),
          //name
          getHintWidget(
            title: 'Priority',
            error: controller.displayPriorityError(),
          ),
          getDropDownWidget(
              icon: Icons.upgrade_sharp,
              hint: 'select priority of request',
              focusNode: priorityFieldFocusNode,
              textFieldController: controller.priorityEditor,
              items: controller.priorities),
          //name
          getHintWidget(
            title: 'Attachment',
            error: controller.displayPriorityError(),
          ),
        ],
      ),
    );
  }
}
