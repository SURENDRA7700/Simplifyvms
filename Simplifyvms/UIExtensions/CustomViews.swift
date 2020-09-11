//
//  CustomViews.swift

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















