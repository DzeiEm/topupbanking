
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
                    navigateToHomeViewControlller()
                    return
                }
            } catch let registrationError as Errors.RegistrationError {
                displayErrorLabel(message: registrationError.error)
                
            } catch let loginError as Errors.LoginError {
                displayErrorLabel(message: loginError.error)
                
            } catch let generalError as Errors.General {
                displayErrorLabel(message: generalError.error)
                
            } catch {
                displayErrorLabel(message: "UNEXPECTED ERROR OCCURED")
            }
            
        } else {
            
            do {
                try? UserManager.login(
                    phonenumber: phoneNumberTextfield.text,
                    password: passwordTextfield.text)
                if loggedInUser?.username == UserManager.loggedInAccount?.username &&
                    loggedInUser?.password == UserManager.loggedInAccount?.password {
                    navigateToHomeViewControlller()
                }
                
            } catch {
               displayErrorLabel(message: "UNEXPECTED ERROR OCCURED")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        phoneNumberTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneNumberTextfield.delegate =  self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
}


extension RegistrationViewController {
 
    private func displayErrorLabel(message: String) {
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
        
    private func navigateToHomeViewControlller() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true, completion: nil)
        return
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        buttonLabel.isEnabled = true
        return true
    }
    
    private func hideTextfield( textfield: UITextField?, hide: Bool) {
        textfield?.isHidden = hide
    }
    
    private func clearTextfield(_ textfield: UITextField ) {
        textfield.text = ""
    }
    
    private func isPhoneValid(number: String) -> Bool {
        
        if number.contains("+370") {
            number.count == 11
            return true
        }
        
        if number.starts(with: "8") {
            number.count == 9
            return true
        }
        return false
    }
}
