//
//  LoadingView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 03/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

public class LoadingView {
    public static let shared = LoadingView()
    var blurImage = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImage.frame = UIScreen.main.bounds
        blurImage.backgroundColor = UIColor.black
        blurImage.isUserInteractionEnabled = true
        blurImage.alpha = 0.3
        indicator.style = .whiteLarge
        indicator.center = blurImage.center
        indicator.startAnimating()
        indicator.color = UIColor.AppColors.main
    }

    func showIndicator(){
        DispatchQueue.main.async(execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImage)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    
    func hideIndicator(){
        DispatchQueue.main.async(execute: {
                self.blurImage.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
