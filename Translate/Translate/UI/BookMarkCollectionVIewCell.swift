//
//  BookMarkCollectionVIewCell.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import UIKit
import SnapKit

final class BookMarkCollectionVIewCell: UICollectionViewCell {
    static let identifier = "BookMarkCollectionVIewCell"
    
    private var sourceBookmarkTextStackView: BookMarkTextStack!
    private var targetBookmarkTextStackView: BookMarkTextStack!
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        [sourceBookmarkTextStackView,targetBookmarkTextStackView].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    
    func setup(from bookmark: BookMark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookMarkTextStack(language: bookmark.sourceLanguage, text: bookmark.sourceText, type: .source)
        targetBookmarkTextStackView = BookMarkTextStack(language: bookmark.translatedLanguage, text: bookmark.translatedText, type: .target)
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        [sourceBookmarkTextStackView,targetBookmarkTextStackView].forEach { stackView.addArrangedSubview($0) }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
        
        
        
    }
}
