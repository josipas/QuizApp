import UIKit

public enum CustomInputFieldType {

    case email
    case password

    public var description: String? {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }

}

class CustomInputFieldView: UIView {

    var inputTextField: UITextField!
    var imageView: UIImageView!
    var type: CustomInputFieldType?

    init(type: CustomInputFieldType) {
        super.init(frame: .zero)

        self.type = type

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CustomInputFieldView: ConstructViewsProtocol {

    func createViews() {
        inputTextField = UITextField()
        imageView = UIImageView()
    }

    func styleViews() {
        inputTextField.placeholder = type?.description
        imageView.image = UIImage(systemName: "eye.fill")
    }

    func defineLayoutForViews() {

    }

}
