import 'package:flutter/material.dart';
import 'package:segurapp/services/firebase.dart';

import 'create_page.dart';


class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getIncidents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?[index]['cliente']),
                subtitle: Text(snapshot.data?[index]['fecha']??''),
                onTap: () {
                  Navigator.pushNamed(context, '/update', arguments:{
                  snapshot.data?[index]['cliente']??'',
                  snapshot.data?[index]['fecha']??'',
                  snapshot.data?[index]['id']
                  });
                },
              );
            }
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePage(),
              ),
            );
            //Actualizar la lista de incidencias
            setState(() {});
          },
          child: const Icon( Icons.add),
        ),
      );
    }
  }