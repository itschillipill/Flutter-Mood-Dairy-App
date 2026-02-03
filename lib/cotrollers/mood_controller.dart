import 'package:flutter/material.dart';

import '../models/mood.dart';

class MoodDiaryController extends ChangeNotifier {
  int _currentIndex = 0;
  Mood? _currentMood;

  double _stress = 0.5;
  double _selfEsteem = 0.5;
  String _notes = '';
  DateTime _date = DateTime.now();

  int? _moodStateIndex;

  int get currentIndex => _currentIndex;
  Mood? get currentMood => _currentMood;
  double get stress => _stress;
  double get selfEsteem => _selfEsteem;
  String get notes => _notes;
  int? get moodStateIndex => _moodStateIndex;
  DateTime get date => _date;

  MoodDiaryController({int initialPage = 0});


  bool validate(){
    return (currentMood!=null && notes.isNotEmpty && (currentMood==Mood.happy?moodStateIndex!=null:true));
  }

  void onTabTapped(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void onPageChanged(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void selectMood(Mood mood) {
    _currentMood = mood;
    _moodStateIndex = null; 
    notifyListeners();
  }

  void setMoodState(int index) {
    _moodStateIndex = index;
    notifyListeners();
  }

  void setStress(double value) {
    _stress = value;
    notifyListeners();
  }

  void setSelfEsteem(double value) {
    _selfEsteem = value;
    notifyListeners();
  }

  void setNotes(String value) {
    _notes = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void save(BuildContext context) async{
    if (validate()) {
    await showDialog(context: context, builder:(context) {
      return AlertDialog(
        title: const Text("Успешно сохранено!"),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
            onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Закрыть"))
        ],
      );
    },);
     debugPrint(
        'Mood: $_currentMood, MoodStateIndex: $_moodStateIndex, Stress: $_stress, SelfEsteem: $_selfEsteem, Notes: $_notes'); 
    }else{
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(const SnackBar(backgroundColor: Colors.orange, content: Text("Заполните все поля!", style: TextStyle(color: Colors.white),)));
    }
    
  }
}