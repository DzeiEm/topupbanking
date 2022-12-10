
import Foundation
import UIKit

class AuthenticationViewController: UIViewController {
    
    enum Titles: String {
        case login = "Login"
        case register = "Register"
        case appName = "Top up banking"
    }
    
    enum Mode {
        case login
        case register
    }
        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appNameTitle: UILabel!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var registerButtonLabel: UIButton!
  
    
    @IBAction func loginButtonTapped() {
        proceedToLoginRegisterViewController(mode: Mode.login)
    }
    
    @IBAction func registerButtonTapped() {
        proceedToLoginRegisterViewController(mode: Mode.register)
    }
    
    override func viewDidLoad() {
        appNameTitle.text = Titles.appName.rawValue
        UIElementConfiguration.setupImageView(imageView)
        UIElementConfiguration.satup(for: loginButtonLabel,
                                     label: Titles.login.rawValue,
                                     tintColor: .white,
                                     backgroundColor: .systemPink)
       UIElementConfiguration.satup(for: registerButtonLabel,
                                     label: Titles.register.rawValue,
                                     tintColor: .white,
                                     backgroundColor: .purple)
        
    }
}


extension AuthenticationViewController {
    
    private func proceedToLoginRegisterViewController(mode: Mode) {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .fullScreen
       
        if mode == Mode.login {
            loginScreen.segment = .login
           
            loginScreen.registrationTypeSegmentController.selectedSegmentIndex = 1
            
           
        } else {
            loginScreen.segment = .register
        }
        
        present(loginScreen, animated: true)
    }
}
