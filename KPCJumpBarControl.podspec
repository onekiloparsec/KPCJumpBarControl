Pod::Spec.new do |s|
  s.name         = "KPCJumpBarControl"
  s.version      = "0.2.0"
  s.summary      = "A jump bar as in Xcode, to easily display and jump into a tree of objects."
  s.homepage     = "https://github.com/onekiloparsec/KPCJumpBarControl.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Cédric Foellmi" => "cedric@onekilopars.ec" }
  s.source       = { :git => "https://github.com/onekiloparsec/KPCJumpBarControl.git", :tag => "#{s.version}" }
  s.source_files = 'KPCJumpBarControl/*.{h,m}'
  s.platform     = :osx, '10.10'
  s.framework    = 'QuartzCore', 'AppKit'
  s.requires_arc = true
  s.resources    = 'Resources/*.pdf'
end
