enum CustomInputFieldType {

    case email
    case password
    case basic

    var description: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .basic:
            return "Type here"
        }
    }

}
