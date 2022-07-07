import UIKit

class LoginViewController: UIViewController {

    private var emailInputTextField: CustomInputFieldView!
    private var passwordInputTextField: CustomInputFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        emailInputTextField = CustomInputFieldView(type: .email)
        view.addSubview(emailInputTextField)

        passwordInputTextField = CustomInputFieldView(type: .password)
        view.addSubview(passwordInputTextField)
    }

    func styleViews() {
        view.backgroundColor = .purple
    }

    func defineLayoutForViews() {
        emailInputTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(140)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        passwordInputTextField.snp.makeConstraints {
            $0.top.equalTo(emailInputTextField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }

}
