import 'package:contact_app/screen/home/controller/home_controller.dart';
import 'package:contact_app/screen/home/model/database_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/database_helper.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  HomeController controller = Get.put(HomeController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("Add Contact"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.1,
                width: width * 1,
                child: TextFormField(
                  controller: txtName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if(value!.isEmpty)
                      {
                        return "Value is Required";
                      }
                    return null;
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Mobile"),
              ),
              Center(
                child: SizedBox(
                  height: height * 0.1,
                  width: width * 1,
                  child: TextFormField(
                    controller: txtMobile,
                    keyboardType: TextInputType.phone,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Value is Required";
                      }
                      else if(value.length < 10)
                        {
                          return "Only 10 number required";
                        }
                      else if(value.length > 10)
                      {
                        return "Only 10 number required";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    DatabaseModel model = DatabaseModel(
                      name: txtName.text,
                      mobile: int.parse(txtMobile.text),
                    );
                    print("========================${model.mobile}");
                    DatabaseHelper.helper.insertDb(model);
                    DatabaseHelper.helper.getData();
                    controller.readData();
                  }
                },
                child: const Text("Save"),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue.shade200),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
