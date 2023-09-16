//
//  HeroHeaderUIView.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 13.09.2023.
//

import UIKit
import SnapKit

class HeroHeaderUIView: UIView {

    private let downloadButton : UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let playButton : UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
        
    }
    
    
    private func applyConstraints(){
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(70)
            make.bottom.equalTo(-50)
            make.width.equalTo(120)
        }
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(-70)
            make.bottom.equalTo(-50)
            make.width.equalTo(120)
        }
    }
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "\(NetworkConstant.shared.imageServerAddress)\(model.posterURL)") else {return}
        
        heroImageView.sd_setImage(with: url,completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
