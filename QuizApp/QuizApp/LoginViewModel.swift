import Combine
import UIKit

class LoginViewModel {

    private let loginUseCase = LoginUseCase()

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email = ""
    private var password = ""

    func onEmailChange(email: String) {
        self.email = email

        errorMessage =  ""

        validate()
    }

    func onPasswordChange(password: String) {
        self.password = password

        errorMessage = ""

        validate()
    }

    func onButtonClick() {
        Task(priority: .background) {
            await authorize()
        }
    }

    private func validateEmail() -> Bool {
        let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regexEmail).evaluate(with: email)
    }

    private func validatePassword() -> Bool {
        password.count >= 6
    }

    private func validate() {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()

        isButtonEnabled = isEmailValid && isPasswordValid
    }

    private func authorize() async {
        let accessToken = await loginUseCase.login(username: email, password: password)

        if let accessToken = accessToken {
            print(accessToken)
        } else {
            errorMessage = "Please enter correct email and password"
        }
    }

}
