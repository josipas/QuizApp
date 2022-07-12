class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(loginDataSource: loginDataSource, userDataSource: userDataSource)
    }()

    lazy var userDataSource: UserDataSourceProtocol = {
        UserDataSource(securityStorage: securityStorage)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LoginDataSource(loginClient: loginClient)
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(baseUrl: baseUrl)
    }()

    lazy var securityStorage: SecurityStorageProtocol = {
        SecurityStorage()
    }()

}
