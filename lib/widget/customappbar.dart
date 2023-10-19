import 'package:flutter/material.dart';
import 'package:newsapp/views/countrypopup.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.amberAccent,
        width: width * 0.535,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text(
              "Khabari",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        PopupMenuButton(
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Language"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Settings"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Logout"),
              ),
            ];
          },
          onSelected: (value) {
            if (value == 0) {
              var snackBar = SnackBar(
                  content: Center(
                child: Container(
                  child: Text("dsfsddssdsv"),
                ),
              ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const PopUpDialog();
                  });
            } else if (value == 2) {
              print("Logout menu is selected.");
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
