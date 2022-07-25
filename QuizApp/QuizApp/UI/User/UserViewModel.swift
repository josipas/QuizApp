import Combine

class UserViewModel {

    private let coordinator: CoordinatorProtocol
    private let userUseCase: UserUseCaseProtocol

    @Published var account = AccountModel(email: "", id: 0, name: "")

    init(coordinator: CoordinatorProtocol, userUseCase: UserUseCaseProtocol) {
        self.coordinator = coordinator
        self.userUseCase = userUseCase
    }

    func onLogoutButtonClick() {
        do {
            try userUseCase.logOut()
            coordinator.showLogIn()
        } catch {
        }
    }

    func onSaveButtonClick(name: String) {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.account = try await userUseCase.updateData(name: name)
            } catch {
            }
        }
    }

    @MainActor
    func getData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.account = try await userUseCase.data
            } catch {
            }
        }
    }

}
