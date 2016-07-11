# KWBannerSwift
Create simple banner with image 

# Installation
1. Download and drop [KWBannerView.swift](https://github.com/golfiti/KWBannerSwift/blob/master/KWBannerSwift/KWBannerView.swift) in your project.
2. Congratulations!

# Usage 
```
@IBOutlet weak var bannerView: KWBannerView!

bannerView.delegate = self;
bannerView.nameOfBannerImages = ["image1","image2"]
bannerView.drawBanner()
```
# Customization 
```
var nameOfImages:[String] = ["image1","image2"]
var isAutoScroll:Bool

func didTapBannerAtIndex(bannerIndex:CGFloat){}
```
# License
KWBannerSwift is released under the MIT license. See LICENSE for details.

# Spacial Thanks
 * [paulinesme](https://github.com/paulinesme)


