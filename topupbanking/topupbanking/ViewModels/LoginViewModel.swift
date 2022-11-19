
import Foundation

final class LoginViewModel {
    
    
    func loginOrRegisterUser(segment: LoginViewController.SegmentMode) {
        switch segment {
        case .login:
            login()
        case .register:
            register()
        }
    }
    
    func login() {
        
    }
    
    func register() {
        
    }
    
}
