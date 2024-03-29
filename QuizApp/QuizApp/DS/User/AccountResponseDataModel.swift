struct AccountResponseDataModel {

    let email: String
    let id: Int
    let name: String

}

extension AccountResponseDataModel {

    init(from model: AccountResponseClientModel) {
        self.email =  model.email
        self.id = model.id
        self.name = model.name
    }

}
