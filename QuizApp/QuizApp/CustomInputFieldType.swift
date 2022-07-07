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
