import UIKit

class QuizSessionViewController: UIViewController {

    private var viewModel: QuizSessionViewModel!

    init(viewModel: QuizSessionViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        viewModel.loadData()
    }

}
