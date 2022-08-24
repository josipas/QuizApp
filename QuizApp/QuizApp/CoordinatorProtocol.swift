protocol CoordinatorProtocol {

    func showLogIn()

    func showHome()

    func showLeaderboard(quizId: Int)

    func hideLeaderboard()

    func showQuizDetails(of quiz: Quiz)

    func goBack()

    func showQuiz(quizId: Int)

    func showQuizResult(session: EndSessionData)

}
