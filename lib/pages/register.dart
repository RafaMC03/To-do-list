import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'HomePage.dart';

final controlleratv = TextEditingController();
final controllerDesc = TextEditingController();

class Register extends StatefulWidget {
  Register({super.key, this.edit});
  User? edit;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    if (widget.edit != null) {
      print(widget.edit!.id);
      controlleratv.text = widget.edit!.atv;
      controllerDesc.text = widget.edit!.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro/Atualização'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 150),
              child: Text(
                'Gerencie sua a atividade:',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: formcomp(
                text: 'Digite a atividade:',
                type: TextInputType.text,
                controller: controlleratv),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 40,
            thickness: 1,
            indent: 30,
            endIndent: 30,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: formcomp(
                text: 'Digite a descrição:',
                type: TextInputType.text,
                controller: controllerDesc),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: () {
                    final atv = controlleratv.text;
                    createUser(atv: atv);

                    controllerDesc.text = '';
                    controlleratv.text = '';

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 30),
                    onPrimary: Colors.black,
                    elevation: 15,
                    shadowColor: Colors.black,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.edit != null) {
                      Map<String, String> dataToUpdate = {
                        'atv': controlleratv.text,
                        'desc': controllerDesc.text,
                      };
                      final docUser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.edit!.id);

                      docUser.update(dataToUpdate);

                      controllerDesc.text = '';
                      controlleratv.text = '';
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 30),
                    onPrimary: Colors.black,
                    elevation: 15,
                    shadowColor: Colors.black,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )
        ],
      ),
    );
  }

  Future createUser({required String atv}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final user = User(id: docUser.id, atv, controllerDesc.text);
    final json = user.toJson();

    await docUser.set(json);
  }
}

Widget formcomp(
    {String? text,
    TextEditingController? controller,
    TextInputType type = TextInputType.text}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(label: Text(text ?? "Digite um valor")),
  );
}
