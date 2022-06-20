import Foundation
import UIKit


extension UIButton {
    func setCorner() {
        self.layer.cornerRadius = 8
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}

class RoundedButton: UIButton {
    override func didMoveToWindow() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
        setCorner()
    }
}

class RoundedImage: UIImageView {
    override func didMoveToWindow() {
        self.layer.cornerRadius = 16
    }
}

class RoundedView: UIImageView {
    override func didMoveToWindow() {
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
    }
}

class ViewCalendar: UIImageView {
    override func didMoveToWindow() {
        self.layer.cornerRadius = 16
//        self.backgroundColor = UIColor(red: 0.92, green: 0.29, blue: 0.26, alpha: 1.00)
    }
}
