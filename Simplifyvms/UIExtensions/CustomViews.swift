
//
//  CustomSearchBar.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 11/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import UIKit

class CustomSearchBar: RegisterField {

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 10
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 5
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 55))
    }
    
    func setRightViewIcon(imageName: String?)  {
        guard let imageIcon = imageName else {return}

        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.black

        self.rightView = imageView
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView?.clipsToBounds = true
        
    }
    
    
    
}





class RegisterField: UITextField {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.darkGray
        self.borderStyle = UITextField.BorderStyle.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.autocapitalizationType = .none
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textAlignment = .right
        self.textColor = UIColor.Simplify.Black
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.Simplify.borderGray.cgColor
        self.clipsToBounds = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= 5
        return rightViewRect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += 5
        return leftViewRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
//        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    
    func setFieldImageIcon(imageName: String?) {
        guard let imageIcon = imageName else {
            return
        }
        let img = UIImage(named: imageIcon)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(red: 160, green: 160, blue: 160)
        self.leftView = imageView
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView?.clipsToBounds = true
    }

    

  

}

class mobileField: RegisterField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        //        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
    }
    

    
    
}



@IBDesignable
class BoxView: UIView {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            setNeedsLayout()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
}






class ErrorManager: NSObject {
    public static func showErrorAlert(mainTitle: String?, subTitle: String?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.warningImage, backgroundColor: UIColor.Simplify.errorColor)
        banner.didDismissBlock = {
//            self.isErrorAlertDismissed = true
        }
        banner.show(duration: 1.5)
    }
    
    public static func showErrorAlert(mainTitle: String?, subTitle: String?, withDuration: TimeInterval?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.warningImage, backgroundColor: UIColor.Simplify.errorColor)
        banner.didDismissBlock = {
            //            self.isErrorAlertDismissed = true
        }
        banner.show(duration: withDuration)
    }
    
    
    public  static func showSuccessAlert(mainTitle: String?, subTitle: String?) {
        let banner = MyBanner(title: mainTitle, subtitle: subTitle, image: UIImage.successImage, backgroundColor: UIColor.Simplify.successColor)
        banner.didDismissBlock = {
        }
        banner.show(duration: 1.5)
    }
    

        
    
}



public extension UIImage {
    
    static let successImage = UIImage(named: "success")
    static let warningImage = UIImage(named: "warning")
    
    func flip() -> UIImage {
        let image = UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: UIImage.Orientation.upMirrored)
        return image
    }
    
    func fixedOrientation() -> UIImage? {
        
        guard imageOrientation != UIImage.Orientation.up else {
            //This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            //CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
}
}

