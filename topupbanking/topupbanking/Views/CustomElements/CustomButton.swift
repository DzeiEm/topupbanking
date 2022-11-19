
import UIKit

final class CustomButton: UIButton {
    
    override func didMoveToSuperview() {
        configureButton()
    }
    
    func configureButton() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.3
        self.titleLabel?.font = .boldSystemFont(ofSize: 15)
        self.backgroundColor = .purple
    }
    
    func isAccesible(isAccesible: Bool) {
        
        guard isAccesible else {
            layer.opacity = 0.5
            isEnabled = false
            return
        }
        
        layer.opacity = 1
        isEnabled = true
    }
}
