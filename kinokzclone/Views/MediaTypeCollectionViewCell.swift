//
//  SectionCollectionViewCell.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import UIKit

final class MediaTypeCollectionViewCell: UICollectionViewCell {
    
    private lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
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
    
    func setText(with text: String) {
        sectionLabel.text = text
    }
}

//MARK: - Setup views and constraints

private extension MediaTypeCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(sectionLabel)
    }
    
    func setupConstraints() {
        sectionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
