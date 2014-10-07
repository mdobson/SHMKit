#
# Be sure to run `pod lib lint SHMKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SHMKit"
  s.version          = "0.1.0"
  s.summary          = "A generic client for Siren Hypermedia APIs"
  s.description      = <<-DESC
                        A generic Siren hypermedia client. If you're API conforms to the Siren spec use this to interact with it.
                       DESC
  s.homepage         = "https://github.com/mdobson/SHMKit"
  s.license          = 'MIT'
  s.author           = { "Matt Dobson" => "mdobson4@gmail.com" }
  s.source           = { :git => "https://github.com/mdobson/SHMKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mdobs'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'SHMKit' => ['Pod/Assets/*.png']
  }

end
