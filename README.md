# flutter_security

A flutter package that aim to take care of your mobile app security side.

### hasBundleBeenCompromised

This feature is available only on `iOs`.

Main concept here is to check the MD5 of the files inside Frameworks (in the main bundle root) folder against a precompiled json.

This json is made with [this script](https://github.com/ziomarco/mobile-security-hashgenerator/releases/tag/v0.0.3). 
My suggestion is to use the crypting feature that uses AES in cbc mode to protect the json.

#### Workflow

This what I do:

* build the app in order to have all the files needed
* copy the [script](https://github.com/ziomarco/mobile-security-hashgenerator/releases/tag/v0.0.3) inside the .app file just builded. 
In this way it can make a file with relative path
* launch the script with all the parameters needed (eg. `./msh-darwin-amd64 generate-map --files Frameworks  --key some_random_key_phrase`)
* check if the `encrypted.json` has been generated inside the .app
* use the package as needed eg. 
```
final result = await FlutterSecurity.hasBundleBeenCompromised(
                   iosSecurityOptions: IosSecurityOptions(
                       bundleId: 'com.example.flutterSecurityExample',
                       jsonFileName: 'encrypted.json',
                       cryptographicKey: 'k4rAN45oL8LxH21wX2nRTDB5o1uYnnrB'),
                 );
```

Then you can use 'result' as you wish (maybe make the app crash in order to stop attacks in progress) 

### amITampered

This feature is a mashup of [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite)
and some stackoverflow helpful posts (that I lost links of) for android implementation.

The anti-tamper feature checks a match between the signature used in the app and the one you send to package as source of truth.

#### Android

To be able to check for anti tampering on Android you need to provide the SHA-1 of the keystore of your app. If you are in debug mode and you didn't make a keystore, a SHA is assigned to your app. Please check your app level `build.gradle`.

#### iOs

To be able to check for anti tampering on iOs you need a little bit more work to be done. As mentioned [here](https://github.com/securing/IOSSecuritySuite/issues/30#issuecomment-769705779) you need to provider your `bundleId` and the hashed value of the `mobile.provision` (a file contained into .ipa builded file):
1. Unzip the .ipa
2. Go into the payload folder, right click on the app, click on `Show Package Contents`
3. You should see the **Unix executable** with my app name (Example, "test" is the name in this case)

Open a terminal and:
1. `otool -l **/path/to/unix/executable**`
2. look for value of `offset` and `size` into segname **__TEXT**
3. save those two values somewhere
4. run `dd if=test.ipa ibs=1 skip=<offset> count=<size> | shasum -a 256`
5. save the SHA256 and use it in your code
