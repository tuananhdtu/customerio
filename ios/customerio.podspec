#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint customerio.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'customerio'
  s.version          = '0.0.1'
  s.summary          = 'Customer IO Plugin'
  s.description      = <<-DESC
Customer IO Plugin
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'CustomerIOMessagingPushAPN' , '~> 1.2.0-beta.1'
  s.dependency 'CustomerIOTracking' , '~> 1.2.0-beta.1'
  
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
