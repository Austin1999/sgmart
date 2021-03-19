import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class ShopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Iframe());
  }
}

class Iframe extends StatelessWidget {
  Iframe() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframe', (int viewId) {
      var iframe = html.IFrameElement();
      iframe.src = 'https://sgmart.co.in/';
      return iframe;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: HtmlElementView(viewType: 'iframe'));
  }
}

// // ignore: must_be_immutable
// class IframeScreen extends StatefulWidget {
//   double w;
//   double h;
//   String src;

//   IframeScreen(double _w, double _h, String _src){
//     this.w = _w;
//     this.h = _h;
//     this.src = _src;
//   }

//   @override
//   _IframeScreenState createState() => _IframeScreenState(w, h, src);
// }

// class _IframeScreenState extends State<IframeScreen> {
//   Widget _iframeWidget;
//   final IFrameElement _iframeElement = IFrameElement();
//   double _width;
//   double _height;
//   String _source;

//   _IframeScreenState(double _w, double _h, String _src){
//     _width = _w;
//     _height = _h;
//     _source = _src;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _iframeElement.src = _source;
//     _iframeElement.style.border = 'none';

//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeElement',
//     (int viewId) => _iframeElement,
//     );

//     _iframeWidget = HtmlElementView(
//       key: UniqueKey(),
//       viewType: 'iframeElement',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: _height,
//       width: _width,
//       child: _iframeWidget,
//     );
//   }
// }
