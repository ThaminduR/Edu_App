import 'package:edu_app/Datalayer/paperShowcase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/Datalayer/user.dart';

class Firebase {
  // Access a Cloud Firestore instance from your Activity
  final firebaseReference = Firestore.instance;
  static Firebase firebase;

  static Firebase getdb() {
    if (firebase == null) {
      firebase = Firebase();
    }
    return firebase;
  }

//fetch currently posted papers from Firebase
  Future<List> getPapers() async {
    List list = new List<PaperShowcase>();
    await firebaseReference
        .collection("papers")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        PaperShowcase paper = new PaperShowcase(
          id: f.data['id'],
          url: f.data['url'],
          name: f.data['name'],
          number: f.data['number'],
          hTime: f.data['hTime'],
          mTime: f.data['mTime'],
        );
        list.add(paper);
      });
    });
    return list;
  }

  Future<List> getUsers() async {
    List list = new List<User>();
    await firebaseReference
        .collection('users')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        User user = new User(
          f.data['name'],
          f.data['number'],
        );
        list.add(user);
      });
    });
    return list;
  }

//to get user details
  Future<User> getUserDetails(currentUser) async {
    var document = firebaseReference.collection('users').document(currentUser);
    await document.get().then((userSnapshot) {
      if (userSnapshot.exists) {
        User user = User(
          userSnapshot.data['name'],
          userSnapshot.data['number'],
          //userSnapshot.data['register_date'],
          //userSnapshot.data['total_score'],
        );
        return user;
      } else {
        return null;
      }
    });
    return null;
  }

//add new users to firebase
  Future<void> addUser(name, number) async {
    await firebaseReference.collection("users").document(number).setData(
      {
        "name": '$name',
        "number": number,
      },
    );
  }

//upload the answers and paper details to Firebase
  Future<void> uploadAnswers(user, paper, answers, correct) async {
    Map<dynamic, dynamic> data =
        answers.map((k, v) => MapEntry(k.toString(), v));
    await firebaseReference
        .collection("users")
        .document(user)
        .collection("Papers")
        .document(paper.id)
        .setData({
      "paper_name": 'Paper ${paper.id}',
      "paper_URL": paper.url,
      "answers": data,
      "correct_answers": correct,
    });
  }

//Update leaderboard with paper marks. This is used by a paper object fucntion
  void updateLeaderboard(user, correct) async {
    var document = firebaseReference.collection('leaderboard').document(user);
    await document.get().then(
      (userScore) async {
        if (userScore.exists) {
          int marks = userScore['score'];
          marks += correct;
          print(userScore);
          print(marks);
          await firebaseReference
              .collection("leaderboard")
              .document(user)
              .updateData({'score': marks});
        } else {
          int marks = correct;
          print(marks);
          await firebaseReference
              .collection("leaderboard")
              .document(user)
              .setData({'score': marks});
        }
      },
    );
  }

//check if the user is trying paper for the first time.
  Future<bool> firstTime(user, paperid) async {
    bool _bool = false;
    var document = firebaseReference
        .collection('users')
        .document(user)
        .collection("Papers")
        .document(paperid);
    await document.get().then((paper) {
      if (paper.exists) {
        _bool = false;
      } else {
        _bool = true;
      }
    });
    return _bool; //unreachable
  }
}
