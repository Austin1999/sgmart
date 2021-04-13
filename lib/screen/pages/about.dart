import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgmart/screen/landing_page.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'asset/bannert.png',
                height: size.width / 3,
                width: size.width,
              ),
              SizedBox(
                height: size.width * .010,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to SG Mart Maligai",
                      style:
                          GoogleFonts.ubuntu(fontSize: 22, color: Colors.black),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    //First para
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "We connect millions of buyers around Tamilnadu, empowering "
                        "people & creating economic opportunity for all.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    //Second para
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "SgMart Online Shopping is the Joint venture of SgMart "
                        "Trading Pte Ltd, Peruma Exports, Singapore/India "
                        "largest grocery retailer.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "With SgMart, you can shop for a wide range of your "
                        "household needs from fresh produce to quality Indian "
                        "Kitchen Spices/Grain/Masala Products, and home care "
                        "essentials to baby products. Have them delivered to "
                        "your door, or choose the most convenient time and "
                        "place for pickup. Enjoy an effortless shopping "
                        "experience with SgMart, whether from your computer,"
                        " tablet or mobile phone",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "In Sep 2000,  SgMart was founded  with a simple mission – "
                        "to save you time and money spent shopping for groceries"
                        " and household essentials, so you can focus on the "
                        "important things in life.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "Today, after putting a lot of hard work, challenges "
                        "and learnings, we’ve built a service that is delivering "
                        "on this promise for Indian grocery.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "We are having wide range of products in stock, and are "
                        "adding more regularly. We provide hot sale offer for "
                        "these products  everyday at low prices as well. We have "
                        "a website and mobile application to make ordering as "
                        "easy as possible.  And we have the latest warehouse and "
                        "delivery technologies to ensure your order gets to you "
                        "as ordered and when you want.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        "SgMart is selective in hiring hard-working, dedicated "
                        "employees who naturally focus on doing the best for our "
                        "customers.",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.grey[700],
                          wordSpacing: 2.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' Welcome to SgMart Online portal, were over 1000 Indian grocery and health & beauty products are available at a click of a mouse.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' Order any time, from any where via our site or mobile app. Thousands of groceries and home essential products at your fingertips. Our mission is to Save Money and Time.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' With the opening of the virtual doors of Sg Mart Online, we take an extra step in educating our customers with all attributes of our products.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' We know it is essential for our customers to know what they are buying. We take great care in neatly packing your order and deliver it to you always on time.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' SG Mart Online is managed by, Peruma Exports and Sgmart Trading Pte Ltd , who have experience in the Indian food and lifestyle industry since, 2000.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' We have formed powerful alliances with some of the largest distributors and wholesalers of Indian products from India and in Singapore. Together we bring you the largest variety of the best quality Indian products in the most efficient manner.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' We are committed to fusing three decades of knowledge with the convenience of the online Internet.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' Our mission is to provide the finest quality products with top notch service. We continue to add new products to our store regularly.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' Largest Chain Retail Outlets in Singapore dealing with Indian grocery, Indian Food Products.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, top: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' Peruma Exporters is leading exporters to South East Asia to Indian Grocery, Grains, spices and pulses.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 44.0, top: 12.0, bottom: 12.0),
                      child: RichText(
                        text: TextSpan(
                            text: '•',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            children: [
                              TextSpan(
                                text:
                                    ' SgMart Trading Pte Ltd is leading distributors of Indian products in Singapore, Malaysia and Indonesia.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  wordSpacing: 2.0,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child:
                      Container(width: size.width * 10, child: Buttom_Detail()))
            ],
          ),
        ),
      ),
    );
  }
}
