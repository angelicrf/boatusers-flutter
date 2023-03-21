import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainWidgets {
  MainWidgets();
  List<Widget> thisW(
          BuildContext context,
          TextEditingController buserNameController,
          TextEditingController buPasswordController,
          int _buCount,
          VoidCallback _SubmitInputs,
          VoidCallback _onFetchPostsPressed) =>
      [
        Text(
          'User Info',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'User Name',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: buserNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter User Name',
            ),
          ),
        ),
        Text(
          'Password',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '$_buCount',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: buPasswordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: FloatingActionButton(
            onPressed: _SubmitInputs,
            tooltip: 'Enter',
            child: const Icon(Icons.send),
            //style:FloatingActionButtonLocation.startFloat
          ),
          //,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: FloatingActionButton(
            onPressed: _onFetchPostsPressed,
            heroTag: null,
            tooltip: 'Get Data',
            child: const Icon(Icons.get_app),
          ),
          //,
        )
      ];
}
