//
//  UIImage+Extension.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/11.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

//MARK: - Source
extension UIImage {
    
    /// 获取Bundle图片资源文件
    /// - Parameters:
    ///   - name: 资源名称
    ///   - type: 资源类型
    public static func es_imageFromBundle(name: String, type: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            return nil
        }
        return UIImage.init(contentsOfFile: path)
    }
    
    /// 创建纯色图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片尺寸
    public static func es_image(from color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect.init(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

//MARK: - Clip
extension UIImage {
    
    /// 图片裁剪
    /// - Parameter rect: 裁剪区域
    public func es_clip(at rect: CGRect) -> UIImage? {
        guard let imageRef = self.cgImage else {
            return nil
        }
        guard let newImageRef = imageRef.cropping(to: rect) else { return nil
        }
        let image = UIImage.init(cgImage: newImageRef)
        return image
    }
    
    /// 保持图片比例,短边＝targerSize,另外一边可能超出
    /// - Parameter size: 目标尺寸
    public func es_aspect(toMinSize size: CGSize) -> UIImage? {
        if size == CGSize.zero || size == self.size {
            return self
        }
        let xFactor = size.width / self.size.width
        let yFactor = size.height / self.size.height
        
        let scaleFactor = xFactor > yFactor ? xFactor : yFactor
        
        let scaleWidth = self.size.width * scaleFactor
        let scaleHeight = self.size.height * scaleFactor
        
        var anchorPoint = CGPoint.zero;
        
        if xFactor > yFactor {
            anchorPoint.y = (size.height - scaleHeight) / 2.0
        }
        if xFactor < yFactor {
            anchorPoint.x = (size.width - scaleWidth) / 2.0
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        var anchorRect = CGRect.zero
        anchorRect.origin = anchorPoint
        anchorRect.size.width = scaleWidth
        anchorRect.size.height = scaleHeight
        self.draw(in: anchorRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 保持图片比例,长边＝targerSize,另外一边可能小于targetSize
    /// - Parameter size: 目标尺寸
    public func es_aspect(toMaxSize size: CGSize) -> UIImage? {
        if size == CGSize.zero || size == self.size {
            return self
        }
        let xFactor = size.width / self.size.width
        let yFactor = size.height / self.size.height
        
        let scaleFactor = xFactor < yFactor ? xFactor : yFactor
        
        let scaleWidth = self.size.width * scaleFactor
        let scaleHeight = self.size.height * scaleFactor
        
        var anchorPoint = CGPoint.zero;
        
        if xFactor < yFactor {
            anchorPoint.y = (size.height - scaleHeight) / 2.0
        }
        if xFactor > yFactor {
            anchorPoint.x = (size.width - scaleWidth) / 2.0
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        var anchorRect = CGRect.zero
        anchorRect.origin = anchorPoint
        anchorRect.size.width = scaleWidth
        anchorRect.size.height = scaleHeight
        self.draw(in: anchorRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

//MARK: - Rotate
extension UIImage {
    /// 图片矫正
    public func es_fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
        default:
            break
        }
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        return img
        
    }
    
    /// 图片旋转
    /// - Parameter radinas: 旋转角度 0 - 2pi
    public func es_rotate(radinas: CGFloat) -> UIImage? {
        let newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: radinas)).size

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        // Move origin to middle
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        // Rotate around middle
        context.rotate(by: radinas)
        self.draw(in: CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

