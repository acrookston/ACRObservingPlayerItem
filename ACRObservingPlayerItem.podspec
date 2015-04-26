Pod::Spec.new do |s|
  s.name             = "ACRObservingPlayerItem"
  s.version          = "1.1.0"
  s.summary          = "An AVPlayerItem subclass which helps with handling video playback key-value observation."
  s.description      = <<-DESC
    I was getting a lot of crashreports with deallocated AVPlayerItem's while a KVO was still active.
    It was hard to manually remove the KVO when the AVPlayerItem was randomly deallocated from inside a UITableViewCell.
 
    ACRObservingPlayerItem is a simple wrapper class for AVPlayerItem which handles the observing of some
    common playback events and safely releases the KVO on deallocation.
                       DESC
  s.homepage         = "https://github.com/acrookston/ACRObservingPlayerItem"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Andrew Crookston" => "andrew@caoos.com" }
  s.source           = { :git => "https://github.com/acrookston/ACRObservingPlayerItem.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/acr'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = "ACRObservingPlayerItem", "ACRObservingPlayerItem/*.{h,m}"
  s.frameworks = 'AVFoundation'
end
