protocol LeaderboardClientProtocol {

    func getLeaderboard(for quizId: Int) async throws -> [LeaderboardResponseClientModel]

}

class LeaderboardClient {

    private let path = "/v1/quiz/leaderboard"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getLeaderboard(for quizId: Int) async throws -> [LeaderboardResponseClientModel] {
        try await networkClient.executeRequest(path: path, method: .get, parameters: ["quizId": String(quizId)])
    }

}
