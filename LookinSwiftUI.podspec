Pod::Spec.new do |s|
  s.name             = 'LookinSwiftUI'
  s.version          = '0.1.0'
  s.summary          = 'LookinSwiftUI library for ios app.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/melisource/fury_LookinSwiftUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'carlos.chaguendo' => 'carlos.chaguendo@hotmail.com' }
  s.source           = { :git => 'git@github.com:melisource/fury_LookinSwiftUI.git', :tag => s.version.to_s }
  s.static_framework = true
  s.platform         = :ios, '15.0'
  s.swift_version    = '5.9'

  s.source_files = 'LibraryComponents/Classes/**/*.{swift}'
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
