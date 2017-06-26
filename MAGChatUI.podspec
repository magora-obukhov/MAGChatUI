Pod::Spec.new do |s|
  s.name             = 'MAGChatUI'
  s.version          = '0.1.0'
  s.summary          = 'UI for chat.'
  s.description      = <<-DESC
MAGChatUI provides interface for chat.
                       DESC
  s.homepage         = 'https://github.com/Magora-IOS/MAGChatUI'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { 'zyxerion@gmail.com' => 'MAGChatUI MAGChatUI.xcodeproj rachenko@magora-systems.com' }
  s.source           = { :git => 'https://github.com/Magora-IOS/MAGChatUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'MAGChatUI/Classes/**/*'

  s.public_header_files = 'MAGChatUI/Classes/**/*.h'
  s.frameworks = 'UIKit', 'IGListKit'
  s.dependency 'IGListKit', '~> 3.0'
end
