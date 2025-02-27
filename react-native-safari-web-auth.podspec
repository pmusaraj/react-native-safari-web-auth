require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platform     = :ios, "13.7"
  s.swift_version = "5.0"

  s.source       = { :git => "https://github.com/pmusaraj/react-native-safari-web-auth.git", :tag => "v#{s.version}" }
  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.dependency "React-Core"
end
