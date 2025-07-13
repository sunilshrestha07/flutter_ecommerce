import 'dart:convert';
import 'package:ecommerce/common/model/review_model.dart';
import 'package:ecommerce/common/widgets/review_tile.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  List<reviewmodel> allReviews = [];
  bool isFetching = false;
  final _userDeatilsBox = Hive.box<UserModel>("userDetailsHiveBox");
  List<UserModel> loggedInUser = [];

  // method to fetch the reviews for the owner
  Future<void> fetchReviews() async {
    try {
      setState(() {
        isFetching = true;
      });
      final url = "https://fashion-fusion-suneel.vercel.app/api/review";
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List reviewData = data["reviews"];

        setState(() {
          allReviews = reviewData.map((json) => reviewmodel.fromJson(json)).toList();
        });
        setState(() {
          isFetching = false;
        });
      } else {
        setState(() {
          isFetching = false;
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text("Error fetching the reviews")));
      }
    } catch (e) {
      setState(() {
        isFetching = false;
      });
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Internal Server error $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = _userDeatilsBox.values.toList();
    });
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    final List<reviewmodel> filteredItems = allReviews
        .where((item) => item.userId == loggedInUser[0].sId)
        .toList();
    final List<reviewmodel> uniqueReviews = {
      for (var item in filteredItems) item.postId: item,
    }.values.toList();

    // final List<reviewmodel> uniqueReviews = filteredItems.toSet().toList();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              "My Reviews",
            ),
            Text(
              textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color.fromARGB(255, 142, 142, 142),
                fontWeight: FontWeight.w400,
              ),
              "Products You Have Provided Feedback On",
            ),

            SizedBox(height: 15),

            // Products list card
            Expanded(
              child: isFetching
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: uniqueReviews.length,
                      itemBuilder: (context, index) {
                        return ReviewTile(items: uniqueReviews[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
