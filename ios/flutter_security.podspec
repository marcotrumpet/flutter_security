#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_security.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_security'
  s.version          = '0.0.1'
  s.summary          = 'A flutter package that aim to take care of your mobile app security side.'
  s.description      = <<-DESC
A flutter package that aim to take care of your mobile app security side.
                       DESC
  s.homepage         = 'https://github.com/marcotrumpet'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Marco Galetta' => 'marcotrumpet90@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'IOSSecuritySuite'
end
