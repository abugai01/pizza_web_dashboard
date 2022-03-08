import 'package:flutter/material.dart';
import 'package:pizza_web_dashboard/models/user.dart';
import 'package:pizza_web_dashboard/pages/individual_pages/widgets/user_orders_table.dart';
import 'package:pizza_web_dashboard/widgets/custom_text.dart';

//TODO: nice profile page design
//https://slcoderlk.blogspot.com/2019/01/beautiful-user-profile-material-ui-with.html
//TODO: не дефолтная картинка с сбоакой!!!

//TODO: предохраняться на случай отсутсвующих полей в модели данных

//TODO: навести тут порядок!!!! полный разнос

enum IndividualPageType { Pet, User, Executor }

class SamplePage extends StatefulWidget {
  final Object data;

  SamplePage(this.data);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  // final String _fullName = "Nick Frost";
  // final String _status = "Software Developer";
  // final String _bio =
  //     "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  // final String _followers = "173";
  // final String _posts = "24";
  // final String _scores = "450";

  String? _fullName;
  String? _status;
  String? _bio;
  String? _followers;
  String? _posts;
  String? _scores;

  IndividualPageType pageType = IndividualPageType.User; //TODO: сделать норм

  var data;

  @override
  void initState() {
    super.initState();

    //TODO: вынести в отдельную функцию, убрать дублирование
    if (widget.data.runtimeType == User) {
      User _data = widget.data as User;
      data = _data;
      pageType = IndividualPageType.User;

      //TODO: null safety
      _fullName = _data.name;
      _status = _data.email;
      _bio = _data.phone;
      //TODO: заменить на переменные
      _followers = "173";
      _posts = "24";
      _scores = "450";
    } else {
      //TODO: обрабатывать нормально ошбику
      _fullName = "";
      _status = "";
      _bio = "";
      _followers = "";
      _posts = "";
      _scores = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    /*
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    */
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          //TODO: возможно здесь лучше будет Stack
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: IconButton(
          //         onPressed: () {
          //           //navigationController.goBack();
          //           //TODO: как попасть назад?
          //         },
          //         icon: Icon(Icons.arrow_back_outlined))),
          SizedBox(height: screenSize.height / 6.4),
          _buildProfileImage(),
          _buildFullName(),
          _buildStatus(context),
          _buildStatContainer(),
          _buildBio(context),
          _buildSeparator(screenSize),
          SizedBox(height: 10.0),
          _buildGetInTouch(context),
          SizedBox(height: 8.0),
          _buildButtons(),
          () {
            if (pageType == IndividualPageType.User) {
              return Column(children: <Widget>[
                //todo: column needed here?
                UserOrdersTable(data),
              ]);
            } else if (pageType == IndividualPageType.Pet) {
              //return buildData(data); //TODO: сделать нормально блок с хозяевами
              return Center(child: Text("в разработке!"));
            } else if (pageType == IndividualPageType.Executor) {
              //return UserPetsTable(data);
              return Container();
            } else {
              return Container();
            }
          }()
        ],
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'data:image/jpeg;base64,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'), // AssetImage('assets/images/nickfrost.jpg'),

            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return CustomText(
      text: _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: CustomText(
        text: _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String? label, String? count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(
          text: count,
          style: _statCountTextStyle,
        ),
        CustomText(
          text: label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: CustomText(
        text: _bio,
        align: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName?.split(" ")[0]},", //TODO: null safety
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: адаптировать не только для PetModel
// FutureBuilder<bool> buildData(Pet data) {
//   return FutureBuilder<bool>(
//       future: data.setUserModel(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting)
//           return CustomText(text: "...");
//         if (snapshot.hasData && snapshot.data != null) {
//           return CustomText(text: data.userModel.name);
//         } else if (snapshot.hasError) {
//           print(snapshot.error.toString());
//           return CustomText(text: noDataValue);
//         } else
//           return CustomText(text: noDataValue);
//       });
// }
