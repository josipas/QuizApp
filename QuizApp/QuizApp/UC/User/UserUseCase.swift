protocol UserUseCaseProtocol {

    func logOut()

}

class UserUseCase: UserUseCaseProtocol {

    private let userDataSource: UserDataSourceProtocol

    init(userDataSource: UserDataSourceProtocol) {
        self.userDataSource = userDataSource
    }

    func logOut() {
        userDataSource.clearToken()
    }
}
