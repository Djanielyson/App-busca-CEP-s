import 'package:app_busca/enderecos_list_view_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enderecos_list_view_page.dart';

class BuscaEnderecosPage extends StatefulWidget {
  @override
  _BuscaEnderecosPageState createState() => _BuscaEnderecosPageState();
}

class _BuscaEnderecosPageState extends State<BuscaEnderecosPage> {

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController _estado = TextEditingController();
  TextEditingController _logradouro = TextEditingController();
  // String estado = "";
  // String logradouro = "";
  String _estadoselecionada = "MG";
  List<String> _estados = ["MG", "PB", "SP"];
  bool load = false;

  void _resetFields() {
    setState(() {
      _estado.text = "";
      _logradouro.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!load) {
      load = true;
      _loadDados();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Busca CEP",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _resetFields,
          )
        ],
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Text(
              "Selecione um estado",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _estadoselecionada,
              items: _estados.map((estado) => DropdownMenuItem(
                        child: Text(
                          estado,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: estado,
                      ))
                  .toList(),
              onChanged: (value) {
                print(value);
                setState(() {
                  _estadoselecionada = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Digite uma estado",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _estado,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                // labelText: "estado",
                suffixIcon: Icon(
                  Icons.location_city,
                  color: Colors.deepPurple,
                ),
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Campo não pode ser vazio!";
                } else if (value.length <= 3) {
                  return "O campo precisa ter mais de três letras...";
                }
                return null;
              },
              onSaved: (value) {
                _estado.text = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Digite um logradouro",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _logradouro,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.add_road,
                  color: Colors.deepPurple,
                ),
                // labelText: "Logradouro",
                labelStyle: TextStyle(color: Colors.deepPurple),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Campo não pode ser vazio!";
                } else if (value.length <= 3) {
                  return "O campo precisa ter mais de três letras...";
                }
                return null;
              },
              onSaved: (value) {
                _logradouro.text = value;
              },
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.search,
                color: Colors.deepPurple,
              ),
              label: Text(
                "Buscar",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _validar();
                _salvar();
                if (_validar()) {
                  Navigator.push(context,new MaterialPageRoute(builder: (context) => EnderecosListViewPage(
                              _estadoselecionada,
                              _estado.text,
                              _logradouro.text)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _validar() {
    if (_keyForm.currentState.validate()) {
      _keyForm.currentState.save();
    }
    return _keyForm.currentState.validate();
  }

  _salvar() async {
    SharedPreferences instancia = await SharedPreferences.getInstance();
    instancia.setString("key-estados", _estadoselecionada);
    instancia.setString("key-estado", _estado.text);
    instancia.setString("key-logradouro", _logradouro.text);
    print(" salvo");
  }

  _loadDados() async {
    SharedPreferences instancia = await SharedPreferences.getInstance();

    String valorStringestado = instancia.getString("key-estado");
    String valorStringLogradoro = instancia.getString("key-logradouro");
    String estado = instancia.getString("key-estados");
    _estado.text = valorStringestado;
    _logradouro.text = valorStringLogradoro;

    setState(() {
      _estadoselecionada = estado;
    });
    print(valorStringLogradoro);
    print(valorStringestado);
    print(estado);
  }
}
