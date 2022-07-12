struct LoginResponseModel {

    let accessToken: String

    init(fromModel model: LoginResponseDataModel) {
        self.accessToken = model.accessToken
    }

}
