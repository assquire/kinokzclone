//
//  TrendingCollectionViewCell.swift
//  kinokzclone
//
//  Created by Askar on 18.01.2023.
//

import UIKit

final class TrendingCollectionViewCell: UICollectionViewCell {
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Moana")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MovieModel) {
        guard let url = URL(string: "\(Constants.Links.imageUrl)\(model.posterPath)") else { fatalError("Incorrect link!") }
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: url)
        }
    }
}

//MARK: - Setup views and constraints

private extension TrendingCollectionViewCell {
    
    func setupViews() {
        contentView.addSubview(movieImageView)
    }
    
    func setupConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
