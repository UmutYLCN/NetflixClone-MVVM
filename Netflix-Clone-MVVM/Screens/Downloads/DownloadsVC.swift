//
//  DownloadVC.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 13.09.2023.
//

import UIKit

class DownloadsVC: UIViewController {

    private var downloadTable = UITableView()

    private var titles : [TitleItem] = [TitleItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
       
    }

    func configure(){
        title = "Upcoming"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        cDownloadTable()
        fetchLocalStorageForDownload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
                   self.fetchLocalStorageForDownload()
    }
    }
    func cDownloadTable(){
        view.addSubview(downloadTable)
        downloadTable.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        downloadTable.dataSource = self
        downloadTable.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownload(){
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                self?.downloadTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension DownloadsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unkown title name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           switch editingStyle {
           case .delete:
               
               DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in
                   switch result {
                   case .success():
                       print("Deleted fromt the database")
                   case .failure(let error):
                       print(error.localizedDescription)
                   }
                   self?.titles.remove(at: indexPath.row)
                   tableView.deleteRows(at: [indexPath], with: .fade)
               }
           default:
               break;
           }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let title = titles[indexPath.row]
            
            guard let titleName = title.original_title ?? title.original_name else {
                return
            }
            
            
            APICaller.shared.YoutubeSearch(with: titleName) { [weak self] result in
                switch result {
                case .success(let videoElement):
                    DispatchQueue.main.async {
                        let vc = TitlePreviewVC()
                        vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }

                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
}
