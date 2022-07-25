protocol UserUseCaseProtocol {

    func logOut() throws

    var data: AccountModel { get async throws }

    func updateData(name: String) async throws -> AccountModel

}

class UserUseCase: UserUseCaseProtocol {

    private let userDataSource: UserDataSourceProtocol

    var data: AccountModel {
        get async throws {
            AccountModel(from: try await userDataSource.data)
        }
    }

    init(userDataSource: UserDataSourceProtocol) {
        self.userDataSource = userDataSource
    }

    func logOut() throws {
        try userDataSource.clearAccessToken()
    }

    func updateData(name: String) async throws -> AccountModel {
        return AccountModel(from: try await userDataSource.updateData(name: name))
    }

}
