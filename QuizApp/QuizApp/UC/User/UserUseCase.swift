protocol UserUseCaseProtocol {

    func logOut() throws

    func getData() async throws -> AccountModel

    func updateData()

}

class UserUseCase: UserUseCaseProtocol {

    private let userDataSource: UserDataSourceProtocol

    init(userDataSource: UserDataSourceProtocol) {
        self.userDataSource = userDataSource
    }

    func logOut() throws {
        try userDataSource.clearAccessToken()
    }

    func getData() async throws -> AccountModel {
        let accountModel = try await userDataSource.getData()
        return AccountModel(from: accountModel)
    }

    func updateData() {

    }

}
