import Combine
import UIKit

class LoginViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: LoginViewModel!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
    private var emailInputTextField: CustomInputFieldView!
    private var passwordInputTextField: CustomInputFieldView!
    private var errorLabel: UILabel!
    private var loginButton: UIButton!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        addActions()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loginButton.layer.cornerRadius = loginButton.bounds.height / 2

        configureGradient()
    }

    private func bindViewModel() {
        viewModel
            .$isButtonEnabled
            .sink { [weak self] isLoginEnabled in
                guard let self = self else { return }

                isLoginEnabled ? self.enableLoginButton() : self.disableLoginButton()
            }
            .store(in: &cancellables)

        viewModel
            .$errorMessage
            .sink { [weak self] errorMessage in
                guard let self = self else { return }

                self.errorLabel.isHidden = errorMessage.isEmpty
                self.errorLabel.text = errorMessage
            }
            .store(in: &cancellables)
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
        viewModel.onButtonClick()
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        stackView = UIStackView()
        contentView.addSubview(stackView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)

        emailInputTextField = CustomInputFieldView(type: .email)
        stackView.addArrangedSubview(emailInputTextField)

        passwordInputTextField = CustomInputFieldView(type: .password)
        stackView.addArrangedSubview(passwordInputTextField)

        errorLabel = UILabel()
        stackView.addArrangedSubview(errorLabel)

        loginButton = UIButton()
        stackView.addArrangedSubview(loginButton)
    }

    func styleViews() {
        navigationController?.isNavigationBarHidden = true

        emailInputTextField.delegate = self
        passwordInputTextField.delegate = self

        stackView.axis = .vertical
        stackView.spacing = 18

        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "PopQuiz"

        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0

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

        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(140)
            $0.trailing.leading.bottom.equalToSuperview().inset(30)
        }

        loginButton.snp.makeConstraints {
            $0.height.equalTo(45)
        }
    }

}

extension LoginViewController: CustomInputFieldDelegate {

    func reportChanges(_ type: CustomInputFieldType, _ text: String) {
        switch type {
        case .email:
            viewModel.onEmailChange(email: text)
        case .password:
            viewModel.onPasswordChange(password: text)
        }
    }

}
