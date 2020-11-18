import 'package:app_busca/endereco.dart';
import 'package:app_busca/enderecos_api.dart';
import 'package:flutter/material.dart';

class EnderecosListViewPage extends StatelessWidget {
  final String _estado, _cidade, _log;

  EnderecosListViewPage(this._estado, this._cidade, this._log);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("$_cidade , $_estado"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: EnderecosApi.consultarEndereco(_estado, _cidade, _log),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return _buildListViewPost(snapshot.data);
            }
            // else if (snapshot.hasError) {
            //   print("object");
            //   return Text(
            //     "Erro!",
            //     style: TextStyle(
            //       fontSize: 40,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   );
            // }
            return Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 40,
                      ),
                      Text(
                        'Carregando',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                ));
          }),
    );
  }

  ListView _buildListViewPost(List<Endereco> enderecos) {
    return ListView.builder(
      itemCount: enderecos.length,
      itemBuilder: (BuildContext context, int i) {
        return _listTilePost(enderecos, i);
      },
    );
  }

  ListTile _listTilePost(List<Endereco> enderecos, int i) {
    return ListTile(
      title: Text(
        "CEP: " + enderecos[i].cep,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      leading: Icon(
        Icons.home,
        color: Colors.deepPurple,
      ),
      subtitle: Text(
        "Logradouro: " + enderecos[i].logradouro,
      ),
    );
  }
}
