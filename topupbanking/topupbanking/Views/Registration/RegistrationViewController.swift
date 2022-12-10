
import Foundation
import UIKit
import DropDown

class RegistrationViewController: UIViewController {
    
    enum TitleName: String {
        case button = "Submit"
        case labelName = "Top up banking"
        
    }
    
    enum AccountCurrency: String {
        case eur = "EUR"
        case usd = "USD"
        case gbp = "GBP"
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var phoneNumberTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var confirmPasswordTextfield: UITextField!
    @IBOutlet private weak var submitButtonLabel: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet private weak var submitButton: CustomButton!
    
    let dropdown = DropDown()
    let accountCurrencyValues = [
        AccountCurrency.eur.rawValue,
        AccountCurrency.usd.rawValue,
        AccountCurrency.gbp.rawValue
    ]
    
    private var availableTextFields: [UITextField] = []
    private var selectedAccountCurrency: AccountCurrency.RawValue = ""
    let userManager = UserManager(apiManager: APIManager.init())
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        do {
            try userManager.register(phone: phoneNumberTextfield.text,
                                     password: passwordTextfield.text,
                                     confirmPassword: confirmPasswordTextfield.text,
                                     accountCurrency: selectedAccountCurrency, balance: String(UserManager.accountBalance))
            
            if let loggedInUser = UserManager.loggedInAccount {
                print("LOGGEDIN: \(loggedInUser)")
                proceedToHomeScreen()
                return
            }
            
        } catch let registrationError as Errors.Registration {
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
    
    @IBAction func dropDownButtonTapped(_ sender: Any) {
        //
    }
    
    
    
    override func viewDidLoad() {
        submitButtonLabel.titleLabel?.text =  TitleName.button.rawValue
        titleLabel.text = TitleName.labelName.rawValue
    }
}

extension RegistrationViewController {
    
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
        submitButton.isAccesible(isAccesible: false)
        errorLabel.isHidden = true
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
            self.accountLabel.text = self.accountCurrencyValues[index]
            self.accountLabel.textColor = .black
            self.onCurrencyAccountChanged(index)
        }
    }
        
    private func onCurrencyAccountChanged(_ index: Int) {
        switch index {
        case 0:
            return selectedAccountCurrency = AccountCurrency.eur.rawValue
        case 1:
            return selectedAccountCurrency = AccountCurrency.usd.rawValue
        case 2:
            return selectedAccountCurrency = AccountCurrency.gbp.rawValue
        default:
            selectedAccountCurrency = AccountCurrency.eur.rawValue
        }
    }
    
    private func configureSubmitButton() {
        let allTextFieldsFilled = availableTextFields.allSatisfy { textField in
            guard let text = textField.text else { return false }
            return !text.isEmpty
        }
        submitButton.isAccesible(isAccesible: allTextFieldsFilled)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        configureSubmitButton()
    }
}

extension RegistrationViewController {
    
    private func displayError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        errorLabel.textColor = .red
    }
    
    private func hideErrorMessage() {
        errorLabel.isHidden = true
    }
    
    private func proceedToHomeScreen() {
        let homeScreen = HomeViewController()
        homeScreen.modalPresentationStyle = .fullScreen
        present(homeScreen, animated: true)
    }
}
