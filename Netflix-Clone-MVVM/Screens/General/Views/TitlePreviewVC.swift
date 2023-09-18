//
//  TitlePreviewViewController.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 15.09.2023.
//

import UIKit
import WebKit
import SnapKit

class TitlePreviewVC: UIViewController {

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Poter"
        return label
    }()
    
    private let overviewLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid"
        return label
    }()
    
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView : WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    
    func SetupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configureConstraints()
    }
    
    func configureConstraints(){
        webView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(20)
            make.leading.equalTo(20)
            
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(20)
            make.trailing.equalToSuperview()
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
    }
    
    func configure(with model: TitlePreviewViewModel){
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    

}
