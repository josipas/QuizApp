class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(loginDataSource: loginDataSource, userDataSource: userDataSource)
    }()

    lazy var userUseCase: UserUseCaseProtocol = {
        UserUseCase(userDataSource: userDataSource)
    }()

    lazy var userDataSource: UserDataSourceProtocol = {
        UserDataSource(securityStorage: securityStorage, accountClient: accountClient)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LoginDataSource(loginClient: loginClient)
    }()

    lazy var networkClient: NetworkClientProtocol = {
        NetworkClient(baseUrl: baseUrl)
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(networkClient: networkClient)
    }()

    lazy var tokenCheckClient: TokenCheckClientProtocol = {
        TokenCheckClient(securityStorage: securityStorage, networkClient: networkClient)
    }()

    lazy var accountClient: AccountClientProtocol = {
        AccountClient(securityStorage: securityStorage, networkClient: networkClient)
    }()

    lazy var securityStorage: SecurityStorageProtocol = {
        SecurityStorage()
    }()

}
