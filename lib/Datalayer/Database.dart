import 'package:edu_app/Datalayer/paperMarks.dart';
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

  Future<bool> checknewUser(uid) async {
    var document = firebaseReference.collection('users').document(uid);
    bool isnew;
    await document.get().then((userSnapshot) {
      if (userSnapshot.exists) {
        isnew = false;
      } else {
        isnew = true;
      }
    });
    return isnew;
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
          f.data['registerDate'],
        );
        list.add(user);
      });
    });
    return list;
  }

  Future<List> getLBUsers() async {
    List list = new List<LBUser>();
    await firebaseReference
        .collection('leaderboard')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        LBUser lbuser = new LBUser(
          f.data['name'],
          f.documentID,
          f.data['score'],
        );
        list.add(lbuser);
      });
    });
    return list;
  }

  Future<LBUser> getmyScore(number) async {
    var doc = firebaseReference.collection('leaderboard').document(number);
    LBUser user;
    await doc.get().then((userSnapshot) {
      if (userSnapshot.exists) {
        user = LBUser(
          userSnapshot.data['name'],
          userSnapshot.documentID,
          userSnapshot.data['score'],
        );
      } else {
        user = null;
      }
    });
    return user;
  }

//to get user details
  Future<User> getUserDetails(currentUser) async {
    var document = firebaseReference.collection('users').document(currentUser);
    await document.get().then((userSnapshot) {
      if (userSnapshot.exists) {
        User user = User(
          userSnapshot.data['name'],
          userSnapshot.data['number'],
          userSnapshot.data['registerDate'],
        );
        return user;
      } else {
        return null;
      }
    });
    return null;
  }

//add new users to firebase
  Future<void> addUser(uid, name, number) async {
    var now = new DateTime.now();
    await firebaseReference.collection("users").document(uid).setData(
      {
        "name": '$name',
        "number": number,
        "registerDate": now,
      },
    );
    await firebaseReference.collection("leaderboard").document(number).setData(
      {
        "name": '$name',
        "score": 0,
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
          await firebaseReference
              .collection("leaderboard")
              .document(user)
              .updateData({'score': marks});
        } else {
          int marks = correct;
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
    bool _bool;
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
    return _bool;
  }

  Future<List<PaperMarks>> getPaperMarks(user) async {
    List list = new List<PaperMarks>();
    await firebaseReference
        .collection('users')
        .document(user)
        .collection('Papers')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        PaperMarks paper = PaperMarks(
          f.data['correct_answers'],
          f.documentID,
        );
        list.add(paper);
      });
    });
    return list;
  }

//this function doesn't retrieve given answers
  Future<List<DBMarks>> getResult(user) async {
    List list = new List<DBMarks>();
    await firebaseReference
        .collection('users')
        .document(user)
        .collection('Papers')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        DBMarks paper = DBMarks(
          id: f.documentID,
          marks: f.data['correct_answers'],
          ans: null,
          upload: 1,
        );
        list.add(paper);
      });
    });
    return list;
  }

  Future<bool> checkUsername(name) async {
    var documents = firebaseReference.collection('users').getDocuments();
    bool isUnique = true;
    await documents.then((snapshot) {
      snapshot.documents.forEach((f) {
        if (f.data['name'] == name.trim()) {
          isUnique = false;
        }
      });
    });
    return isUnique;
  }
}
