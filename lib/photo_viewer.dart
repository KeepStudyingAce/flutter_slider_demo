import 'package:flutter/material.dart';
import 'package:flutter_swiper_demo/indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  PhotoViewer({Key key, this.galleryItems, this.initIndex}) : super(key: key);
  final List galleryItems;
  final int initIndex;

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  PageController _pageController;
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initIndex;
    _pageController = PageController(initialPage: widget.initIndex);
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    double bottomTabHeight = MediaQuery.of(context).padding.bottom;
    double topNavigationHeight = MediaQuery.of(context).padding.top;
    return Stack(alignment: Alignment.center, children: [
      GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(widget.galleryItems[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
                );
              },
              itemCount: widget.galleryItems.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black45,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
              // backgroundDecoration: widget.backgroundDecoration,
              pageController: _pageController,
              onPageChanged: onPageChanged,
            ),
          )),
      Positioned(
          top: topNavigationHeight,
          child: Text(
            "第${currentIndex + 1}/${widget.galleryItems.length}张",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
      Positioned(
          bottom: bottomTabHeight + 40,
          child: Offstage(
            offstage: widget.galleryItems.length == 1,
            child: Indicator(
              itemCount: widget.galleryItems.length,
              controller: _pageController,
            ),
          ))
    ]);
  }
}
