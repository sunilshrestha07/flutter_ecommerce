import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/views/login.dart';
import 'package:ecommerce/features/myorders/views/my_orders.dart';
import 'package:ecommerce/features/myreview/views/my_reviews.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _hiveuserBox = Hive.box("userHiveBox");
  final _userDeatilsBox = Hive.box<UserModel>("userDetailsHiveBox");
  List<UserModel> loggedInUser = [];

  late Map<String, Map<String, dynamic>> profileOptions;

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = _userDeatilsBox.values.toList();
    });
    profileOptions = {
      "My orders": {"title": "View your orders", "onpressed": handeMyOrder},
      "My reviews": {"title": "Your all reviews", "onpressed": handelMyreview},
      "My settings": {"title": "Profile, email, password", "onpressed": handelMysettings},
      "Logout": {"title": "", "onpressed": handelLogout},
    };
  }

  // handel myorder method
  void handeMyOrder() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
  }

  // handel myorder method
  void handelMyreview() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyReviews()));
  }

  // handel myorder method
  void handelMysettings() {
    debugPrint("My settings pressed");
  }

  void handelLogout() async {
    await GoogleSignIn().signOut();
    _hiveuserBox.put("isLoggedIn", false);
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsToShow = profileOptions.entries.toList();

    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                "My Profile",
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // avatar of the user
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      // color: Colors.red,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: CachedNetworkImage(
                        imageUrl: loggedInUser[0].avatar.toString(),
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        loggedInUser[0].userName.toString(),
                      ),
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 126, 126, 126),
                        ),
                        loggedInUser[0].email.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                // final itemsToshow = profileOptions.toList()
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileOptions.length,
                itemBuilder: (context, index) {
                  final entry = itemsToShow[index];
                  return ProfileOptionsListile(
                    title: entry.key,
                    subTitle: entry.value["title"],
                    onTap: entry.value["onpressed"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class for the listview of the options in the Profile
class ProfileOptionsListile extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  const ProfileOptionsListile({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: title == "Logout" ? Colors.red : Colors.black,
        ),
        title,
      ),
      subtitle: Text(
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 126, 126, 126),
        ),
        subTitle,
      ),
      trailing: RotatedBox(
        quarterTurns: 10,
        child: Icon(
          color: title == "Logout" ? Colors.red : Colors.black,

          size: 15,
          Icons.arrow_back_ios_new_sharp,
        ),
      ),
    );
  }
}
