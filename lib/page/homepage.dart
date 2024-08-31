import 'dart:convert';
//import 'dart:js';
import 'package:ebook/page/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:ebook/page/app_colors.dart' as AppColor;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
   late List popularBook;
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBook.json").then((s) {
      setState(() {
        popularBook = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }
  @override
  void initState(){
    super.initState();
    _tabController=TabController(length: (3), vsync: this);
    _scrollController=ScrollController();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
        child: Scaffold(
          body:Column(
            children: [
              Container(
          margin: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Icon(Icons.menu,
            size: 34,
            color: Colors.black,
          ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Icon(Icons.notifications),
                    ],
                  ),
                ],
              ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text("Popular Books",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top:0,
                        left: -20,
                    right: 0,
                        child:Container(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction:1),
                              itemCount: popularBook==null?0:popularBook.length,
                              itemBuilder: (_, i){
                                return Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(popularBook[i]["img"]),
                                        fit: BoxFit.contain,
                                      )
                                  ),
                                );
                              }),
                        )
                    )
                  ],
                ),
              ),

              Expanded(child: NestedScrollView(
                  controller: _scrollController,
                    headerSliverBuilder: (BuildContext context, bool isScroll){
                          return[
                            SliverAppBar(
                              pinned: true,
                              backgroundColor:AppColor.sliverBackground,
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(50),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 10),
                                  child: TabBar(
                                    indicatorPadding: const EdgeInsets.all(0),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelPadding: const EdgeInsets.only(right: 10),
                                    controller: _tabController,
                                    isScrollable: true,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(0,0),
                                          blurRadius: 7,
                                        )
                                      ]
                                    ),
                                          tabs: [
                                           AppTab(color: AppColor.menu1Color, text: "New"),
                                            AppTab(color: AppColor.menu2Color, text: "Popular"),
                                            AppTab(color: AppColor.menu3Color, text: "Trending")
                                            ],
                                  ),
                                ),
                              ),
                            )
                          ];
                    },
                body:TabBarView(
                  controller: _tabController,
                  children: [
                  ListView.builder(
                      itemCount: books==null?0:books.length,
                      itemBuilder: (_,i){
                    return Container(
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.tabVarViewColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0,0),
                              color: Colors.grey.withOpacity(0.2),
                            )
                          ]
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(books[i]["img"]),
                                    )
                              ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                        size: 24,
                                        color: AppColor.starColor),
                                      SizedBox(width: 5),
                                      Text(books[i]["rating"],
                                        style: TextStyle(
                                        color: AppColor.menu2Color
                                      ),),
                                      
                                    ],
                                  ),
                                  Text(books[i]["title"],style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Text(books[i]["text"],style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Avenir",
                                  color: AppColor.subTitleText,
                                  ),),
                                  Container(
                                    width: 60,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColor.loveColor,
                                    ),
                                    child: Text("Love",style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Avenir",
                                      color: Colors.white,
                                    ),),
                                    alignment: Alignment.center,
                                  )


                                ],
                              )

                            ],
                          ),

                        ),
                      ),
                    );
                  }),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                  ],
                ) ,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

