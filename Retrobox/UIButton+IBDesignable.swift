import UIKit

@IBDesignable
extension UIButton {
    
    @IBInspectable
    public var cornerRadius :CGFloat {
        
        set { layer.cornerRadius = newValue }
        
        get {
            return layer.cornerRadius
        }
        
    }
    
}