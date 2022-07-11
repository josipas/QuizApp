import Combine
import UIKit

class LoginViewModel {

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email = ""
    private var password = ""

    func onEmailChange(email: String) {
        self.email = email

        validate()
    }

    func onPasswordChange(password: String) {
        self.password = password

        validate()
    }

    private func validateEmail() -> Bool {
        let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regexEmail).evaluate(with: email)
    }

    private func validatePassword() -> Bool {
        return password.count >= 8 ? true : false
    }

    private func validate() {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()

        if isEmailValid && isPasswordValid {
            errorMessage = ""
            isButtonEnabled = true
        } else if isEmailValid && !isPasswordValid {
            isButtonEnabled = false
            errorMessage = "Please enter correct password"
        } else if !isEmailValid && isPasswordValid {
            isButtonEnabled = false
            errorMessage = "Please enter correct email"
        } else {
            isButtonEnabled = false
            errorMessage = "Please enter correct email and password"
        }
    }

}
