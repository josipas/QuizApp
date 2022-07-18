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

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(baseUrl: baseUrl)
    }()

    lazy var tokenCheckClient: TokenCheckClientProtocol = {
        TokenCheckClient(baseUrl: baseUrl, securityStorage: securityStorage)
    }()

    lazy var accountClient: AccountClientProtocol = {
        AccountClient(baseUrl: baseUrl, securityStorage: securityStorage)
    }()

    lazy var securityStorage: SecurityStorageProtocol = {
        SecurityStorage()
    }()

}
