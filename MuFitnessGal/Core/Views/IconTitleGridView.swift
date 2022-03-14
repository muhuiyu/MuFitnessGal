//
//  IconTitleGridView.swift
//  Anki CopyCat
//
//  Created by Mu Yu on 13/1/21.
//

import UIKit

class IconTitleGridView: UIView {
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    var text: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        addSubview(stackView)
        
        
        stackView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
