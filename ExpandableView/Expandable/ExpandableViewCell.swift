//
//  ExpandableViewCell.swift
//  Raffek
//
//  Created by Asraful Alam on 12/3/21.
//

import Foundation
import UIKit
class EzpandableViewCell: UITableViewCell {
    
    var title: String? {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let thumbImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "thumbimage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUPView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUPView(){
        topStackView.addArrangedSubview(thumbImageView)
        topStackView.addArrangedSubview(titleLabel)
        addSubview(topStackView)
        constraints()
    }
    
    private func constraints(){
        topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        topStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        topStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        topStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        thumbImageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
    }
}


