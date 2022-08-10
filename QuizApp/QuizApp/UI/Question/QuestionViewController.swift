import UIKit

class QuestionViewController: UIViewController {

    private var viewModel: QuestionViewModel!

    init(viewModel: QuestionViewModel) {
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
