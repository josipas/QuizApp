import Combine
import UIKit
import SnapKit

class SearchViewController: UIViewController {

    private var searchTextField: CustomInputFieldView!
    private var searchButton: UIButton!
    private var collectionView: UICollectionView!
    private var viewModel: SearchViewModel!
    private var infoLabel: UILabel!
    private var errorView: ErrorView!
    private var cancellables = Set<AnyCancellable>()
    private var searchText: String = ""
    private var quizes: [QuizCategory: [Quiz]] = [:]

    init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()
    }

    @objc func searchButtonTapped() {
        viewModel.onSearchButtonTap(text: searchText)
    }

    private func bindViewModel() {
        viewModel
            .$filteredQuizes
            .sink { [weak self] quizes in
                guard let self = self else { return }

                self.infoLabel.isHidden = self.searchText.isEmpty ? true : !quizes.isEmpty
                self.infoLabel.text = "Sorry! There are no quizzes! 😞"
                self.quizes = quizes
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)

        viewModel
            .$hasErrorOccurred
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

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical

        return layout
    }

}

extension SearchViewController: ConstructViewsProtocol {

    func createViews() {
        searchTextField = CustomInputFieldView(type: .basic)
        view.addSubview(searchTextField)

        searchButton = UIButton()
        view.addSubview(searchButton)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        view.addSubview(collectionView)

        infoLabel = UILabel()
        view.addSubview(infoLabel)

        errorView = ErrorView()
        view.addSubview(errorView)
    }

    func styleViews() {
        searchTextField.delegate = self

        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

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

        infoLabel.numberOfLines = 0
        infoLabel.textColor = .white
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 16)
    }

    func defineLayoutForViews() {
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.leading.equalToSuperview().inset(20)
        }

        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(searchTextField)
            $0.leading.equalTo(searchTextField.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(90)
        }

        errorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(90)
        }
    }

}

extension SearchViewController: CustomInputFieldDelegate {

    func reportChanges(_ type: CustomInputFieldType, _ text: String) {
        searchText = text
    }

}

extension SearchViewController: UICollectionViewDataSource {

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
        CGSize(width: 0, height: 50)
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

extension SearchViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = Array(quizes.keys)[indexPath.section]

        guard let quizes = quizes[category] else { return }

        let quiz = quizes[indexPath.row]

        viewModel.onQuizSelected(quiz)
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width - 40, height: 140)
    }

}
