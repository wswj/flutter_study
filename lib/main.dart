import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myf/pages/Recomment.dart';
import 'package:flutter_myf/providers/FavAnimationProvider.dart';
import 'package:flutter_myf/providers/RecommendProvider.dart';
import 'package:flutter_myf/widget/AnimationIcon.dart';
import 'package:flutter_myf/widget/FavAnimation.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    //修改状态栏颜色
    statusBarColor: Colors.black, // status bar color
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(),
        title: "抖音",
        home: MultiProvider(
          child: Scaffold(
              body: SafeArea(
                  top: true,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    child: Home(),
                  )),
              bottomNavigationBar: BottomAppBar(
                  child: Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.black),
                child: BtmBar(),
              ))),
          providers: [
            ChangeNotifierProvider(create: (context) => RecommandProvider()),
            ChangeNotifierProvider(create: (context) => FavAnimation())
          ],
        ));
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //获取屏幕的宽度=========需要注意的是该方法只有在MateriaApp的home属性中的组件中才有效
    RecommandProvider provider = Provider.of<RecommandProvider>(context);
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582823518424&di=f62eb328c9599f8fcb1b64be1cb3401d&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201509%2F25%2F20150925080851_QCmJw.thumb.700_0.jpeg"),
                fit: BoxFit.fill)),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                height: 60,
                width: screen_width,
                child: Container(
                  decoration: BoxDecoration(
                      // color:Colors.redAccent
                      ),
                  child: TopBar(),
                )),
            Positioned(
                bottom: 0,
                width: screen_width * 0.7,
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                      //color:Colors.redAccent
                      ),
                  child: BtmContent(),
                )),
            Positioned(
                top: 0.25 * screen_height,
                width: 0.25 * screen_width,
                height: 0.5 * screen_height,
                right: 0,
                child: Container(
                  // color:Colors.white,
                  child: ButtonList(),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                height: 0.25 * screen_width,
                width: 0.25 * screen_width,
                child: Container(
                  child: RotateAlbum(),
                  // decoration:BoxDecoration(color:Colors.white)
                ))
          ],
        ));
  }
}

//顶部TabBar
class TopBar extends StatefulWidget {
  TopBar({Key key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Icon(Icons.search),
          ),
          Expanded(
              flex: 6,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: Colors.white,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
                      labelStyle: TextStyle(fontSize: 25, color: Colors.white),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 20, color: Colors.grey),
                      tabs: <Widget>[Text("关注"), Text("推荐")]))),
          Expanded(flex: 2, child: Icon(Icons.live_tv))
        ]);
  }
}

class BtmBar extends StatelessWidget {
  const BtmBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            getBottomTextWidget("首页", true),
            getBottomTextWidget("同城", false),
            AddIcon(),
            getBottomTextWidget("消息", false),
            getBottomTextWidget("我", false),
          ]),
    );
  }
}

getBottomTextWidget(String text, bool isSelect) {
  return Text(
    text,
    style:
        TextStyle(fontSize: 18, color: isSelect ? Colors.white : Colors.grey),
  );
}

class AddIcon extends StatelessWidget {
  const AddIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 60,
      child: Stack(children: <Widget>[
        Positioned(
            height: 35,
            width: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(5)),
            )),
        Positioned(
            height: 35,
            width: 50,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5)))),
        Positioned(
            height: 35,
            width: 50,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.add),
            )),
      ]),
    );
  }
}

class BtmContent extends StatelessWidget {
  const BtmContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 200,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListTile(
              title: Text(
                "@人民日报",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              subtitle: Text(
                "sssssssssssssssssssssssssssssssssssssssss",
                style: TextStyle(fontSize: 22, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Row(children: <Widget>[
              SizedBox(width: 20),
              Icon(
                Icons.music_video,
                color: Colors.white,
              ),
              //Marquee(text: "人民日报创建的原生音乐",)
//              Container(
//                width:100,
//                child: Marquee(
//   text: 'Some sample text that takes some space.',
//   style: TextStyle(fontWeight: FontWeight.bold),
//   scrollAxis: Axis.horizontal,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   blankSpace: 20.0,
//   velocity: 100.0,
//   pauseAfterRound: Duration(seconds: 1),
//   startPadding: 10.0,
//   accelerationDuration: Duration(seconds: 1),
//   accelerationCurve: Curves.linear,
//   decelerationDuration: Duration(milliseconds: 500),
//   decelerationCurve: Curves.easeOut,
// )
//              )
            ])
          ]),
    );
  }
}

class RotateAlbum extends StatefulWidget {
  RotateAlbum({Key key}) : super(key: key);

  @override
  _RotateAlbumState createState() => _RotateAlbumState();
}

class _RotateAlbumState extends State<RotateAlbum>
    with TickerProviderStateMixin {
  AnimationController animationController;
  var animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(animationController)
          ..addStatusListener((status) {
            //bool status==Animation.isCompleted;
            if (status == AnimationStatus.completed) {
              animationController.forward(from: 0.0);
            }
          }),
        child: Icon(
          Icons.account_circle,
          size: 60,
          color: Colors.white,
        ));
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: animation,
    );
  }
}

getButtonList(context, provider) {
  FavAnimation provider1 = Provider.of<FavAnimation>(context);
  double iconsize = 55;
  return Column(
    children: <Widget>[
      SizedBox(height: 20),
      Container(
          width: 60,
          height: 70,
          child: Stack(
            children: <Widget>[
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(60)),
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                      foregroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                          "https://pics6.baidu.com/feed/b21c8701a18b87d677d3552eb3636e3e1e30fde4.jpeg?token=14a27e43c5dd6a080ecbea781a47f9ad&s=181F37D0CC32DD9EBB067348030030D4"))),
              Positioned(
                bottom: 0,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
      SizedBox(height: 10),
      IconText(
        icon: IconButton(
            icon: provider.mainInfo.ifFaved
                ? AnimatePositiveIcon(
                    size: iconsize,
                    pctx: context,
                  )
                : AnimateNegativeIcon(size: iconsize),
            onPressed: () {
              provider.tapFav();
            }),
        text: "${provider.mainInfo.favCount}",
      ),
      SizedBox(height: 10),
      // InkWell(onTap:(){showBottom(context,provider);},
      // child:IconText(icon:Icon(Icons.message,size: 55,color:Colors.white),text: "99",)
      // ),
      SizedBox(height: 10),
      //IconText(icon:Icon(Icons.reply,size: 55,color:Colors.white),text: "99",)
    ],
  );
}

class IconText extends StatelessWidget {
  const IconText({Key key, this.icon, this.text}) : super(key: key);
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[icon, Container(child: Text(text))]),
    );
  }
}

showBottom(context, provider) {
  //RecommandProvider provider = Provider.of<RecommandProvider>(context);
  double height = MediaQuery.of(context).size.height;
  provider.setScreenHeight(height);
  provider.hideBottomBar();
  //显示底部弹框
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      context: context,
      builder: (_) {
        return Container(
          height: 600,
          child: ReplyFullList(pCtx: context),
        );
      });
}

class ButtonList extends StatefulWidget {
  ButtonList({Key key}) : super(key: key);

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    RecommandProvider provider = Provider.of<RecommandProvider>(context);
    //点赞动画类
    List<IconAnimationStage> stages1 = List<IconAnimationStage>();
    stages1.add(IconAnimationStage(
        color: Colors.grey[100],
        start: 1,
        end: 0,
        duration: Duration(milliseconds: 200)));
    stages1.add(IconAnimationStage(
        color: Colors.redAccent,
        start: 0,
        end: 1.2,
        duration: Duration(milliseconds: 300)));

    stages1.add(IconAnimationStage(
        color: Colors.redAccent,
        start: 1.2,
        end: 1,
        duration: Duration(milliseconds: 300)));

    //取消点赞动画类
    List<IconAnimationStage> stages2 = List<IconAnimationStage>();
    stages2.add(IconAnimationStage(
        start: 1,
        end: 1.2,
        color: Colors.redAccent,
        duration: Duration(milliseconds: 200)));
    stages2.add(IconAnimationStage(
        start: 1.2,
        end: 1,
        color: Colors.grey[100],
        duration: Duration(milliseconds: 200)));

    //回复以及转发动画定义
    List<IconAnimationStage> stages3 = List<IconAnimationStage>();
    stages3.add(IconAnimationStage(
        start: 1,
        end: 1.2,
        color: Colors.grey[200],
        duration: Duration(milliseconds: 200)));
    stages3.add(IconAnimationStage(
        start: 1.2,
        end: 1,
        color: Colors.grey[200],
        duration: Duration(milliseconds: 200)));

    double iconsize = 70 * rpx;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90 * rpx,
            height: 105 * rpx,
            child: Stack(children: <Widget>[
              Container(
                width: 90 * rpx,
                height: 90 * rpx,
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("${provider.mainInfo.avatarUrl}")),
              ),
              Positioned(
                  bottom: 0,
                  left: 25 * rpx,
                  child: Container(
                    width: 40 * rpx,
                    height: 40 * rpx,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Icon(Icons.add, size: 20, color: Colors.white),
                  ))
            ]),
          ),
          IconText(
            text: "${provider.mainInfo.favCount}",
            icon: !provider.mainInfo.ifFaved
                ? AnimationIconWidget(
                    key: UniqueKey(),
                    animationList: stages1,
                    icon: Icons.favorite,
                    size: iconsize,
                    provider: provider,
                    callback: () {
                      provider.tapFav();
                    })
                : AnimationIconWidget(
                    key: UniqueKey(),
                    animationList: stages2,
                    icon: Icons.favorite,
                    size: iconsize,
                    provider: provider,
                    callback: () {
                      provider.tapFav();
                    },
                  ),
          ),
          IconText(
            text: "${provider.mainInfo.replyCount}",
            icon: AnimationIconWidget(
              animationList: stages3,
              icon: Icons.comment,
              size: iconsize,
              callbackDelay: Duration(milliseconds: 200),
              callback: () {
                showBottom(context, provider);
              },
            ),
          ),
          IconText(
            text: "${provider.mainInfo.shareCount}",
            icon: AnimationIconWidget(
              animationList: stages3,
              icon: Icons.reply,
              size: iconsize,
            ),
          ),
        ],
      ),
    );
  }
}

class IconText1 extends StatelessWidget {
  const IconText1({Key key, this.icon, this.text}) : super(key: key);
  final AnimationIconWidget icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon,
          Container(
              // alignment: Alignment.center,
              child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 25 * rpx),
          ))
        ],
      ),
    );
  }
}
