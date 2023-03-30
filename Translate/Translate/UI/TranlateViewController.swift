//
//  TranlateViewController.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/29.
//

import SnapKit
import UIKit



final class TranlateViewController:UIViewController{
    
    private var translateManager = TranslatroManager()
    
    //private var sourceLanguage: Language = .ko
    //private var targetLanguage: Language = .en
    
    private lazy var sourceLangaugeButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var targetLangaugeButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [sourceLangaugeButton, targetLangaugeButton]
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = .tintColor
        //label.text = "Hello"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTabBookmarkButton), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func didTabBookmarkButton() {
        
        guard let sourceText = sourceLabel.text,
              let translateText = resultLabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark")
        
        else { return }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        let currentBookmarks: [BookMark] = UserDefaults.standard.bookmarks
        let newBookmark = BookMark(sourceLanguage: translateManager.sourceLanguage, translatedLanguage: translateManager.targetLanguage, sourceText: sourceText, translatedText: translateText)
        
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        
        print(UserDefaults.standard.bookmarks)
        
        
        //user default에 저장
        
    }
    
    private lazy var copyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopybutton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapCopybutton() {
        UIPasteboard.general.string = resultLabel.text
    }
    
    
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Enter_text", comment: "텍스트 입력")
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        
        
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        setupViews()
        
        
    }
    
}

extension TranlateViewController: SourceTextViewControllerDelegate {
    
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        translateManager.translate(from: sourceText) { [weak self] translateText in
            self?.resultLabel.text = translateText
        }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}


private extension TranlateViewController {
    func setupViews() {
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel
        ]
            .forEach{ view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(defaultSpacing)
            $0.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.height.equalTo(50.0)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints{
            $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
            $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel.snp.leading)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.equalTo(40.0)
            $0.height.equalTo(40.0)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
            $0.top.equalTo(bookmarkButton.snp.top)
            $0.width.equalTo(40.0)
            $0.height.equalTo(40.0)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview().inset(100)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24.0)
            $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24.0)
            $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24.0)
        }
    }
    
    @objc func didTapSourceLabelBaseButton(){
        let vc = SourceTextViewController(delegate: self)
        present(vc, animated: true)
    }
    
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(type: .source)
    }
    
    @objc func didTapTargetLanguageButton() {
        didTapLanguageButton(type: .target)
    }
    
    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { [weak self] _ in
                switch type {
                case .source:
                    self?.translateManager.sourceLanguage = language
                    self?.sourceLangaugeButton.setTitle(language.title, for: .normal)
                case .target:
                    self?.translateManager.targetLanguage = language
                    self?.targetLangaugeButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "취소하기"), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
}
