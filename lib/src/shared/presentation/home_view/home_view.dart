import 'package:flutter/material.dart';
import 'package:movarr/src/feature/messages/data/models/messages_model.dart';
import 'package:movarr/src/feature/messages/data/repository/messages_repositoy_impl.dart';
import 'package:movarr/src/feature/messages/data/services/message_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Message>>(
          future: MessageServices().getAllMessages(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(index.toString()),
                      title: Text(snapshot.data![index].address.toString()),
                      subtitle: Text(snapshot.data![index].body.toString()),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
