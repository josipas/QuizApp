protocol CoordinatorProtocol {

    func showLogIn()

    func showTabBarController()

    func showLeaderboardViewController(_ quizId: Int)

    func dismiss()

    func showQuizDetails(of quiz: Quiz)

    func goBack()

}
