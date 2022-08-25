import Combine
import UIKit
import SnapKit

class QuizResultViewController: UIViewController {

    private var viewModel: QuizResultViewModel!
    private var resultLabel: UILabel!
    private var submitButton: UIButton!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: QuizResultViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
        loadData()
    }

    @objc func submitButtonTapped() {
        viewModel.onSubmitButtonTap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()

        submitButton.layer.cornerRadius = submitButton.bounds.height / 2
    }

    private func loadData() {
        viewModel.loadData()
    }

    private func bindViewModel() {
        viewModel
            .$result
            .sink { [weak self] result in
                guard let self = self else { return }

                self.resultLabel.text = result
            }
            .store(in: &cancellables)
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {
        resultLabel = UILabel()
        view.addSubview(resultLabel)

        submitButton = UIButton()
        view.addSubview(submitButton)
    }

    func styleViews() {
        resultLabel.font = .systemFont(ofSize: 88, weight: .bold)
        resultLabel.textColor = .white

        submitButton.backgroundColor = .white
        submitButton.setTitle("Finish Quiz", for: .normal)
        submitButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        submitButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        resultLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        submitButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(45)
            $0.height.equalTo(45)
        }
    }

}
