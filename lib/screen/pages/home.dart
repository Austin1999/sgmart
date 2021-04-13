import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/screen/landing_page.dart';

class ShopHome extends StatefulWidget {
  // List names = ['Rice', 'Masala', 'Home care', 'Personal Care'];
  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  List images = [
    'asset/categories/bubbly.png',
    'asset/categories/MASALA sakthi.jpg',
    'asset/categories/healthy.png',
    'asset/categories/iyarkaioil.png',
    'asset/categories/maharaja.png',
    'asset/categories/mrgoldcoconut.png',
    'asset/categories/nylonsago.jpg',
    'asset/categories/prabath.jpg',
    'asset/categories/riceflour.png',
    'asset/categories/ricepower.jpg',
    'asset/categories/savorit.png',
    'asset/categories/sooji.png',
    'asset/categories/srinawaab.png',
    'asset/categories/sunflower.png',
  ];

  List brand = [
    'asset/brand/Aachi.png',
    'asset/brand/maharaja.png',
    'asset/sgmart.png',
    'asset/brand/Sakthi.png',
    'asset/brand/udhaiyam.png'
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(

                      // height: MediaQuery.of(context).size.height*0.4,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: size.width > 1000 ? 3.5 : 2.5,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),

                //length of carousel
                Positioned(
                  left: size.width * 0.5,
                  bottom: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .010,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Brand we offer
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Brands we offer',
                      style: GoogleFonts.yantramanav(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: brand.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(25)),
                          // ),
                          child: Image.asset(
                            brand[index],
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      crossAxisCount: size.width > 1080
                          ? 5
                          : size.width > 860
                              ? 4
                              : size.width > 650
                                  ? 3
                                  : size.width > 432
                                      ? 2
                                      : 1,
                    ),
                  ),
                  //Categories
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Products on offer",
                      style: GoogleFonts.ubuntu(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .060,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        splashColor: Colors.green,
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor)),
                          child: Image.asset(
                            images[index],
                            height: 220,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250,
                        crossAxisCount: size.width > 1080
                            ? 5
                            : size.width > 860
                                ? 4
                                : size.width > 650
                                    ? 3
                                    : size.width > 432
                                        ? 2
                                        : 1,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2)),
                  )
                ],
              ),
            ),
            //Buttom Container
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(width: size.width * 10, child: Buttom_Detail()),
            ),
          ],
        ),
      ),
    );
  }

//build carousel
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
                margin: EdgeInsets.all(5.0),
                child: Image.asset(
                  item,
                  fit: BoxFit.fill,
                  width: 1500,
                )
                // ),
                ),
          ))
      .toList();
}

//carousel
final List<String> imgList = [
  'asset/carousel/bannert.png',
  'asset/carousel/sakthibanner.png',
  'asset/carousel/commission.png',
  // 'asset/carousel/masala.jpg'
];
