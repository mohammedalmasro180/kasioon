import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
class myAd
    extends StatefulWidget {
  const myAd({Key? key}) : super(key: key);

  @override
  _myAdState createState() => _myAdState();
}

class _myAdState extends State<myAd> {
  final BannerAd myBanner = BannerAd(
    //
    adUnitId: 'ca-app-pub-5721905078810865/4165551078',
// adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );
  @override
  void initState() {
    super.initState();
  myBanner.load();
  }
  Widget build(BuildContext context) {    return Container(
    height: 100,
    width: 350,
    child: AdWidget(ad:myBanner),
  ) ;
  }
}
