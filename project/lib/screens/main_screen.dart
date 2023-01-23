import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/screens/second_screen.dart';
import 'package:project/service/api_service.dart';
import 'package:project/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Main Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: FutureBuilder(
          future: ReqresAPI().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('${snapshot.data?.data?[index].avatar}'),
                    ),
                    title: Text(
                        '${snapshot.data?.data?[index].firstName} ${snapshot.data?.data?[index].lastName}'),
                    subtitle: Text('${snapshot.data?.data?[index].email}'),
                    onTap: () {
                      var id = snapshot.data!.data![index].id!;
                      mainViewModel.getUserById(id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SecondScreen(
                              id: id,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.blueGrey,
                    thickness: 0.5,
                  );
                },
                itemCount: snapshot.data!.data!.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
