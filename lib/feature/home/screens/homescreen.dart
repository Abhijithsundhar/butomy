import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbutomy/feature/authentication/screens/authScreen.dart';
import 'package:techbutomy/feature/home/homecontrollor/homecontrollor.dart';
import 'package:techbutomy/feature/home/screens/checkoutpage.dart';
import 'package:techbutomy/feature/home/screens/menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {
  dishList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ref.watch(userStreamProvider).when(data: (data)=>
      DefaultTabController(
      length: 5,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Container(
            height: height * .05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Dish',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            SizedBox(width: width * .03),
          ],
        ),
        drawer: Drawer(
          elevation: 0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(width * .18), // Curve the bottom right corner
                ),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      data.profilePic.isNotEmpty?
                      CircleAvatar(
                        radius: width * .1,
                        backgroundImage:
                        NetworkImage(data.profilePic)
                      ): CircleAvatar(
                        radius: width * .1,
                        backgroundImage:
                        AssetImage('assets/images/profile.png'),
                      ),
                      SizedBox(height: 10.0),
                      data.name.isNotEmpty?
                      Text(
                        data.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ):
                      Text(
                        data.phoneNumber,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  /// logout
                  ref.read(categoryControllerProvider).deleteUser(data,context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => AuthScreen(),));
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children:[
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                /// First section: Taza Kitchen
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            width: width * .2,
                            height: height * .1,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width * .03),
                              child: Image.asset('assets/images/bonda.jpeg', fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Taza Kitchen',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('From Peyad',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: width * .03,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('Member Since Aug 16, 2021',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: width * .025,
                              )),
                          Text('FSSAI NO: 21321137000400',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: width * .025,
                              )),
                          SizedBox(height: height * .01),
                          Text('Know more',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: width * .03,
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * .05, left: width * .15),
                        child: Column(
                          children: [
                            Container(
                              height: height * .035,
                              width: width * .18, // Adjust the height as needed
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width * .04), // Adjust the borderRadius for rounded corners
                                color: Colors.black, // Adjust the background color
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add, color: Colors.white, size: width * .03), // Icon before text
                                  SizedBox(width: width * .01), // Space between icon and text
                                  Text(
                                    'Follow',
                                    style: TextStyle(color: Colors.white, fontSize: width * .03),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              children: [
                                Text(
                                  '4.6',
                                  style: TextStyle(
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.star, size: width * .04, color: Colors.yellow.shade700),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * .05,
                  width: width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('14',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: width * .035,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(' Posts ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * .035,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text('37',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: width * .035,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(' Followers ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: width * .035,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
               SizedBox(height: height*.02,),
                /// TabBar section
                Container(
                  height: height*.06,
                  color: Colors.grey.shade300,
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.yellow.shade600, // Set the background color of the selected tab
                      // borderRadius: BorderRadius.circular(10), // Optional: Add some border radius for rounded corners
                    ),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.grey
                    ,
                    tabs: [
                      Tab(
                          icon: Container(
                            width: width*.7,
                            child: Column(
                              children: [
                            Icon(Icons.list),
                            Text('Wall')
                                                  ],
                                                ),
                          )),
                      Tab(icon: Container(width: width*.7,
                        child: Column(
                          children: [
                            Icon(Icons.restaurant_menu),
                            Text('Menu')
                          ],
                        ),
                      )),
                      Tab(icon: Container(
                        width: width*.7,
                        child: Column(
                          children: [
                            Icon(Icons.videocam),
                            Text('Videos')
                          ],
                        ),
                      )),
                      Tab(icon: Container(
                        width: width*.7,
                        child: Column(
                          children: [
                            Icon(Icons.star),
                            Text('Reviews',style: TextStyle(fontSize: width*.032),)
                          ],
                        ),
                      )),
                      Tab(icon: Container(
                        width: width*.7,
                        child: Column(
                          children: [
                            Icon(Icons.book),
                            Text('Blog')
                          ],
                        ),
                      )),
                    ],
                  ),
                ),

                /// TabBarView section
                Container(
                  height: height, // Adjust the height as needed
                  child: TabBarView(
                    children: [
                      // Content for each tab
                      Center(child: Text('List View Content')),
                      Menu (),
                      Center(child: Text('Video Content')),
                      Center(child: Text('Star Content')),
                      Center(child: Text('Book Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
            Positioned(
              bottom: height * .03,
              right: width * .35,
              child: GestureDetector(
                /// Browse menu
                child: Container(
                  height: height * .035,
                  width: width * .3, // Adjust the height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * .04), // Adjust the borderRadius for rounded corners
                    color: Colors.black, // Adjust the background color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu, color: Colors.white, size: width * .03), // Icon before text
                      SizedBox(width: width * .01), // Space between icon and text
                      Text(
                        'Browse Menu',
                        style: TextStyle(color: Colors.white, fontSize: width * .03),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
          bottomNavigationBar:SizedBox(
            height: height*.05,
            child: BottomAppBar(
              color: Colors.teal.shade300,
              child: Row(
                children: [
                  SizedBox(width: width*.03,),
                  Expanded(
                    child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return ref.watch(dataProvider).when(
                              data: (data){
                                if(data !=null){
                                  final result=data;
                                  return dishList.length !=0?Text('${ (dishList.length-1).toString()}'
                                      ' Items', style: TextStyle(fontSize: 18)):Text('0 Items');
                                }
                              else{
                                return Text('0');
                                }
                              },error: (error, stackTrace) {
                            print(error.toString());
                            print(stackTrace);
                            return Scaffold(body: Center(child: Text("data")),);
                          },loading: () =>  Scaffold(body: Center(child: CircularProgressIndicator()),),);
                        },
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => CheckOutPage(dish: dishList,),));
                    },
                    child:  Row(
                      children: [
                        Text('Add to Cart', style: TextStyle(fontSize: width*.04)),
                        SizedBox(width:  width*.01),
                        Icon(Icons.shopping_cart,size: width*.05 ),
                      ],
                    ),
                  ),
                  SizedBox(width: width*.03,),
                ],
              ),
            ),
          )
      ),
    ),
      error: (error, stackTrace) {
        print(error.toString());
        print(stackTrace);
        return Scaffold(body: Center(child: Text("data")),);
      }, loading: () =>  Scaffold(body: Center(child: CircularProgressIndicator()),),);
  }
}
