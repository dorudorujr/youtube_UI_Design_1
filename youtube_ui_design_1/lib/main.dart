import 'package:flutter/material.dart';
import 'package:youtube_ui_design_1/CustomIcons.dart';
import 'package:youtube_ui_design_1/data.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,    //開発中にアプリの右上に表示されている"Slow Mode"バナーを非表示にする
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRation = cardAspectRatio * 1.2;

class _MyAppState extends State<MyApp> {

  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {

    //ページ遷移を操作できるクラス
    //initialPage: 最初にPageViewを作成したときに表示されるページ
    PageController controller = PageController(initialPage: images.length - 1);
    //オブジェクトが変更された時に呼び出される
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  //空きスペースを子供の間に均等に配置します。
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        CustomIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),    //垂直方向と水平方向
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Trending",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      ),
                  ),
                  IconButton(
                      icon: Icon(
                        CustomIcons.option,
                        size: 12.0,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    //箱のデザイン設定？
                    decoration: BoxDecoration(
                      color: Color(0xFFff6e6e),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                          child: Text("Animated",
                              style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("25+ Stories",
                      style: TextStyle(color: Colors.blueAccent))
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                //CardScrollWidgetは表示しているだけ、PageViewのaddListenerでindexが変更されて表示も変わる
                CardScrollWidget(currentPage),
                Positioned.fill(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        //中身のデザイン?
                        itemBuilder: (context, index) {
                          return Container();
                        },
                    )
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),    //垂直方向と水平方向
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Favourite",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46.0,
                      fontFamily: "Calibre-Semibold",
                      letterSpacing: 1.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      CustomIcons.option,
                      size: 12.0,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    //箱のデザイン設定？
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                        child: Text("Latest",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("9+ Stories",
                      style: TextStyle(color: Colors.blueAccent))
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset("assets/image_02.jpg",
                        width: 296.0, height: 222.0),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio( //縦横比を維持したまま、最大の大きさに広がってくれるWidget
        aspectRatio: widgetAspectRation,
        //Widgetのサイズを取得
        child: LayoutBuilder(builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;  //余白を差し引いたwidgetの横幅
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for(var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            //max: 二つの数字のうち大き方を返す
            var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);

            var cardItem = Positioned.directional(    //stackの配置決め
              top: padding + verticalInset * max(-delta,0.0),     //各画像のtopの位置
              bottom: padding + verticalInset * max(-delta, 0.0), //各画像のbottomの位置
              start: start,   //子の画像がスタックの前画像から差し込まれる位置
              textDirection: TextDirection.rtl,   //左始まりか右始まりか
              child: ClipRRect(   //角を丸くする
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0
                    )
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(images[i],fit: BoxFit.cover,),
                        Align(    //子widgetの位置を調整する
                          alignment: Alignment.bottomLeft,  //位置
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0
                                  ),
                                  child: Text(title[i],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular"
                                    ),
                                  ),
                              ),
                              SizedBox(height: 10.0,),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text("Read Later",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        }),
    );
  }
}
