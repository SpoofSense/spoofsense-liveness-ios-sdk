Pod::Spec.new do |s|
    s.name             = "SpoofSense"
    s.version          = "0.0.5"
    s.summary          = 'Check Liveness'
    s.license          = 'MIT'
    s.author           = {'Mohit' => 'mohit@appringer.com'}

    s.source           = { :git => 'https://github.com/SpoofSense/spoofsense-liveness-ios-sdk.git', :tag => "#{s.version}" }

    s.homepage = "https://github.com/SpoofSense/spoofsense-liveness-ios-sdk"


    s.ios.deployment_target = '13.2'
    s.requires_arc = true

    s.source_files = 'spoofsense-liveness-ios-sdk', 'spoof-sense-ios/**/*.{swift}'
    s.resources = "spoof-sense-ios/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,ttf}"

    s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'AVKit'
    s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
    s.swift_version = '5.0'
end
