protocol CoordinatorProtocol {

    func showLogIn()

    func showTabBar()

    func showLeaderboard(_ quizId: Int)

    func dismiss()

    func showQuizDetails(of quiz: Quiz)

    func goBack()

}
