
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
    
    //MARK: - Variables
    
    private var availableTextFields: [UITextField] = []
    let dropdown = DropDown()
    var userManager = UserManager()
//    var accountManager = AccountManager()
    let loggedInUser = UserManager.loggedInAccount
    private var segment: SegmentMode = .register
    var selectedAccountCurrency: AccountCurrency.RawValue = ""
    
    let accountCurrencyValues = [
        AccountCurrency.eur.rawValue,
        AccountCurrency.usd.rawValue,
        AccountCurrency.gbp.rawValue
    ]

    // MARK: - Actions
    
    @IBAction func dropdownButtonTapped() {
        dropdown.show()
    }
    
    @IBAction func submitButtonTapped() {
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
            
      
            guard let loggedInUser = UserManager.loggedInAccount else {
                return
            }
            if loggedInUser.phone == UserManager.loggedInAccount?.phone &&
                loggedInUser.password == UserManager.loggedInAccount?.password {
               proceedToHomeScreen()
            }
            
        } catch let loginError as Errors.Login {
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
                                      confirmPassword: confirmPasswordTextfield.text,
                                      accountCurrency: selectedAccountCurrency, balance: "0.00")
            
            if let loggedInUser = UserManager.loggedInAccount {
                print("LOGGEDIN: \(loggedInUser)")
                proceedToHomeScreen()
                return
            }
            
            } catch let registrationError as Errors.Registration {
                displayError(message: registrationError.error)
            } catch let generalError as Errors.General {
                displayError(message: generalError.error)
            } catch let securityError as Errors.Registration {
                // TODO: Secure identification needed
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
            self.onCurrencyAccountChanged(index)
        }
    }
    
    private func onCurrencyAccountChanged(_ index: Int) {
        switch index {
        case 0:
            print("EUR SELECTED \((0))")
            return selectedAccountCurrency = AccountCurrency.eur.rawValue
        case 1:
            print("USD SELECTED \((1))")
            return selectedAccountCurrency = AccountCurrency.usd.rawValue
        case 2:
            print("gBP SELECTED \((2))")
            return selectedAccountCurrency = AccountCurrency.gbp.rawValue
        default:
            print("NOTHING SELECTED, default setting applies")
            selectedAccountCurrency = AccountCurrency.eur.rawValue
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
    
    func proceedToHomeScreen() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
