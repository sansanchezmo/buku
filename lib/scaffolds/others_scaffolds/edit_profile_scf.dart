import 'package:buku/firebase/firestore.dart';
import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/utilities/validate_data.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileScaffold extends StatefulWidget {
  @override
  _EditProfileScaffoldState createState() => _EditProfileScaffoldState();
}

class _EditProfileScaffoldState extends State<EditProfileScaffold> {
  final int numImages = 8;
  bool valid;
  String errorMsg = "";
  String newProfilePic;
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    valid = true;
    newProfilePic = MainUser.user.imageUrl;
    nameController..text = MainUser.user.name;
    nickNameController..text = MainUser.user.nickname;
    descController..text = MainUser.user.description;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    nickNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileHeader(context),
            Center(child: _editProfileForm())
          ],
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: [
        Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CurrentTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: CurrentTheme.shadow1,
                        spreadRadius: 5,
                        blurRadius: 30)
                  ]),
            ),
            SizedBox(height: 75)
          ],
        ),
        Positioned(
          top: 90,
          child: GestureDetector(
              onTap: () {
                _showChoosePicDialog(context);
              },
              child: _editProfilePicBuilder()),
        ),
        Positioned(
          top: 50,
          left: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white70, size: 20.0),
          ),
        ),
        Positioned(
          top: 50,
          right: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () async {
              if(nickNameController.text != MainUser.user.nickname){
              var validation =
                  await ValidateData.checkName(nickNameController.text);

              if (validation[0]) {
                _doneAlertDialog(context);
              } else {
                setState(() {
                  errorMsg = validation[1];
                  valid = validation[0];
                });
              }} else {
                _doneAlertDialog(context);
              }
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white70, fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }

  Widget _editProfileForm() {
    return Container(
        width: 300,
        child: Column(
          children: [
            TextField(
              autofocus: false,
              controller: nameController,
              cursorColor: CurrentTheme.textColor1,
              style: TextStyle(color: CurrentTheme.textColor1),
              decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: CurrentTheme.textFieldHint,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CurrentTheme.textColor1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: CurrentTheme.primaryColorVariant))),
            ),
            SizedBox(height: 20),
            TextField(
              autofocus: false,
              controller: nickNameController,
              cursorColor: CurrentTheme.textColor1,
              style: TextStyle(color: CurrentTheme.textColor1),
              onChanged: (text) {
                setState(() {
                  valid = true;
                });
              },
              decoration: InputDecoration(
                  labelText: 'Nickname',
                  labelStyle: TextStyle(
                    color: CurrentTheme.textFieldHint,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CurrentTheme.textColor1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: CurrentTheme.primaryColorVariant)),
                  errorText: valid ? null : errorMsg),
            ),
            SizedBox(height: 20),
            TextField(
              autofocus: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 250,
              controller: descController,
              cursorColor: CurrentTheme.textColor1,
              style: TextStyle(color: CurrentTheme.textColor1),
              decoration: InputDecoration(
                  labelText: 'Biography',
                  labelStyle: TextStyle(
                    color: CurrentTheme.textFieldHint,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: CurrentTheme.textColor1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: CurrentTheme.primaryColorVariant)),
                  helperStyle: TextStyle(color: CurrentTheme.textColor1)),
            ),
          ],
        ));
  }

  void _showChoosePicDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: CurrentTheme.background,
              title: Text(
                'Choose your avatar',
                style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: userImages(),
                ),
              ),
            ));
  }

  List<Widget> userImages() {
    List<Widget> avatarList = [];
    for (int i = 0; i < numImages; i++) {
      avatarList.add(Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              newProfilePic = 'assets/user_images/user_' + i.toString() + '.png';
            });
          },
          child: ProfileAvatar(
              size: 65,
              profileImage: 'assets/user_images/user_' + i.toString() + '.png'),
        ),
      ));
    }
    return avatarList;
  }

  Widget _editProfilePicBuilder() {
    return Stack(overflow: Overflow.visible, children: [
      ProfileAvatar(profileImage: newProfilePic),
      Positioned(
          top: 80,
          left: 35,
          child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CurrentTheme.backgroundContrast),
              child: Icon(
                Icons.edit,
                color: CurrentTheme.primaryColor,
                size: 20,
              )))
    ]);
  }

  void _doneAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: CurrentTheme.background,
              title: Text(
                'Are you sure you want to save changes?',
                style: TextStyle(
                    color: CurrentTheme.textColor1,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: CurrentTheme.primaryColor,
                  child: Text('YES'),
                  onPressed: () {
                    Map<String, dynamic> newInfo = new Map<String, dynamic>();

                    if (this.newProfilePic != MainUser.user.imageUrl) {
                      newInfo[Firestore.userImgPath] = this.newProfilePic;
                    }
                    if (this.nameController.text != MainUser.user.name) {
                      newInfo[Firestore.name] = this.nameController.text;
                    }
                    if (this.nickNameController.text !=
                        MainUser.user.nickname) {
                      newInfo[Firestore.nickname] =
                          this.nickNameController.text;
                    }
                    if (this.descController.text != MainUser.user.description) {
                      newInfo[Firestore.biography] = this.descController.text;
                    }

                    if (newInfo.length != 0) {
                      MainUser.updateProfile(newInfo);
                    }

                    Navigator.popUntil(
                        context, ModalRoute.withName('/menu'));
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/menu');
                  },
                ),
                FlatButton(
                  textColor: CurrentTheme.primaryColor,
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  textColor: CurrentTheme.primaryColor,
                  child: Text('DO NOT SAVE'),
                  onPressed: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName('/settings'));
                  },
                )
              ],
            ));
  }
}
