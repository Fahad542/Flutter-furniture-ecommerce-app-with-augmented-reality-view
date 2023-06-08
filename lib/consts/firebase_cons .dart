import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mart/controllers/product_controller.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const usersCollection = 'users';
const ProductsCollection = 'Products';
const cartcollection = 'cart';
const chatscollection = 'chats';
const messageCollection = 'messages';
const orderscollection = 'orders';
