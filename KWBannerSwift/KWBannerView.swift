//
//  KWBannerView.swift
//  KWBannerSwift
//
//  Created by Kridsanapong Wongthongdee on 7/8/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit

@objc protocol KWBannerViewDelegate:class {
    optional func didTapBannerAtIndex(bannerIndex:CGFloat)
}

class KWBannerView: UIView {
    
    var scrollView = UIScrollView()
    
    // Image
    var imageCount:CGFloat = 0

    // Array of Images Name
    var nameOfBannerImages:[String]?
    
    var isAutoScroll:Bool = false
    
    var delegate:KWBannerViewDelegate?
    
    
    // MARK:Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func resetData(){
    
        imageCount = 0
        
        NSTimer().invalidate()
        
        if let scrollViewWithTag = self.scrollView.viewWithTag(9){
            scrollViewWithTag.removeFromSuperview()
        }
    }
    
    // MARK:Setup
    func drawBanner() {
        
        resetData()
        
        // Seup
        setupBannerImages()
        
        if (isAutoScroll) {
            NSTimer.scheduledTimerWithTimeInterval(3,target: self,
                                                   selector:#selector(autoScrollBanner),
                                                   userInfo: nil,repeats: true)
        }
    }
    
    func setupBannerImages(){
        
        if (nameOfBannerImages == nil) {
            return
        }
        
        self.scrollView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for imageName in nameOfBannerImages! {
            let banner = UIImageView(frame: CGRectMake(scrollViewWidth * imageCount,0,scrollViewWidth, scrollViewHeight))
            
            if let imageTempt = UIImage(named:imageName) {
                banner.image = imageTempt
                self.scrollView.addSubview(banner)
                imageCount = imageCount+1
            }
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * imageCount,
                                                 self.scrollView.frame.height)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.tag = 9
        self.addSubview(self.scrollView);
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                action:#selector(didTapBannerAtIndex))
        self.scrollView.addGestureRecognizer(tapRecognizer)
    }
    
    
    // MARK: Tap Banner Delgate
    func didTapBannerAtIndex() {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.delegate?.didTapBannerAtIndex?(currentPage)
    }
    
    
    // MARK: AutoScroll
    @objc private func autoScrollBanner(){

        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * imageCount
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
}
