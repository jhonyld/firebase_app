import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void createRecord() async {
    //cria a tabela e seta a Seq como 1
    await db.collection("people").doc("1").set({
      'name': 'Teste',
      'age': '29',
      'birthDate': '01/09/1991',
      'active': 'true'
    });

    //Insere os dados em uma tabela existente
    DocumentReference ref = await db.collection("people").add({
      'name': 'Novo Teste',
      'age': '29',
      'birthDate': '01/09/1991',
      'active': 'true'
    });
  }

  void getData() {
    db.collection("people").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print('${element.data()}');
      });
    });
  }

  void getDataByFilter() {
    db
        .collection("people")
        .where('name', isEqualTo: 'Jhony')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print('${element.data()}');
      });
    });
  }

  void updateData() {
    try {
      db.collection("people").doc("1").update({'birthDate': '01/01/2000'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    db.collection("people").doc("1").delete();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Inserir',
            function: () => createRecord(),
          ),
          CustomButton(
            title: 'Editar',
            function: () => updateData(),
          ),
          CustomButton(
            title: 'Excluir',
            function: () => deleteData(),
          ),
          CustomButton(
            title: 'Listar Todos',
            function: () => getData(),
          ),
          CustomButton(
            title: 'Listar Com Filtro',
            function: () => getDataByFilter(),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.title,
    this.function,
  }) : super(key: key);

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 50,
        child: FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: function,
          child: Text(title),
        ),
      ),
    );
  }
}
