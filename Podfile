# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Blank' do
  use_frameworks!
  pod 'pop'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
	  config.build_settings['SWIFT_VERSION'] = '5.0'
	  config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'		
    end
  end
end
