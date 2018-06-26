#
# Be sure to run `pod lib lint YDDeviceTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YDDeviceTool'
  s.version          = '0.1.1'
  s.summary          = 'YDDeviceTool 是一个用来获取设备信息的工具.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
YDDeviceTool 是一个工具，用来获取设备的名称、类型、ip等一些相关信息.
                       DESC

  s.homepage         = 'https://github.com/herody/YDDeviceTool.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'houyadi' => '314622981@qq.com' }
  s.source           = { :git => 'https://github.com/herody/YDDeviceTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YDDeviceTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YDDeviceTool' => ['YDDeviceTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
