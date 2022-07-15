protocol UserUseCaseProtocol {

    func logOut() throws

}

class UserUseCase: UserUseCaseProtocol {

    private let userDataSource: UserDataSourceProtocol

    init(userDataSource: UserDataSourceProtocol) {
        self.userDataSource = userDataSource
    }

    func logOut() throws {
        try userDataSource.clearAccessToken()
    }

}
