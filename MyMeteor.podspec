Pod::Spec.new do |spec|

	spec.name		= 'MyMeteor'
	spec.version	= '0.0.2'
	spec.homepage   = "http://github.com/premosystems/MyMeteor"
	spec.author     = { "Vincil Bishop" => "vincil.bishop@vbishop.com" }
	spec.license	= 'MIT'
	spec.summary	= 'Helper classes for implementing ObjectiveDDP as a Meteor client for iOS.'
	spec.source	= { :git => 'https://github.com/premosystems/MyMeteor.git', :tag => spec.version.to_s }
	spec.requires_arc = true

	spec.ios.deployment_target = '7.0'

	spec.resource = 'MyMeteor.podspec'

	spec.source_files = 'MyMeteor/*.{h,m}'

    spec.subspec "Core" do |core|
        core.source_files = 'MyMeteor/Core/*.{h,m}'
        core.ios.dependency 'ObjectiveDDP', '~>0.1.3'
        core.ios.dependency 'MyiOSHelpers/Logic/ThirdPartyHelpers/CocoaLumberjack', '~>0.0.2'
        core.prefix_header_contents = 	'#import "Lumberjack-Default-Log-Level.h"'
    end
    
    spec.subspec "UIKit" do |uikit|
        uikit.source_files = 'MyMeteor/UIKit/*.{h,m}'
        uikit.ios.dependency 'MyMeteor/Core'
        uikit.ios.dependency 'MyiOSHelpers/View/Screens/ModelObjectTableViewControllerBase', '~>0.0.2'
    end
	
end # spec