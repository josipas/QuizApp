struct AccountModel {

    let email: String
    let id: Int
    let name: String

}

extension AccountModel {

    init(from model: AccountResponseDataModel) {
        self.email = model.email
        self.id = model.id
        self.name = model.name
    }

}
