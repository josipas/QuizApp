protocol CoordinatorProtocol {

    func showLogIn()

    func showTabBarController()

    func showQuizDetailsController(_ quiz: Quiz)

    func back()

    func showLeaderboardViewController(_ quizId: Int)

    func dismiss()

}
