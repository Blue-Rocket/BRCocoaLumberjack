Pod::Spec.new do |s|

  s.name         = "BRCocoaLumberjack"
  s.version      = "2.0.2"
  s.summary      = "Easy CocoaLumberjack for iOS."

  s.description  = <<-DESC
                    This project provides a way to integrate the
                    [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack) project easily
                    into your own project with log levels configurable per Cocoa class, similar to what
                    the venerable [log4j](http://logging.apache.org/) provides in Java.
                    DESC

  s.homepage     = "https://github.com/Blue-Rocket/BRCocoaLumberjack"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "Matt Magoffin" => "matt@bluerocket.us" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/Blue-Rocket/BRCocoaLumberjack.git", 
                     :tag => s.version.to_s }

  s.source_files  = "BRCocoaLumberjack/BRCocoaLumberjack.h",
                    "BRCocoaLumberjack/BRCocoaLumberjack/*.{h,m}"

  s.requires_arc = true

  s.prefix_header_contents = <<-PCH
#ifdef __OBJC__
    #import <BRCocoaLumberjack/BRCocoaLumberjack.h>
#endif
PCH

  s.dependency 'CocoaLumberjack', '~> 2.0'

end
