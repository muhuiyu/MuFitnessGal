//
//  PagniationIndicator.swift
//  Lango
//
//  Created by Mu Yu on 31/1/21.
//

import UIKit

class PagniationIndicator: UIView {
    private let stackView = UIStackView()
    
    var currentPage: Int? {
        didSet {
            
        }
    }
    var numberOfPages: Int? {
        didSet {
            
        }
    }
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(stackView)
        reconfigureViews()
        configureGestures()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension PagniationIndicator {
    private func reconfigureViews() {
//        stackView.removeArrangedSubview(<#T##view: UIView##UIView#>)
//        for i in 0...numberOfPages {
//            if i == currentPage {
//
//            }
//            stackView.addArrangedSubview(<#T##view: UIView##UIView#>)
//        }
        
    }
    private func configureGestures() {
        
    }
    private func configureConstraints() {
        
    }
}
