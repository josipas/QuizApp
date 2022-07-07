enum CustomInputFieldType {

    case email
    case password

    var description: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }

}
