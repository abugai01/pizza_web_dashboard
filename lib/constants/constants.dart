import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:google_maps_webservice/places.dart';

//TODO: почему-то сохранение этого фалйика убивает vs code. Мб поможет разделить константы и инстансы
const GOOGLE_MAPS_API_KEY = "AIzaSyBZtKBOqC4obPzXVq4kIo9eRuX_9AcYglA";
const COUNTRY = "ru";
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFunctions functions = FirebaseFunctions.instance;
//FirebaseMessaging fcm = FirebaseMessaging.instance;
//GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

const String executorAvatarsStoragePath = 'executorAvatars/';

const String noDataValue = '';


const imagesPath = 'assets/images/';
const iconsPath = 'assets/icons/';

const String imgPathUser = 'images/user.png';
const String imgPathExecutor = 'images/executor.png';
const String imgPathPet = 'images/pet.png';

const String iconPathExecutor = 'icons/executor.png';
const String imagePlaceholderPath = imagesPath + 'placeholder.png';
const String iconPlaceHolderPath = iconsPath + 'pet.png';
