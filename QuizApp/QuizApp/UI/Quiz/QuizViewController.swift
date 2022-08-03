import Combine
import UIKit

class QuizViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var titleLabel: UILabel!
    private var selectionView: CustomSegmentedControl!
    private var collectionView: UICollectionView!
    private var errorView: ErrorView!
    private var infoLabel: UILabel!
    private var viewModel: QuizViewModel!
    private var cancellables = Set<AnyCancellable>()
    private var quizes: [QuizCategory: [Quiz]] = [:]

    init(viewModel: QuizViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        createViews()
        styleViews()
        defineLayoutForViews()
        loadData()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()
    }

    private func bindViewModel() {
        viewModel
            .$categories
            .sink { [weak self] categories in
                guard let self = self else { return }

                self.selectionView.set(data: categories)
            }
            .store(in: &cancellables)

        viewModel
            .$quizes
            .sink { [weak self] quizes in
                guard let self = self else { return }

                self.infoLabel.isHidden = !quizes.isEmpty
                self.quizes = quizes
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)

        viewModel
            .$hasErrorOcurred
            .sink { [weak self] hasErrorOcurred in
                guard let self = self else { return }

                self.infoLabel.isHidden = true
                self.errorView.isHidden = !hasErrorOcurred
                self.collectionView.isHidden = hasErrorOcurred
            }
            .store(in: &cancellables)
    }

    private func loadData() {
        viewModel.loadData()
    }

    private func configureGradient() {
        let startColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor
        let endColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor

        gradient.frame = view.bounds
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.75, y: 0)
        gradient.endPoint = CGPoint(x: 0.25, y: 1)

        view.layer.insertSublayer(gradient, at: 0)
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical

        return layout
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        selectionView = CustomSegmentedControl()
        view.addSubview(selectionView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        view.addSubview(collectionView)

        errorView = ErrorView()
        view.addSubview(errorView)

        infoLabel = UILabel()
        view.addSubview(infoLabel)
    }

    func styleViews() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "PopQuiz"

        selectionView.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            QuizCollectionViewCell.self,
            forCellWithReuseIdentifier: QuizCollectionViewCell.reuseIdentifier)
        collectionView.register(
            QuizCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: QuizCollectionViewHeader.reuseIdentifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        infoLabel.text = "Sorry! There are no quizzes for this category. 😞"
        infoLabel.numberOfLines = 0
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 16)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(80)
            $0.trailing.leading.equalToSuperview().inset(30)
        }

        selectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(30)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(selectionView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        errorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(90)
        }

        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(90)
        }
    }

}

extension QuizViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        quizes.keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let quizes = quizes[Array(quizes.keys)[section]] else { return 0 }

        return quizes.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizCollectionViewCell.reuseIdentifier,
                for: indexPath) as? QuizCollectionViewCell
        else { fatalError() }

        let category = Array(quizes.keys)[indexPath.section]

        guard let quizes = quizes[category] else { return cell }

        let quiz = quizes[indexPath.row]

        cell.set(
            title: quiz.name,
            description: quiz.description,
            color: quiz.category.color,
            difficulty: quiz.difficulty,
            imageUrl: quiz.imageUrl)

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        quizes.keys.count < 2 ? .zero : CGSize(width: 0, height: 50)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let cell = collectionView
                    .dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: QuizCollectionViewHeader.reuseIdentifier,
                        for: indexPath) as? QuizCollectionViewHeader
            else { fatalError() }

            cell.set(category: Array(quizes.keys)[indexPath.section])

            return cell
        default:
            fatalError()
        }
    }

}

extension QuizViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Array(quizes.keys)[indexPath.section]

        guard let quizes = quizes[category] else { return }

        let quiz = quizes[indexPath.row]

        viewModel.onQuizSelected(quiz)
    }

}

extension QuizViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width - 40, height: 140)
    }

}

extension QuizViewController: CustomSegmentedControlDelegate {

    func segmentTapped(id: Any) {
        guard let category = id as? QuizCategory else { return }

        viewModel.onCategorySelected(category)
    }

}
