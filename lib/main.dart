import 'package:onboarding/data.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SliderModel> slide= new List<SliderModel>();
  int currentIndex=0;
  PageController controller= new PageController(initialPage: 0);
  @override
  void initState(){
    super.initState();
    slide= getSlides();

  }
  Widget pageIndexIndicator(bool isCurrent, int index){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 2),
      height: isCurrent? 10.0: 6.0,
      width: isCurrent? 10.0: 6.0,
      decoration: BoxDecoration(
        color: isCurrent? slide[index].getColour(): Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount:slide.length,
        onPageChanged: (val){
          setState(() {
            currentIndex=val;
          });
        },
        itemBuilder: (context, index)
        {return
          Slider(
            imageAssetPath: slide[index].getImageAssetPath(),
            title: slide[index].getTitle(),
            desc: slide[index].getDesc(),
            colour: slide[index].getColour(),

          );
        },),
      bottomNavigationBar :  currentIndex != slide.length -1? Opacity(
        opacity: 0.5,
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OutlineButton(
                onPressed: () {
                  controller.animateToPage(slide.length-1, duration:  Duration(milliseconds: 400), curve: Curves.linear);
                },
                child: Text("تخطي")
            ),
            Row(

              children: <Widget>[
                for(int i = 0; i < slide.length; i++) currentIndex == i ?
                pageIndexIndicator(true, i) : pageIndexIndicator(false, i),
              ],
            ),
            OutlineButton(
              onPressed: () {
                controller.animateToPage(currentIndex + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);

              },
              child: Text("التالي"),
            ),],
        ),
      )
          : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              highlightedBorderColor: Colors.amber,
              onPressed: (){},
              child: Text("لنبدأ",
                style: TextStyle(
                  color: Colors.amber,
                ),),),
          ])
      ,
    );
  }
}

class Slider extends StatelessWidget {
  String imageAssetPath,title, desc;
  Color colour;
  Slider({this.imageAssetPath,this.title,this.desc, this.colour});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children:<Widget> [
          Container( decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imageAssetPath),
              fit:  BoxFit.cover,
              alignment: Alignment.topCenter,),),),
          Opacity(
            opacity: 0.6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff023047).withOpacity(1),
                  Color(0xff034160).withOpacity(1),
                  Colors.cyan[200],
                  Colors.amber[100]

                ],

                    begin: AlignmentDirectional.topCenter,
                    end: Alignment.bottomCenter),),),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Icon(Icons.map,
                  color: colour,),
                SizedBox(
                  height: 250,
                ),

                Container(
                  padding: EdgeInsets.all(6),
                  height: 35,
                  width: 100,
                  child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
                    color: colour,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(desc,
                  style: TextStyle(color: Colors.white),),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ) ,
        ],
      ),
    );
  }
}



