//
//  TitleTableViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by umut yalçın on 14.09.2023.
//

import UIKit
import SnapKit
import SDWebImage

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"

    
    private let playTitleButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let titlesPosterUIImageView : UIImageView = {
        let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints(){
        titlesPosterUIImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titlesPosterUIImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        playTitleButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "\(NetworkConstant.shared.imageServerAddress)\(model.posterURL)") else {return}
        titlesPosterUIImageView.sd_setImage(with: url,completed: nil)
        titleLabel.text = model.titleName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
