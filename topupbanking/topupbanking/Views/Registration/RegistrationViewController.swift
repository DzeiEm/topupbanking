

import UIKit

class RegistrationViewController: UIViewController {
    
    enum SegmentTitle: String {
        case Register = "Register"
        case Login = "Login"
    }
    
    //MARK: - OUTLETS
    @IBOutlet private weak var registrationTypeSegmentController: UISegmentedControl!
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var buttonLabel: UIButton!
    
    //MARK: - ACTIONS
    @IBAction func loginButtonTapped() {
        print("Button tapped")
    }
    
    @IBAction func onSegmentControllerTypeChanged(_ sender: Any) {
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Register.rawValue
        } else {
            errorLabel.isHidden = true
            buttonLabel.titleLabel?.text = SegmentTitle.Login.rawValue
        }
        
    }
    
}

