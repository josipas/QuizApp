class AppDependencies {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api"

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(loginDataSource: loginDataSource, userDataSource: userDataSource)
    }()

    lazy var userUseCase: UserUseCaseProtocol = {
        UserUseCase(userDataSource: userDataSource)
    }()

    lazy var quizUseCase: QuizUseCaseProtocol = {
        QuizUseCase(quizDataSource: quizDataSource)
    }()

    lazy var userDataSource: UserDataSourceProtocol = {
        UserDataSource(securityStorage: securityStorage, accountClient: accountClient)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LoginDataSource(loginClient: loginClient)
    }()

    lazy var quizDataSource: QuizDataSourceProtocol = {
        QuizDataSource(quizClient: quizClient)
    }()

    lazy var networkClient: NetworkClientProtocol = {
        NetworkClient(baseUrl: baseUrl, securityStorage: securityStorage)
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(networkClient: networkClient)
    }()

    lazy var tokenCheckClient: TokenCheckClientProtocol = {
        TokenCheckClient(networkClient: networkClient)
    }()

    lazy var accountClient: AccountClientProtocol = {
        AccountClient(networkClient: networkClient)
    }()

    lazy var quizClient: QuizClientProtocol =  {
        QuizClient(networkClient: networkClient)
    }()

    lazy var securityStorage: SecurityStorageProtocol = {
        SecurityStorage()
    }()

}
