# boatusers

A new Flutter project.

# Commands to Run

# To initialize the dependencies, flutter sdk and dart tools

flutter pub get

# To run the app on Chrome and using the Chrome devtools

flutter run -d chrome

# This app is used to be non-nullable with the sdk version of flutter beta to be compatible with flutter_redux and flutter_thunk

# Android Implementation

if In Linux:
In VirtualBox => Virtual Machine => System, Processor => Enable vtx-amd-v

in Host Machine: Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true

Install an emulator from AndroidStudio and Create Device => Download a device package

Specify JAVA Path
In Linux:

export JAVA_HOME=/usr/local/andoid/studio/jre

flutter clean
flutter pub get
flutter build apk --debug --verbose

cd android
./gradlew assembleDebug --stacktrace

Running Server and Client;

cd server => npm run dev-device

Http Url is always http:10.0.2.2:3000

# Web Implementation

Running Server and Client :

cd to server => npm run dev-web

Http Url is your ip address:

Run ifconfig in linux and ipconfig in windows to get your machine IP address

Example of a Machine IP is 172.17.0.1:3000
