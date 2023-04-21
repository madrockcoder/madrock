// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:geniuspay/app/group_payment/pages/add_group_member.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

TextEditingController groupNameController = TextEditingController();

TextEditingController groupDescriptionController = TextEditingController();

class CreateNewGroup extends StatefulWidget {
  const CreateNewGroup({Key? key}) : super(key: key);

  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
        title: Text('Create a new group', style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor)),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/groups/add_picture.png',
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff008AA7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: groupNameController.text.isEmpty ? Colors.transparent : const Color(0xffE0F7FE),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(top: 32),
                  child: TextFormField(
                    maxLength: 4,
                    controller: groupNameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      counterText: '',
                      border: InputBorder.none,
                      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff008AA7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: groupDescriptionController.text.isEmpty ? Colors.transparent : const Color(0xffE0F7FE),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(top: 15),
                  child: TextFormField(
                    maxLength: 4,
                    controller: groupDescriptionController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      counterText: '',
                      border: InputBorder.none,
                      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                    ),
                  )),
              ListTile(
                contentPadding: EdgeInsets.only(top: 25),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => AddGroupMember())));
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColor.kAccentColor2),
                  child: Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  'Add members',
                  style: textTheme.titleLarge,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Members',
                    style: textTheme.titleMedium?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  Text(
                    '1/80',
                    style: textTheme.titleMedium?.copyWith(color: AppColor.kSecondaryColor),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Container(
                    alignment: Alignment.center,
                    height: height / 10,
                    child: ListTile(
                      leading: Image.asset('assets/groups/girl.png'),
                      title: Text('You'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
        child: CustomElevatedButton(
          onPressed: () {},
          radius: 8,
          color: groupNameController.text == '' && groupDescriptionController.text == ''
              ? AppColor.kAccentColor2
              : AppColor.kGoldColor2,
          child: Text('CREATE', style: textTheme.bodyLarge),
        ),
      ),
    );
  }
}
