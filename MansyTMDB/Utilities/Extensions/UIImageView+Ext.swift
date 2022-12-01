//
//  UIImageView+Ext.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 25/11/2022.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(url: String, placeholder: UIImage? = nil, config: ImageConfig? = nil){
        if let config, config.isDownsamplingEnabled{
            image = placeholder
            guard let url = URL(string: url) else{return}
            let size = frame.size
            DispatchQueue.global(qos: .userInteractive).async {
                let image = self.downsample(imageAt: url, to: size)
                DispatchQueue.main.async {
                    guard let image = image else{return}
                    self.image = image
                }
            }

        }else{
            kf.setImage(with: URL(string: url), placeholder: placeholder, options: [.transition(.fade(0.25))])
        }
    }
    
    func downsample(imageAt imageURL: URL,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {

        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            print("couldn't downsample image: error 1")
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            print("couldn't downsample image: error 1")
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
    
}
