import Combine
import UIKit
import SnapKit

class UserViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: UserViewModel!
    private var usernameLabel: UILabel!
    private var usernameTextField: UITextField!
    private var nameLabel: UILabel!
    private var nameTextField: UITextField!
    private var saveButton: UIButton!
    private var logoutButton: UIButton!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: UserViewModel) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        nameTextField.resignFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        logoutButton.layer.cornerRadius = logoutButton.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2

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
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
    }

    @objc private func tappedLogoutButton() {
        viewModel.onLogoutButtonClick()
    }

    @objc private func tappedSaveButton() {
        nameTextField.resignFirstResponder()

        guard let text = nameTextField.text else { return }

        viewModel.onSaveButtonClick(name: text)
    }

    private func getData() {
        viewModel.getData()
    }

    private func bindViewModel() {
        viewModel
            .$account
            .sink { [weak self] account in
                guard let self = self else { return }

                self.usernameTextField.text = account?.email
                self.nameTextField.text = account?.name
            }
            .store(in: &cancellables)
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        usernameLabel = UILabel()
        view.addSubview(usernameLabel)

        usernameTextField = UITextField()
        view.addSubview(usernameTextField)

        nameLabel = UILabel()
        view.addSubview(nameLabel)

        nameTextField = UITextField()
        view.addSubview(nameTextField)

        saveButton = UIButton()
        view.addSubview(saveButton)

        logoutButton = UIButton()
        view.addSubview(logoutButton)
    }

    func styleViews() {
        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.font = .systemFont(ofSize: 12, weight: .bold)

        usernameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.textColor = .white
        usernameTextField.isEnabled = false

        nameLabel.text = "NAME"
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 12, weight: .bold)

        nameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        nameTextField.textColor = .white
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none

        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        saveButton.backgroundColor = .white

        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1), for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        logoutButton.backgroundColor = .white
    }

    func defineLayoutForViews() {
        usernameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(110)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.equalTo(nameTextField.snp.trailing).offset(10)
            $0.width.equalTo(80)
        }

        logoutButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
            $0.height.equalTo(45)
        }
    }

}
