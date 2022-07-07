import UIKit
import SnapKit

class CustomInputFieldView: UIView {

    private var inputTextField: UITextField!
    private var showPasswordButton: UIButton!
    private var type: CustomInputFieldType!

    init(type: CustomInputFieldType) {
        super.init(frame: .zero)

        self.type = type

        createViews()
        styleViews()
        defineLayoutForViews()
        addActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

}

extension CustomInputFieldView: ConstructViewsProtocol {

    func createViews() {
        inputTextField = UITextField()
        addSubview(inputTextField)

        showPasswordButton = UIButton()
        addSubview(showPasswordButton)
    }

    func styleViews() {
        guard let placeholder = type.description else { return }

        backgroundColor = .white.withAlphaComponent(0.3)

        showPasswordButton.isHidden = true
        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showPasswordButton.imageView?.contentMode = .scaleAspectFit
        showPasswordButton.tintColor = .white

        inputTextField.delegate = self
        inputTextField.textColor = .white
        inputTextField.tintColor = .white
        inputTextField.font = .systemFont(ofSize: 16, weight: .bold)
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]
        )

        if type == .password {
            inputTextField.isSecureTextEntry = true
        }
    }

    func defineLayoutForViews() {
        snp.makeConstraints {
            $0.height.equalTo(45)
        }

        inputTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(showPasswordButton.snp.leading).offset(-20)
            $0.centerY.equalToSuperview()
        }

        showPasswordButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
        }
    }

    func addActions() {
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        showPasswordButton.addTarget(self, action: #selector(tappedShowPasswordButton), for: .touchUpInside)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = inputTextField.text else { return }

        if !text.isEmpty && type == .password {
            showPasswordButton.isHidden = false
        }
    }

    @objc private func tappedShowPasswordButton() {
        if inputTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }

        inputTextField.isSecureTextEntry.toggle()
    }

}

extension CustomInputFieldView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0

        if type == .password {
            showPasswordButton.isHidden = true
        }
    }

}
