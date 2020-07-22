Pod::Spec.new do |s|

  s.name             = 'RxBatteryManager'
  s.version          = '1.0.4'
  s.summary          = 'Reactive BatteryManager in Swift'

  s.description      = <<-DESC
  A Reactive BatteryManager in Swift for iOS'
                       DESC

  s.homepage         = 'https://github.com/RxSwiftCommunity/RxBatteryManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.documentation_url = 'https://github.com/mustafagunes/RxBatteryManager'
  s.author           = { 'Mustafa GUNES' => 'gunes149@gmail.com' }
  s.source           = { :git => 'https://github.com/RxSwiftCommunity/RxBatteryManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bashreks'

  s.ios.deployment_target = '9.0'

  s.requires_arc = true
  s.source_files = 'Sources/**/*'
  
  s.swift_version = '5.1'
  s.dependency 'RxRelay'

end

