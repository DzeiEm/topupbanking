
import Foundation
import UIKit

final class UIElementConfiguration {
    
    static func satup(for button: UIButton, label: String, tintColor: UIColor, backgroundColor: UIColor) {
        button.titleLabel?.text = label
        button.titleLabel?.textColor = tintColor
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 20
    }
    
    static func setupImageView(_ image: UIImageView) {
        image.layer.cornerRadius = 40
        image.layer.shadowColor = UIColor.green.cgColor
        image.layer.shadowRadius = 4
    }
}
