//
//  MediaTypeHeaderView.swift
//  kinokzclone
//
//  Created by Askar on 18.01.2023.
//

import UIKit

class MediaTypeHeaderView: UIView {
    
    private lazy var mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var numberOfMoviesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderView(mediaType: String, number: Int) {
        mediaTypeLabel.text = mediaType
        numberOfMoviesLabel.text = "All \(number)"
    }
}

//MARK: - Setup views and constraints

private extension MediaTypeHeaderView {
    
    func setupViews() {
        addSubview(mediaTypeLabel)
        addSubview(numberOfMoviesLabel)
    }
    
    func setupConstraints() {
        mediaTypeLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        numberOfMoviesLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
