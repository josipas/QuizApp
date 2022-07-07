import UIKit

class LoginViewController: UIViewController {

    private let gradient = CAGradientLayer()
    private var titleLabel: UILabel!
    private var emailInputTextField: CustomInputFieldView!
    private var passwordInputTextField: CustomInputFieldView!
    private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let startColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor
        let endColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor

        gradient.frame = view.bounds
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.75, y: 0)
        gradient.endPoint = CGPoint(x: 0.25, y: 1)

        view.layer.insertSublayer(gradient, at: 0)

        loginButton.layer.cornerRadius = loginButton.bounds.height / 2
    }
}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        emailInputTextField = CustomInputFieldView(type: .email)
        view.addSubview(emailInputTextField)

        passwordInputTextField = CustomInputFieldView(type: .password)
        view.addSubview(passwordInputTextField)

        loginButton = UIButton()
        view.addSubview(loginButton)
    }

    func styleViews() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "PopQuiz"

        loginButton.backgroundColor = .white
        loginButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        loginButton.setTitle("Login", for: .normal)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.trailing.leading.equalToSuperview().inset(30)
        }

        emailInputTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(140)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        passwordInputTextField.snp.makeConstraints {
            $0.top.equalTo(emailInputTextField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordInputTextField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(45)
        }
    }

}
