import 'package:buku/main_objects/main_user.dart';
import 'package:buku/theme/current_theme.dart';
import 'package:buku/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileScaffold extends StatefulWidget {

  @override
  _EditProfileScaffoldState createState() => _EditProfileScaffoldState();

}

class _EditProfileScaffoldState extends State<EditProfileScaffold>{
  MainUser user = new MainUser();
  final int numImages = 8;

  String newProfilePic;
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final descController = TextEditingController();

  @override void initState() {
    user.getUserImage().then((data) {
      newProfilePic = data;
    });
    user.getName().then((data) {
      nameController..text = data;
    });
    user.getNickName().then((data) {
      nickNameController..text = data;
    });
    user.getDescription().then((data) {
      descController..text = data;
    });
    super.initState();
  }

  @override void dispose() {
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

  Widget _profileHeader(BuildContext context){
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
                _showDialog(context);
              },
              child: _editProfilePicBuilder()
          ),
        ),
        Positioned(
          top:50, left: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                color: Colors.white70,
                size:20.0),
          ),
        ),
        Positioned(
          top:50, right: 10,
          child: RaisedButton(
            elevation: 0,
            color: Colors.transparent,
            onPressed: () {
              _doneAlertDialog(context);
            },
            child: Text("Done",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 17),),
          ),
        ),
      ],
    );
  }

  Widget _editProfileForm(){
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
                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CurrentTheme.primaryColorVariant)
                )
            ),
          ),
          SizedBox(height: 20),
          TextField(
            autofocus: false,
            controller: nickNameController,
            cursorColor: CurrentTheme.textColor1,
            style: TextStyle(color: CurrentTheme.textColor1),
            decoration: InputDecoration(
                labelText: 'Nickname',
                labelStyle: TextStyle(
                  color: CurrentTheme.textFieldHint,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CurrentTheme.primaryColorVariant)
                )
            ),
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
                    borderSide: BorderSide(color: CurrentTheme.textColor1)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CurrentTheme.primaryColorVariant)
                ),
              helperStyle: TextStyle(color: CurrentTheme.textColor1)
            ),
          ),
        ],
      )
    );
  }

  void _showDialog(BuildContext context) {
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
            setProfileImage(
                'assets/user_images/user_' + i.toString() + '.png');
          },
          child: ProfileAvatar(
              size: 65,
              profileImage:
              'assets/user_images/user_' + i.toString() + '.png'),
        ),
      ));
    }
    return avatarList;
  }

  setProfileImage(String url) {
    newProfilePic = url;
  }

  Widget _editProfilePicBuilder(){
    return FutureBuilder(
      future: user.getUserImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String image = snapshot.hasError ?  'assets/images/user.png' : snapshot.data;
          return Stack(
            overflow: Overflow.visible,
              children: [
            ProfileAvatar(profileImage: image),
            Positioned(
                top: 80,
                left: 35,
                child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CurrentTheme.backgroundContrast),
                    child: Icon(Icons.edit,
                        color: CurrentTheme.primaryColor,
                    size: 20,))
            )
          ]);
        } else {
          return ShaderMask(
            shaderCallback: (bounds) =>
                LinearGradient(
                    colors: [Colors.black12, Colors.white]
                ).createShader(bounds),
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: CurrentTheme.backgroundContrast, width: 2),
                )),
          );
        }
      },
    );
  }

  Widget _doneAlertDialog(BuildContext context){
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

                //TODO: Save changes method.
                Navigator.popUntil(context, ModalRoute.withName('/settings'));
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
                Navigator.popUntil(context, ModalRoute.withName('/settings'));
              },
            )
          ],
        ));
  }

}