class LoginViewModel {
    var isButtonEnabled = false
    private var email: String!
    private var password: String!

    func onEmailChange(email: String) {
        self.email = email

        validate()
    }

    func onPasswordChange(password: String) {
        self.password = password

        validate()
    }

    func validate() {
        if
            let email = email,
            !email.isEmpty,
            let password = password,
            !password.isEmpty {
                isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }

        print(isButtonEnabled)
    }
}
