import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:i_baza/assets/colors.dart';
import 'package:i_baza/features/authentication/presentation/pages/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditingProfileScreen extends StatefulWidget {
  const EditingProfileScreen({super.key});

  @override
  State<EditingProfileScreen> createState() => _EditingProfileScreenState();
}

class _EditingProfileScreenState extends State<EditingProfileScreen> {
  File? avatar;
  final _name = Hive.box("name");
  final _location = Hive.box("location");
  final avatarBox = Hive.box('avatar');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileData();
  }

  Future<void> _profileData() async {
    final name = await _name.get(1) ?? '';
    final location = await _location.get(1) ?? '';
    final avatarPath = await avatarBox.get('avatar_path');

    if (avatarPath != null) {
      avatar = File(avatarPath);
    }

    setState(() {
      _nameController.text = name;
      _locationController.text = location;
    });
  }

  Future<void> pickerAvatar() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        avatar = File(file.path);
      });
      await avatarBox.put('avatar_path', file.path);
    }
  }

  void _saveProfileData() {
    _name.put(1, _nameController.text);
    _location.put(1, _locationController.text);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: definitionGrey,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Padding(

          padding:  EdgeInsets.only(left: 75,right: 90),
          child:  Text(
            "Profilni tahrirlash",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 370,
                    width: double.infinity,
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        pickerAvatar();
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: avatar == null ? const Icon(Icons.person,
                            size: 60, color: Colors.grey) : Image.file(avatar!,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),


                  Positioned(top: 115, left: 16, right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const Text('F.I.Sh',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const Gap(12),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Ismingizni kiriting",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(18),
                  Positioned(
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const  Text(
                          'Manzilingiz',
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(7),
                         Container(
                            constraints: const BoxConstraints.tightFor(width: 340.0, height: 120.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextField(
                              controller: _locationController,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                hintText: "Manzilni kiriting",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),

                ],

            ),
            const SizedBox(height: 260),
            ElevatedButton(
              onPressed: () {
                _saveProfileData();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
              },
              child: Text('Saqlash',style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                primary: buttonTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity,55),
              ),
            ),

          ],
        ),
      ),
    );
  }
}