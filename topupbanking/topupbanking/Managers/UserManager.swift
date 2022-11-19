
import Foundation

struct UserManager {
    
    func login(phone: String?, password: String?) throws {
        
        try LoginViewModel.checkIsNotEmpty(phone, password: password)
        try LoginViewModel.checkIsPasswordMatchesWithCredentials(phone, password)
        
    }
    
    func register(phone: String?, password: String?, confirmPassword: String?) throws {
        try LoginViewModel.checkIstextfieldsAreNotEmpty(phoneNo: phone, password: password, confirmPassword: confirmPassword)
        try LoginViewModel.checkIsPhoneNumberUnique(phone)
        try LoginViewModel.checkIsPasswordSecure(password: password ?? "")
        try LoginViewModel.checkIsPasswordMatches(password: password, confirmPassword: confirmPassword)
    }
}
