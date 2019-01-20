# Uncomment this line to define a global platform for your project
platform :ios, '11.0'

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

workspace 'APAccessibleFirebaseLogin.xcworkspace'
project 'APAccessibleFirebaseLogin.xcodeproj'

def all_pods

pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'FirebaseUI'
pod 'SwiftLint'

end

target 'APAccessibleFirebaseLogin' do
  project 'APAccessibleFirebaseLogin.xcodeproj'
  all_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ALWAYS_SEARCH_USER_PATHS'] = 'NO'
      config.build_settings['ENABLE_TESTABILITY'] = 'NO'
      config.build_settings['ALWAYS_SEARCH_USER_PATHS'] = 'NO'
      config.build_settings['GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS'] = 'NO'
      config.build_settings['GCC_WARN_UNUSED_VARIABLE'] = 'NO'
      config.build_settings['CLANG_WARN_STRICT_PROTOTYPES'] = 'NO'
      config.build_settings['CLANG_WARN_UNGUARDED_AVAILABILITY'] = 'NO'
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
      config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = 'NO'
    end
  end
end
