import 'package:flutter/material.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/viewItems/movies_view.dart';
import 'package:movies_booking/widgets/circle_avatar_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/title_text.dart';

import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
            child: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatarView(
                    "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
                  ),
                  LargeTitleText("Hi LiLy!"),
                ],
              ),
              SizedBox(height: MARGIN_SMALL_2),
              HorizontalMovieView("Now Showing",(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
              }),
              SizedBox(height: MARGIN_XLARGE),
              HorizontalMovieView("Coming Soon",() => _navigateToMoviesDetailScreen(context)),
            ],
          ),
        ),
      ),
    );
  }
  void _navigateToMoviesDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(),
      ),
    );
    print("confirm clicked");
  }
}

class HorizontalMovieView extends StatelessWidget {
  final String title;
  final Function onTapPoster;

  const HorizontalMovieView(this.title,this.onTapPoster);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(title),
        SizedBox(
          height: MARGIN_SMALL_2,
        ),
        Container(
          height: 250,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => MoviesView(onTapPoster)),
        ),
      ],
    );
  }
}