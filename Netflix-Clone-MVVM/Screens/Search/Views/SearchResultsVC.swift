//
//  SearchResultsVC.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 14.09.2023.
//

import UIKit


protocol SearchResultsVCDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsVC: UIViewController {

    public var titles : [Title] = [Title]()
    
    public weak var delegate : SearchResultsVCDelegate?
    
    public let searchResultsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    private func downloadTitleAt(indexPath : IndexPath) {
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            switch result {
                
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


extension SearchResultsVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? title.original_name ?? ""
    
        APICaller.shared.YoutubeSearch(with: titleName) { [weak self] result in
            switch result {
            
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            
            let config = UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: nil) {[weak self] _ in
                    let downloadAction = UIAction(title: "Download", subtitle: nil, image: UIImage(systemName: "arrow.down.to.line"), identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                        self?.downloadTitleAt(indexPath: indexPath)
                    }
                    return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
                }
            
            return config
        }
}
