import Combine

class UserViewModel {

    private let coordinator: CoordinatorProtocol
    private let userUseCase: UserUseCaseProtocol

    @Published var account: AccountModel!

    init(coordinator: CoordinatorProtocol, userUseCase: UserUseCaseProtocol) {
        self.coordinator = coordinator
        self.userUseCase = userUseCase
    }

    func onLogoutButtonClick() {
        do {
            try userUseCase.logOut()
        } catch {
        }
        coordinator.showLogIn()
    }

    func onSaveButtonClick(name: String) {
        Task(priority: .background) {
            do {
                try await userUseCase.updateData(name: name)
            } catch {
            }
        }
    }

    @MainActor
    func getData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                let account = try await userUseCase.getData()
                self.account = account
            } catch {
            }
        }
    }

    func updateData(name: String) {
        Task(priority: .background) {
            do {
                try await userUseCase.updateData(name: name)
            } catch {
            }
        }
    }

}
