# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PropertiesApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

pod 'Alamofire'
pod 'SwiftyJSON'
pod 'ReachabilitySwift'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'SwiftyJSON' || target.name == 'ReachabilitySwift'
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end

  # Pods for PropertiesApp

  target 'PropertiesAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PropertiesAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
