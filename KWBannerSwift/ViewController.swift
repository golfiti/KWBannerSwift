//
//  ViewController.swift
//  KWBannerSwift
//
//  Created by Kridsanapong Wongthongdee on 7/8/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KWBannerViewDelegate{

    @IBOutlet weak var bannerView: KWBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.delegate = self;
        bannerView.imagesName = ["image2","image1","image2","image1"]
        bannerView.isAutoScroll = true
        bannerView.drawBanner()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func didTapBannerAtIndex(bannerIndex:CGFloat) {
        print("Tap Banner at Index \(bannerIndex)")
        bannerView.imagesName = ["image1","image1","image1","image1"]
        bannerView.isAutoScroll = true
        bannerView.drawBanner()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

