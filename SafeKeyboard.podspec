Pod::Spec.new do |s|

  s.name         = "SafeKeyboard"
  s.version      = "0.2.4"
  s.summary      = "3 SafeKeyboard,number,letter,special."

  s.description  = "a easy way to use 4 kinds of safeKeyboard"

  s.homepage     = "https://github.com/jack903652/safeKeyboard"

  s.license      = "MIT"

  s.author       = { "jack903652" => "jack903652@163.com" }
  
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/jack903652/safeKeyboard.git", :tag => "#{s.version}" }

  s.source_files = "CustomKeyboard"
  s.resources    = "CustomKeyboard/*.bundle"

  s.requires_arc = true
  
  s.user_target_xcconfig = { "GENERATE_INFOPLIST_FILE" => 'YES' }
  s.pod_target_xcconfig = { "GENERATE INFOPLIST FILE" => 'YES' }

end
