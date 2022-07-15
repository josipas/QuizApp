import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
    }

    func styleViews() {
        view.backgroundColor = .blue
    }

    func defineLayoutForViews() {
    }

}
