
import UIKit
import DropDown

class LoginViewController: UIViewController {
    
    enum SegmentTitle: String {
        
        case Register = "Register"
        case Login = "Login"
    }
    
    enum SegmentMode {
        case login
        case register
    }
    
   enum AccountCurrency: String {
        case eur = "EUR"
        case usd = "USD"
        case gbp = "GBP"
    }
    
    //MARK: - Outlets
    
    @IBOutlet private weak var dropdownView: UIView!
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var currencyAccountLabel: UILabel!
    @IBOutlet private weak var registrationTypeSegmentController: UISegmentedControl!
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var registrationButton: CustomButton!
    
    private var availableTextFields: [UITextField] = []
    let dropdown = DropDown()
    let userManager = UserDefaultsManager()
    let loggedInUser = UserDefaultsManager.currentlyLoggedInAccount
    let navigate = Navigator()
    private var segment: SegmentMode = .register

    
    let accountCurrencyValues = [
        AccountCurrency.eur.rawValue,
        AccountCurrency.usd.rawValue,
        AccountCurrency.gbp.rawValue
    ]

    // MARK: - Actions
    
    @IBAction func dropdownButtonTapped() {
        dropdown.show()
        print("Dropdown tapped")
    }
    
    
    @IBAction func submitButtonTapped() {
        print("SUBMIT BUTTION TAPPED")
        loginOrRegister()
        
    }
    
    @IBAction func onSegmentControllerTypeChanged(_ sender: Any) {
        switch registrationTypeSegmentController.selectedSegmentIndex {
        case 0:
            segment = .register
        case 1:
            segment = .login
        default:
            break
        }
        configureViewForSegment()
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        configureInitialView()
        clearAllTextfields()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextfieldsDelegates()
        configureCurrencyAccountDropdownSection()
    }
    
}

private extension LoginViewController {
    
    func loginOrRegister() {
        switch segment {
        case .login:
            login()
        case .register:
            register()
        }
    }
    
    func login() {
        do {
            try? userManager.login(phone: phoneNumberTextfield.text,
                                   password: passwordTextfield.text)
            
            if let loggedInUser = UserDefaultsManager.currentlyLoggedInAccount {
                navigate.proceedToHomeScreen()
                return
            }
            
        } catch let loginError as Errors.LoginError {
            displayError(message: loginError.error)
        } catch let generalError as Errors.General {
            displayError(message: generalError.error)
        } catch {
            displayError(message: Errors.General.unexpectedError.error )
            print(Errors.General.unexpectedError)
        }
    }
    
    func register() {
        do {
            try? userManager.register(phone: phoneNumberTextfield.text,
                                          password: passwordTextfield.text,
                                          confirmPassword: confirmPasswordTextfield.text)
            
            guard let loggedInUser = UserDefaultsManager.currentlyLoggedInAccount else {
                return
            }
            
            if loggedInUser.phone == UserDefaultsManager.currentlyLoggedInAccount?.phone &&
                loggedInUser.password == UserDefaultsManager.currentlyLoggedInAccount?.password {
                navigate.proceedToHomeScreen()
            }
            
            } catch let registrationError as Errors.RegistrationError {
                displayError(message: registrationError.error)
            } catch let generalError as Errors.General {
                displayError(message: generalError.error)
            } catch let securityError as Errors.Secure {
                    displayError(message: securityError.error)
            } catch {
                displayError(message: Errors.General.unexpectedError.error)
                print(Errors.General.unexpectedError)
            }
        }
    }


extension LoginViewController {
    
    private func clearAllTextfields() {
        
        phoneNumberTextfield.text = nil
        passwordTextfield.text = nil
        confirmPasswordTextfield.text = nil
    }
    
    private func setTextfieldsDelegates() {

        phoneNumberTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
    }
    
    private func configureInitialView() {
        
        segment = .register
        registrationButton.isAccesible(isAccesible: false)
        errorLabel.isHidden = true
    }
    
    private func configureViewForSegment() {
        
        switch segment {
        case .login:
            print("LOGIN SEGMENT")
            confirmPasswordTextfield.isHidden = true
            registrationButton.titleLabel?.text = SegmentTitle.Login.rawValue
            dropdownView.isHidden = true
            clearAllTextfields()
        case .register:
            print("REGISTER SEGMENT")
            confirmPasswordTextfield.isHidden = false
            registrationButton.titleLabel?.text = SegmentTitle.Register.rawValue
            dropdownView.isHidden = false
            clearAllTextfields()
        }
    }
    
    private func configureCurrencyAccountDropdownSection() {
        
        dropdown.anchorView = dropdown
        dropdown.dataSource = accountCurrencyValues
        dropdown.bottomOffset = CGPoint(x: 10, y: 110)
        dropdown.width = 118
        dropdown.shadowColor = .gray
        dropdown.selectionBackgroundColor = .green
        
        dropdown.direction = .bottom
        dropdown.selectionAction = { (index: Int, item: String) in
            self.currencyAccountLabel.text = self.accountCurrencyValues[index]
            self.currencyAccountLabel.textColor = .black
        }
    }
    
    private func configureSubmitButton() {
        
        let allTextFieldsFilled = availableTextFields.allSatisfy { textField in
            guard let text = textField.text else { return false }
            return !text.isEmpty
        }
        registrationButton.isAccesible(isAccesible: allTextFieldsFilled)
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        configureSubmitButton()
    }
}


extension LoginViewController {
    
    private func displayError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}
