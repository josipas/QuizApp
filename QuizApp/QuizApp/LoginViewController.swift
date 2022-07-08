import UIKit

class LoginViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var emailInputTextField: CustomInputFieldView!
    private var passwordInputTextField: CustomInputFieldView!
    private var loginButton: UIButton!
    private var email: String!
    private var password: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        addActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loginButton.layer.cornerRadius = loginButton.bounds.height / 2

        configureGradient()
    }

    private func configureGradient() {
        let startColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor
        let endColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor

        gradient.frame = view.bounds
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.75, y: 0)
        gradient.endPoint = CGPoint(x: 0.25, y: 1)

        view.layer.insertSublayer(gradient, at: 0)
    }

    private func addActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    private func enableLoginButton() {
        loginButton.isEnabled = true
        loginButton.alpha = 1
    }

    private func disableLoginButton() {
        loginButton.isEnabled = false
        loginButton.alpha = 0.6
    }

    @objc private func loginButtonTapped() {
        print("Login button tapped!")
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)

        emailInputTextField = CustomInputFieldView(type: .email)
        contentView.addSubview(emailInputTextField)

        passwordInputTextField = CustomInputFieldView(type: .password)
        contentView.addSubview(passwordInputTextField)

        loginButton = UIButton()
        contentView.addSubview(loginButton)
    }

    func styleViews() {
        emailInputTextField.delegate = self
        passwordInputTextField.delegate = self

        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "PopQuiz"

        loginButton.backgroundColor = .white
        loginButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = false
        loginButton.alpha = 0.6
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }

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
            $0.bottom.equalToSuperview().inset(100)
            $0.height.equalTo(45)
        }
    }

}

extension LoginViewController: CustomInputFieldDelegate {

    func reportChanges(_ type: CustomInputFieldType, _ text: String) {
        switch type {
        case .email:
            email = text
        case .password:
            password = text
        }

        if
            let email = email,
            !email.isEmpty,
            let password = password,
            !password.isEmpty {
                enableLoginButton()
        } else {
            disableLoginButton()
        }
    }

}
