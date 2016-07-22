//
//  KWBannerView.swift
//  KWBannerSwift
//
//  Created by Kridsanapong Wongthongdee on 7/8/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit

@objc public protocol KWBannerViewDelegate:class {
    optional func didTapBannerAtIndex(bannerIndex:CGFloat)
}

public class KWBannerView: UIView,UIScrollViewDelegate{
    
    var delegate:KWBannerViewDelegate?

    /* Set banner image via UIImage or imageName */
    public var imagesName:[String]? {
        didSet{
            prepareImagesName()
        }
    }
    
    public var imagesObject:[UIImage]? {
        didSet{
            prepareImagesObject()
        }
    }

    /* Automatic scroll banner */
    public var isAutoScroll:Bool = false

    /* ---------------------------------------------------- */
    
    var scrollView = UIScrollView()
    var imageCount:CGFloat = 0
    var imagesAll:[UIImage] = []
    var autoScrollTimer = NSTimer()
    
    // MARK:Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:Setup
    public func drawBanner() {
        
        resetData()
        
        setupBannerImages()
        
        if (isAutoScroll) {
            autoScrollTimer = NSTimer.scheduledTimerWithTimeInterval(3,target:self,
                                                                     selector:#selector(self.autoScrollBanner),
                                                                     userInfo:nil,repeats:true)
        }
    }
    
    private func prepareImagesObject(){
        for imageObject in imagesObject! {
            imagesAll.append(imageObject)
        }
    }
    private func prepareImagesName(){
        for imageName in imagesName! {
            if let imageTemp = UIImage(named:imageName) {
                imagesAll.append(imageTemp)
            }
        }
    }
    
    private func setupBannerImages(){
        
        if imagesAll.count == 0 {
            return
        }
        
        self.scrollView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for imageName in imagesAll {
            let banner = UIImageView(frame: CGRectMake(scrollViewWidth * imageCount,0,scrollViewWidth, scrollViewHeight))
            banner.image = imageName
            self.scrollView.addSubview(banner)
            imageCount = imageCount+1
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * imageCount,
                                                 self.scrollView.frame.height)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.tag = 9
        self.scrollView.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action:#selector(didTapBannerAtIndex))
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.addSubview(self.scrollView);
    }
    
    
    // MARK: Tap Banner Delgate
    public func didTapBannerAtIndex() {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.delegate?.didTapBannerAtIndex?(currentPage)
    }
    
    
    // MARK: AutoScroll
    func autoScrollBanner(){

        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * imageCount
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth,CGRectGetHeight(self.scrollView.frame)), animated:true)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if (isAutoScroll) {
            autoScrollTimer.invalidate()
            autoScrollTimer = NSTimer.scheduledTimerWithTimeInterval(3,target:self,
                                                                     selector:#selector(self.autoScrollBanner),
                                                                     userInfo:nil,repeats:true)
        }
    }

    private func resetData(){
        
        imageCount = 0
        autoScrollTimer.invalidate()
        
        if let scrollViewWithTag = self.scrollView.viewWithTag(9){
            scrollViewWithTag.removeFromSuperview()
        }
    }
    
}
