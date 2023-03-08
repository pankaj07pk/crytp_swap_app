import 'dart:convert';
import 'dart:developer';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slider_button/slider_button.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Swap Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _activeTab = "SLIPPAGE";
  double _currentSliderValue = 5;

  var jsonCrypto;

  Map dataOption1 = {
        "name":"Ethereum",
        "code":"ETH",
        "price":"127868.75",
        "coin":"145",
        "icon":"https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png"
    };
  Map dataOption2 = {
        "name":"DAI",
        "code":"DAI",
        "price":"82.03",
        "coin":"15874",
        "icon":"https://s2.coinmarketcap.com/static/img/coins/64x64/4943.png"
    };

  var detailsRate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCryptoList();
  }

  getCryptoList () async{
    final String response = await rootBundle.loadString('assets/json/crypto.json');
    jsonCrypto = await json.decode(response);
    print(jsonCrypto);

    // dataOption1 = jsonCrypto[1];
    // dataOption2 = jsonCrypto[10];

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF111013),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        body: Container(
          color: Color(0xFF1E1E1E),
          height: size.height,
            width: double.infinity,
          padding: EdgeInsets.only(top: 42,left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                child: Text('Swap ETH',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold')),
              ),
              SizedBox(height: 18),
              Container(
                child: Text('Ethereum Mainnet',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular')),
              ),
              SizedBox(height: 44),
              Container(
                child: Stack(
                  children: [
                    Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.25), // Set border color
                    width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0)
                  ),
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: CachedNetworkImage(
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  imageUrl: dataOption1['icon'].toString(),
                                  fit: BoxFit.fitWidth,
                                  width: 39,
                                ),
                        ),
                        SizedBox(width: 10),
                        Text("${dataOption1['code']}",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Inter-Black')),
                        // SizedBox(width: 1.39),
                        IconButton(
                          onPressed: () => {
                            BottomSheetList(context,"option1")
                          }, 
                          icon: Icon(Icons.keyboard_arrow_down)
                        ),
                        Spacer(),
                        Container(
                          transformAlignment: AlignmentDirectional.centerEnd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("${dataOption1['coin']}",style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Inter-Black')),
                              Text("\u{20B9} ${dataOption1['price']}",textAlign: TextAlign.end,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.normal)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 23),
                    Container(
                      child: Text("Balance 0",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.normal)),
                    )
                  ],
                ),
              ),
              
              SizedBox(height: 6),
              //Second options
              Container(
                margin: EdgeInsets.only(top: 120),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF262D34), // Set border color
                    width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0)
                  ),
                  color: Color(0xFF262D34),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: CachedNetworkImage(
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  imageUrl: dataOption2['icon'].toString(),
                                  fit: BoxFit.fitWidth,
                                  width: 39,
                                ),
                        ),
                        SizedBox(width: 10),
                        Text("${dataOption2['code']}",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Inter-Black')),
                        IconButton(
                          onPressed: () => {
                            BottomSheetList(context,"option2")
                          }, 
                          icon: Icon(Icons.keyboard_arrow_down)
                        ),
                        Spacer(),
                        Container(
                          child: Icon(Icons.circle_outlined,color: Color(0xFF37CBFA)),
                        )
                      ],
                    ),
                    SizedBox(height: 23),
                    Container(
                      child: Text("Balance 0",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: swapCrypto,
                  child: Container(
                    margin: EdgeInsets.only(top: 90,right: 150),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0)
                    ),
                    color: Color(0xFF2B93B5)
                  ),
                    child: Image.asset("assets/images/up-and-down.png",width: 20),
                  ),
                ),
              ),
                  ],
                ),
              ),
              SizedBox(height: 140),
              //Two Tabs
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          _activeTab = "SLIPPAGE";
                        })
                      },
                      child: Text("SLIPPAGE",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular',
                      decoration: _activeTab == "SLIPPAGE" ? TextDecoration.underline : TextDecoration.none,decorationColor: Color(0xFF37CBFA),decorationThickness: 5))
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          _activeTab = "DETAILS";
                        })
                      },
                      child: Text("DETAILS",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular',
                      decoration: _activeTab == "DETAILS" ? TextDecoration.underline : TextDecoration.none,decorationColor: Color(0xFF37CBFA),decorationThickness: 5))
                    )
                  ],
                ),
              ),
              SizedBox(height: 19),
              //Details Tabs
              _activeTab == "DETAILS" ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0)
                  ),
                  color: Color(0xFF191B1F).withOpacity(0.44),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Rate",style: TextStyle(fontSize: 17,color: Color(0xFF878787),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold')),
                        Spacer(),
                        Text("${detailsRate.toString()}",style: TextStyle(fontSize: 17,color: Color(0xFFD9D9D9),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold'))
                      ],
                    ),
                    SizedBox(height: 19),
                    Row(
                      children: [
                        Text("Slippage tolerance",style: TextStyle(fontSize: 17,color: Color(0xFF878787),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold')),
                        Spacer(),
                        Text("${_currentSliderValue.toString()} %",style: TextStyle(fontSize: 17,color: Color(0xFFD9D9D9),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold'))
                      ],
                    ),
                    SizedBox(height: 19),
                    Row(
                      children: [
                        Text("Estimated Fees",style: TextStyle(fontSize: 17,color: Color(0xFF878787),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold')),
                        Spacer(),
                        Text("0.076 ETH",style: TextStyle(fontSize: 17,color: Color(0xFFD9D9D9),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold'))
                      ],
                    ),
                    SizedBox(height: 19)
                  ],
                ),
              ) : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0)
                  ),
                  color: Color(0xFF191B1F).withOpacity(0.44),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Slider(
                        activeColor: Color(0xFF37CBFA),
                        value: _currentSliderValue,
                        max: 5,
                        divisions: 5,
                        label: _currentSliderValue.round().toString() + '%',
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 29),
                    Text("done",textAlign: TextAlign.end,style: TextStyle(fontSize: 13, color: Color(0xFF37CBFA),fontWeight: FontWeight.w600,fontFamily: 'Inter-SemiBold'))
                  ],
                ),
              ),
              SizedBox(height: 48),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF3E4355), // Set border color
                    width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(69.0)
                  ),
                ),
                child: SliderButton(
                  action: () {
                    print("Checked");
                  },
                  label: Text("Slide to pay",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w300,fontFamily: 'Inter-Regular')),
                  icon: Icon(Icons.check,color: Colors.black),
                  width: size.width * 0.7,
                  buttonColor: Color(0xff37CBFA),
                  backgroundColor: Color(0xff1E1E1E),
                )
              )
            ],
          ),
        ),
      )
    );
  }

  Future<void> BottomSheetList(BuildContext context, String option) {
    return showModalBottomSheet<void>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical( 
                top: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 576,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(24.0),topRight: Radius.circular(24.0)),
                  color: Color(0xFF222529)
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Select an asset",style: TextStyle(fontSize: 20,color: Color(0xffFFFFFF),fontWeight: FontWeight.w500,fontFamily: 'Inter-Medium')),
                            Spacer(),
                            IconButton(onPressed: () => {
                              Navigator.pop(context)
                            }, icon: Icon(Icons.close,color: Color(0xffFFFFFF),))
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xff656565)
                          ),
                          
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              prefixIcon: Icon(Icons.search,color: Color(0xff656565),),
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 14.0, color: Color(0xff656565),fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular'),
                              filled: true,
                              fillColor: Color(0xff111013),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff111013), width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff111013), width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)
                              )
                            )
                          ),
                      ),
                      SizedBox(height: 30),
                      Text("Popular tokens",style: TextStyle(fontSize: 16,color: Color(0xffFFFFFF),fontWeight: FontWeight.w300,fontFamily: 'Inter-Light-BETA')),
                      SizedBox(height: 20),
                      //Crypto List
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: jsonCrypto.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 15),
                                child: InkWell(
                                  onTap: () => {
                                    if(option == "option1"){
                                      setState(() {
                                        dataOption1 = jsonCrypto[index];
                                      })
                                    },

                                    if(option == "option2"){
                                      setState(() {
                                        dataOption2 = jsonCrypto[index];
                                      })
                                    },

                                    Navigator.pop(context)
                                  },
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        placeholder: (context, url) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        imageUrl: jsonCrypto[index]['icon'],
                                        fit: BoxFit.fitWidth,
                                        width: 40,
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${jsonCrypto[index]['name']}",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular')),
                                          Text("${jsonCrypto[index]['code']}",style: TextStyle(fontSize: 11,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular'))
                                        ],
                                      ),
                                      Spacer(),
                                      Text("₹ ${jsonCrypto[index]['price']}",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400,fontFamily: 'Inter-Regular'))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }


  Future<void> swapCrypto() async {
    try{

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Container(
            color: Color(0xff262D34),
            child: Center(
              child: CircularProgressIndicator(),
            )
          )
      );

      print("Swap Call");
      var amount = dataOption2['coin'];
      var buyToken = dataOption2['code'];
      var sellToken = dataOption1['code'];

      // print(amount * pow(10, 18));
      // var sellAmount = amount * pow(10, 18);
      
      print("Swap Call 2");
      // sellAmount = sellAmount.toInt().toString();
    //This fetch is just a simple api call with query parameters as Selling token, Buying Token and the amount to exchange
      Map<String, String> check_allowance_query_params = {
        'sellToken': sellToken,
        'buyToken': buyToken,
        'sellAmount': "1000000000000000000"
      };

      var response = await http.get(
          Uri.parse('https://api.0x.org/swap/v1/quote?buyToken=${buyToken}&sellToken=${sellToken}&sellAmount=1000000000000000000'));
      
      var data;
      try {
        if (response.statusCode == 200) {
          data = jsonDecode(response.body);
          // var buyAmount = double.parse(data['buyAmount']) / math.pow(10, 18);
          // Fluttertoast.showToast(msg: "Crytp Swaped");
            print("Response");
            print(response.body);
            var sellPrice = double.parse(dataOption1['price']);
            assert(sellPrice is double);

            var buyPrice = double.parse(dataOption2['price']);
            assert(buyPrice is double);

            print(sellPrice);
            print(buyPrice);
            setState(() {
              _activeTab = "DETAILS";
              detailsRate = "1 ${dataOption1['code']} = " + (sellPrice / buyPrice).toStringAsExponential(2).toString() + " ${dataOption2['code']}";
            });
            Navigator.pop(context);
        } else {
          Navigator.pop(context);
          var data = jsonDecode(response.body);
          return data;
        }
      } catch (e) {
        // Fluttertoast.showToast(msg: e.toString());
        print(e);
        Navigator.pop(context);
      }

    }catch(e){
      print(e);
      Navigator.pop(context);
    }
  }


}
