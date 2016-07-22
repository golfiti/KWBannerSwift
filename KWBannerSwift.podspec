Pod::Spec.new do |spec|
spec.name         = 'KWBannerSwift'
spec.version      = '0.1.1'
spec.license      = 'MIT'
spec.summary      = 'Create simple banner with image'
spec.homepage     = 'https://github.com/golfiti/KWBannerSwift'
spec.author       = 'Kridsanapong Wongthongdee'
spec.source       = { :git => 'https://github.com/golfiti/KWBannerSwift.git', :tag => 'v0.1.1' }
spec.source_files = 'KWBannerSwift/KWBannerView.swift'
spec.requires_arc = true
spec.platform     = :ios, :"8.0"
end

