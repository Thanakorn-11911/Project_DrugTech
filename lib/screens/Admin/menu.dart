import 'package:ddd/Model/user.dart';
import 'package:ddd/services/constants.dart';
import 'package:ddd/services/db.dart';
import 'package:ddd/shared/getImage.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  //Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = UsersM.current;
    return Container(
      width: 250,
      color: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(user.email ?? "Account"),
            accountName: Text(user.username ?? "Account"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  user.image != null ? NetworkImage(user.image) : null,
              child: Stack(
                children: [
                  if (user.image == null)
                    Center(
                        child: Icon(
                      Icons.person,
                      color: navigationColor,
                    )),
                  if (loading)
                    Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    )),
                  Positioned(
                      top: 38,
                      left: 13,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          final data = await showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return GetImage();
                              });
                          if (data != null) {
                            loading = true;
                            setState(() {});
                            String urlImage = await dbService()
                                .loadFile(data, path: "profile");
                            print("\n\n");
                            print("output" + urlImage);
                            print("\n\n");
                            if (urlImage != null) {
                              UsersM.current.image = urlImage;
                              bool isupdate =
                                  await dbService().updateUser(UsersM.current);
                              if (isupdate) {
                                loading = false;
                                setState(() {});
                              }
                            }
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
