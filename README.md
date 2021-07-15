# flutter_security

A flutter package that aim to take care of your mobile app security side.

### The Code

I'm not a native mobile developer. 

This package is a mashup of [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite)
and some stackoverflow helpful posts (that I lost links of) for android implementation

#### Android

To be able to check for anti tampering on Android you need to provide the SHA-1 of the keystore of your app. If you are in debug mode and you didn't make a keystore, a SHA is assigned to your app. Please check you app level `build.gradle`.

#### iOs

To be able to check for anti tampering on iOs you need a little bit more work to be done. As mentioned [here](https://github.com/securing/IOSSecuritySuite/issues/30#issuecomment-769705779) you need to provider you `bundleId` and the hashed value of the `mobile.provision` (a file contained into .ipa builded file):
1. Unzip the .ipa
2. Go into the payload folder, right click on the app, click on `Show Package Contents`
3. You should see the **Unix executable** with my app name (Example, "test" is the name in this case)

Open a terminal and:
1. `otool -l **/path/to/unix/executable**`
2. look for value of `offset` and `size` into segname **__TEXT**
3. save those two values somewhere
4. run `dd if=test.ipa ibs=1 skip=<offset> count=<size> | shasum -a 256`
5. save the SHA256 and use it in your code
