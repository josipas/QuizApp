import Combine
import UIKit

class QuizSessionViewController: UIViewController {

    private var viewModel: QuizSessionViewModel!
    private var titleLabel: UILabel!
    private var backButtonImage: UIImage!
    private var progressLabel: UILabel!
    private var progressView: ProgressView!
    private var collectionView: UICollectionView!
    private var cancellables = Set<AnyCancellable>()
    private var numberOfQuestions = 0
    private var questions: [Question] = []

    init(viewModel: QuizSessionViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()
    }

    @objc func backButtonTapped() {
        viewModel.onBackButtonClick()
    }

    private func loadData() {
        viewModel.loadData()
    }

    private func bindViewModel() {
        viewModel
            .$questions
            .sink { [weak self] questions in
                guard let self = self else { return }

                let numberOfQuestions = questions.count
                self.numberOfQuestions = numberOfQuestions
                if numberOfQuestions > 0 {
                    self.progressView.set(colors: questions.map { $0.progressColor })
                    self.progressView.setNeedsLayout()
                }
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)

        viewModel
            .$currentQuestionIndex
            .sink { [weak self] currentQuestionIndex in
                guard let self = self else { return }

                self.progressLabel.text = "\(currentQuestionIndex+1)/\(self.numberOfQuestions)"
            }
            .store(in: &cancellables)
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

    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        return layout
    }

}

extension QuizSessionViewController: ConstructViewsProtocol {

    func createViews() {
        progressLabel = UILabel()
        view.addSubview(progressLabel)

        progressView = ProgressView()
        view.addSubview(progressView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        view.addSubview(collectionView)
    }

    func styleViews() {
        progressLabel.textColor = .white
        progressLabel.font = .systemFont(ofSize: 18, weight: .bold)

//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.register(
            QuizSessionCollectionViewCell.self,
            forCellWithReuseIdentifier: QuizSessionCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
    }

    func defineLayoutForViews() {
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        progressView.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
    }

}

extension QuizSessionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questions.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizSessionCollectionViewCell.reuseIdentifier,
                for: indexPath) as? QuizSessionCollectionViewCell
        else { fatalError() }

        cell.set(question: questions[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 400)
    }

}
