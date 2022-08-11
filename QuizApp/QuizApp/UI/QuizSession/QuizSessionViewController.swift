import UIKit

class QuizSessionViewController: UIViewController {

    private var viewModel: QuizSessionViewModel!
    private var titleLabel: UILabel!
    private var backButtonImage: UIImage!

    init(viewModel: QuizSessionViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
//      viewModel.loadData()
        setUpNavBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()
    }

    @objc func backButtonTapped() {
        viewModel.onBackButtonClick()
    }

    private func setUpNavBar() {
        titleLabel = UILabel()
        titleLabel.text = "Pop Quiz"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        navigationItem.titleView = titleLabel

        backButtonImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backItem
        navigationController?.isNavigationBarHidden = false
    }

}
