Pod::Spec.new do |s|
  s.name         = "InfiniteScroll"
  s.version      = "0.0.1"
  s.summary      = "Very greaty component"
  s.license      = 'MIT'
  s.author       = { "Marek Mościchowski" => "moscich@gmail.com" }
  s.source       = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'Classes'

end
