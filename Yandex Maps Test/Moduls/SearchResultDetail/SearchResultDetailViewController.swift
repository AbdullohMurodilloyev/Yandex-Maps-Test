import UIKit

class SearchResultDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let detailView = SearchResultDetailView()
    private let viewModel: SearchResultDetailViewModel
    private let searchResult: SearchResult
    
    // MARK: - Init
    init(viewModel: SearchResultDetailViewModel, searchResult: SearchResult) {
        self.viewModel = viewModel
        self.searchResult = searchResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
    }
    
    private func setupView() {
        view.addSubview(detailView)
        detailView.delegate = self
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureView() {
        detailView.configure(
            with: searchResult.name,
            address: searchResult.address
        )
    }
}

// MARK: - SearchResultDetailViewDelegate
extension SearchResultDetailViewController: SearchResultDetailViewDelegate {
    func tappedFavoriteAddressAlert() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.viewModel.presentAlert(searchResult: self.searchResult)
        }
    }
}
