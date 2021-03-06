class UserViewModel {

    private let coordinator: CoordinatorProtocol
    private let userUseCase: UserUseCaseProtocol

    init(coordinator: CoordinatorProtocol, userUseCase: UserUseCaseProtocol) {
        self.coordinator = coordinator
        self.userUseCase = userUseCase
    }

    func onButtonClick() {
        do {
            try userUseCase.logOut()
        } catch {
        }
        coordinator.showLogIn()
    }

}
