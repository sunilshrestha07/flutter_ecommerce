import 'package:ecommerce/common/model/review_model.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class SpecificItemComments extends StatefulWidget {
  final dynamic sId;
  final dynamic rating;
  const SpecificItemComments({super.key, required this.sId, required this.rating});

  @override
  State<SpecificItemComments> createState() => _SpecificItemCommentsState();
}

class _SpecificItemCommentsState extends State<SpecificItemComments> {
  final _reviewController = TextEditingController();
  final _userBox = Hive.box<UserModel>("userDetailsHiveBox");
  int rating = 0;
  String reviewMessage = "";
  List<reviewmodel> allReviews = [];
  List<UserModel> loggedInUser = [];
  bool isFetching = false;
  bool isUploading = false;

  // method to fetch the review
  Future<void> fetchReview() async {
    try {
      setState(() {
        isFetching = true;
      });
      final url = "https://fashion-fusion-suneel.vercel.app/api/review/${widget.sId}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List review = data['reviews'];
        setState(() {
          allReviews = review.map((json) => reviewmodel.fromJson(json)).toList();
          isFetching = false;
        });
      } else {
        debugPrint("error fetching the review");
        setState(() {
          isFetching = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isFetching = false;
      });
    }
  }

  //handelReviewSubmit
  Future<void> handelReviewSubmit() async {
    try {
      setState(() {
        isUploading = true;
      });
      final Map<String, dynamic> formData = {
        "rating": rating,
        "comment": reviewMessage,
        "postId": widget.sId,
        "userId": loggedInUser[0].sId,
        "userName": loggedInUser[0].userName,
        "userImage": loggedInUser[0].avatar,
      };
      final url = "https://fashion-fusion-suneel.vercel.app/api/review";
      final res = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (res.statusCode == 200) {
        setState(() {
          isUploading = false;
          reviewMessage = " ";
          rating = 0;
          _reviewController.clear();
        });
        await fetchReview();
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Review successful")),
        );
      } else {
        setState(() {
          isUploading = false;
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text("Review submition error")),
        );
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error submmiting review $e"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = _userBox.values.toList();
    });
    fetchReview();
  }

  @override
  void dispose() {
    super.dispose();
    _reviewController;
  }

  // fetch review for the specific product
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          // textfield for the Reviews
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              // "Leave a review",
              widget.sId,
            ),
          ),

          // star rating
          RatingBar.builder(
            maxRating: 5,
            initialRating: rating.toDouble(),
            allowHalfRating: false,
            itemSize: 30,
            itemBuilder: (context, _) => Icon(color: Colors.amber, Icons.star),
            onRatingUpdate: (e) {
              setState(() {
                rating = e.toInt();
              });
            },
          ),

          SizedBox(height: 15),
          //textfiled for the review input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              child: TextFormField(
                onChanged: (e) {
                  setState(() {
                    reviewMessage = e;
                  });
                },
                controller: _reviewController,
                decoration: InputDecoration(hint: Text("Give your review")),
                maxLines: 5,
              ),
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FilledButton(
              onPressed: handelReviewSubmit,
              child: isUploading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text("Submit"),
            ),
          ),

          SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              "Rating & Reviews",
            ),
          ),

          SizedBox(height: 5),

          ListTile(
            title: Text(
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              "${widget.rating}.0",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    color: Colors.red,
                    index < widget.rating ? Icons.star : Icons.star_border,
                  ),
                ),
              ],
            ),
          ),

          // show the comments
          allReviews.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: isFetching
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                "No reviews",
                              ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  cacheExtent: 1000,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allReviews.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      children: [
                        Container(width: double.infinity),

                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 231, 231, 231),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    allReviews[index].userName.toString(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ...List.generate(
                                            5,
                                            (starIndex) => Icon(
                                              size: 20,
                                              color: Colors.amber,
                                              (starIndex <
                                                      (allReviews[index].rating ?? 0))
                                                  ? Icons.star
                                                  : Icons.star_border,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(255, 92, 92, 92),
                                        ),
                                        DateFormat.yMMMMd().format(
                                          DateTime.parse(
                                            allReviews[index].updatedAt.toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    allReviews[index].comment.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 4,
                          left: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: const Color.fromARGB(255, 124, 124, 124),
                            ),
                            width: 45,
                            height: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.network(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                                allReviews[index].userImage.toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
