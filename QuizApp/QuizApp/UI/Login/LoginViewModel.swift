import Combine
import UIKit

class LoginViewModel {

    private let loginUseCase: LoginUseCaseProtocol

    @Published var isButtonEnabled = false
    @Published var errorMessage = ""

    private var email = ""
    private var password = ""

    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }

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

    @MainActor
    func onButtonClick() {
        errorMessage = ""
        Task(priority: .background) {
            do {
                let response = try await loginUseCase.login(username: email, password: password)
                print("token", response.accessToken)
            } catch RequestError.unauthorized {
                errorMessage = "Invalid credentials!"
            } catch {
                errorMessage = "General error! \(error)"
            }
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

}
