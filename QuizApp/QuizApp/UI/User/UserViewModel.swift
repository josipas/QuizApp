import Combine

class UserViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: UserUseCaseProtocol

    @Published var account = AccountModel(email: "", id: 0, name: "")

    init(coordinator: CoordinatorProtocol, useCase: UserUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    func onLogoutButtonClick() {
        do {
            try useCase.logOut()
            coordinator.showLogIn()
        } catch {
        }
    }

    @MainActor
    func onSaveButtonClick(name: String) {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.account = try await useCase.updateData(name: name)
            } catch {
            }
        }
    }

    @MainActor
    func getData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.account = try await useCase.data
            } catch {
            }
        }
    }

}
