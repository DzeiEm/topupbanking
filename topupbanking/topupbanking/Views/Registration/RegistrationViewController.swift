

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
    
    let userManager = UserManager()
    
    //MARK: - ACTIONS
    @IBAction func loginButtonTapped() {
        
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            do {
                try UserManager.register(
                    phonenumber: phoneNumberTextfield.text,
                    password: passwordTextfield.text,
                    confirmPassword: confirmPasswordTextfield.text)
            } catch let error as Errors {
                displayError()
            }
            
        } else {
            do {
                try UserManager.login(
                    phonenumber: phoneNumberTextfield.text,
                    password: passwordTextfield.text)
                
            } catch let error as Errors {
                
            }
        }
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


extension RegistrationViewController {
 
    private func displayError(errorType: Errors) -> String {
        if errorType == Errors.RegistrationError {
            // registration error
        }
        if errorType == Errors.LoginError {
            //login error
        }
        if errorType == Errors.General {
            //general error
        }
    }
    
    private func highlighttextfield(textfield: UITextField) {
        textfield.isHighlighted: true ?? false
    }
    
}
