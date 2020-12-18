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
  int currentIndex=4;
  PageController controller= new PageController(initialPage: 4);
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
        color: isCurrent? Color(0xff961c00): Colors.grey[700],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Stack(
          children: <Widget>[

            PageView.builder(
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
                  colour: Color(0xff023047),

                );
              },),

          currentIndex != slide.length - slide.length?
            Column( crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    controller.animateToPage(slide.length-slide.length, duration:  Duration(milliseconds: 400), curve: Curves.linear);
                  },
                  color: Colors.transparent,
                  child: Text("تخطي",
                    style: TextStyle(
                      color:Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),),
                SizedBox(height: 495,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child:
                      Material( color: Colors.transparent
                          ,child: IconButton(
                            icon: Icon(Icons.navigate_before, color: Color(0xff023047),),

                            iconSize: 40,
                            onPressed: () {
                              controller.animateToPage(currentIndex - 1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            },
                          )),
                    ),
                    SizedBox(width: 90,),
                    Row(
                      children: <Widget>[
                        for(int i = 0; i < slide.length; i++) currentIndex == i ?
                        pageIndexIndicator(true, i) : pageIndexIndicator(false, i),
                      ],
                    ),
                    SizedBox(width: 50,),
                    FlatButton(
                      onPressed: (){},
                      color: Colors.transparent,
                      child: Text("تسجيل دخول",
                        style: TextStyle(
                          color: Color(0xff023047),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),),
                  ],
                ),
              ],
            ) : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        child: Text("تسجيل دخول",
                          style: TextStyle(
                            color: Color(0xff023047),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),),
                    ) ] ),


          ],),
    ]),);
  }
}

class Slider extends StatelessWidget {
  String imageAssetPath,title, desc;
  Color colour;
  Slider({this.imageAssetPath,this.title,this.desc, this.colour});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        type:MaterialType.transparency,
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
                    Colors.white,

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
                    padding: EdgeInsets.all(8),
                    height: 35,
                    width: 100,
                    child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
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
                    style: TextStyle(color: Colors.white, fontSize: 20,),textAlign: TextAlign.center,),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}



