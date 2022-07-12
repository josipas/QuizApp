struct LoginResponseDataModel {

    let accessToken: String

    init(fromModel model: LoginResponseClientModel) {
        self.accessToken = model.accessToken
    }

}
