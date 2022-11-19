
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
    @IBOutlet private weak var dropdownButton: UIButton!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var registrationTypeSegmentController: UISegmentedControl!
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var registrationButton: CustomButton!
    
    private var availableTextFields: [UITextField] = []
    let dropdown = DropDown()
    let userManager = UserManager()
    private var segment: SegmentMode = .login

    
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
        LoginViewModel.loginOrRegisterUser(segment: SegmentMode)
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
            confirmPasswordTextfield.isHidden = true
            registrationButton.titleLabel?.text = SegmentTitle.Login.rawValue
        case .register:
            confirmPasswordTextfield.isHidden = false
            registrationButton.titleLabel?.text = SegmentTitle.Register.rawValue
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

