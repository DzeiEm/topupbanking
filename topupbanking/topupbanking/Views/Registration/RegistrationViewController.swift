

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
    let navigate = Navigate()
    let loggedInUser = UserManager.loggedInAccount
    
    //MARK: - ACTIONS
    @IBAction func loginButtonTapped() {
        
        if registrationTypeSegmentController.selectedSegmentIndex == 0 {
            do {
                try? UserManager.register(
                    phonenumber: phoneNumberTextfield.text,
                    password: passwordTextfield.text,
                    confirmPassword: confirmPasswordTextfield.text)
                
                if let loggedInUser = UserManager.loggedInAccount {
                    navigate.toHomeViewController()
                    return
                }
            } catch let error as Errors {
                displayError(errorType: error)
            }
            
        } else {
            do {
                try? UserManager.login(
                    phonenumber: phoneNumberTextfield.text,
                    password: passwordTextfield.text)
                if loggedInUser?.username == UserManager.loggedInAccount?.username &&
                    loggedInUser?.password == UserManager.loggedInAccount?.password {
                    navigate.toHomeViewController()
                }
                
            } catch let error as Errors {
                displayError(errorType: error)
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
      // display error
        return "Error"
    }
    
//    private func highlighttextfield(textfield: UITextField) {
//        textfield.isHighlighted: true ?? false
//    }
    
}
