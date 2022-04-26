//
//  UIImage+Extension.swift
//  zhongshitong
//
//  Created by zst on 2019/6/30.
//  Copyright © 2019 jusa. All rights reserved.
//

import Foundation
import AssetsLibrary
import UIKit

extension UIImage {
    
    /// Mask images with UIColor.
    static func imageMaskingwithColor(_ color: UIColor, image: UIImage?) -> UIImage?{
        
        if let image = image {
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            let context = UIGraphicsGetCurrentContext()!
            
            color.setFill()
            
            context.translateBy(x: 0, y: image.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            let rect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
            context.draw(image.cgImage!, in: rect)
            
            context.setBlendMode(CGBlendMode.sourceIn)
            context.addRect(rect)
            context.drawPath(using: CGPathDrawingMode.fill)
            
            let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return coloredImage
            
        } else {
            return nil
        }
    }
    
    static func imageWithColor(color: UIColor?) -> UIImage? {
        guard let tempColor = color else {
            return nil
        }
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(tempColor.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func fullResolutionImageFromAlAsset(asset : ALAsset?) -> UIImage? {
        var img : UIImage?
        if let temp = asset {
            let assetRep : ALAssetRepresentation = temp.defaultRepresentation()
            if let fullImage = assetRep.fullScreenImage() {
                let imgRef : CGImage = fullImage.takeUnretainedValue()
                img = UIImage.init(cgImage: imgRef, scale: CGFloat(assetRep.scale()), orientation: UIImage.Orientation.up)
            }
        }
        return img
    }
    
    func scaledToSize(targetSize : CGSize, heighQuality : Bool) -> UIImage? {
        var tarSize : CGSize = targetSize
        if heighQuality {
            tarSize = CGSize.init(width: targetSize.width * 2, height: targetSize.height * 2)
        }
        return self.scaledToSize(targetSize: tarSize)
    }
    
    func scaledToSize(targetSize : CGSize) -> UIImage? {
        var tarSize = targetSize
        let sourceImage : UIImage = self
        var newImage : UIImage?
        let imageSize : CGSize = sourceImage.size
        var scaleFactor : CGFloat = 0.0
        
        if imageSize.equalTo(tarSize) == false {
            let widthFactor : CGFloat = tarSize.width / imageSize.width
            let heightFactor : CGFloat = tarSize.height / imageSize.height
            if widthFactor < heightFactor {
                scaleFactor = heightFactor
            }else{
                scaleFactor = widthFactor
            }
        }
        
        scaleFactor = myMin(a: scaleFactor, b: 1.0)
        let targetWidth : CGFloat = imageSize.width * scaleFactor
        let targetHeight : CGFloat = imageSize.height * scaleFactor
        tarSize = CGSize.init(width: floor(targetWidth), height: floor(targetHeight))
        
        UIGraphicsBeginImageContext(targetSize)
        sourceImage.draw(in: CGRect.init(x: 0, y: 0, width: ceil(targetWidth), height: ceil(targetHeight)))
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if newImage == nil {
            newImage = sourceImage
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func myMin <T : Comparable> (a: T, b: T) -> T {
        if a > b {
            return b
        }
        return a
    }
    
    static func resizedImage(name: String) -> UIImage? {
        let image: UIImage? = UIImage.init(named: name)
        guard let temp = image else {
            return nil
        }
        return temp.stretchableImage(withLeftCapWidth: Int(temp.size.width * 0.5), topCapHeight: Int(temp.size.height * 0.5))
    }
    
    static func resizedImage(name: String, widthRate: CGFloat, heightRate: CGFloat) -> UIImage? {
        let image: UIImage? = UIImage.init(named: name)
        guard let temp = image else {
            return nil
        }
        return temp.stretchableImage(withLeftCapWidth: Int(temp.size.width * widthRate), topCapHeight: Int(temp.size.height * heightRate))
    }
}
