//
//  PosterViewController.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import UIKit

final class PosterViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bigView = UIView()
    
    private let mediaTypes = MediaType.allCases
        
    private lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Фильмы, сериалы"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var mediaTypeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MediaTypeCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.sectionCollectionViewCell)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.trendingCollectionViewCell)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.movieTableViewCell)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        mediaTypeCollectionView.dataSource = self
        mediaTypeCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
}

//MARK: - Private methods

private extension PosterViewController {
    
    func configureNavBar() {
        let leftIcon = UIImage(systemName: "applelogo")
        let rightIcon = UIImage(systemName: "gear")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftIcon, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }
}

//MARK: - Collection view data source methods

extension PosterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mediaTypeCollectionView {
            return mediaTypes.count - 1
        }
        else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mediaTypeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.sectionCollectionViewCell, for: indexPath) as! MediaTypeCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.backgroundColor = .systemGray4
            cell.setText(with: mediaTypes[indexPath.item + 1].rawValue)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.trendingCollectionViewCell, for: indexPath) as! TrendingCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }
    }
}

//MARK: - Collection view delegate methods

extension PosterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("HI!")
    }
}

//MARK: - Collection view flow layout delegate methods

extension PosterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mediaTypeCollectionView {
            let label = UILabel()
            label.text = mediaTypes[indexPath.item + 1].rawValue
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: collectionView.frame.size.height - 15)
        }
        else {
            let height = collectionView.frame.size.height
            let width = height * 2
            return CGSize(width: width, height: height)
        }
    }
}

//MARK: - Table view data source methods

extension PosterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mediaTypes.count - 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MediaTypeHeaderView()
        view.setHeaderView(mediaType: mediaTypes[section + 2].rawValue, number: 25)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.movieTableViewCell, for: indexPath) as! MovieTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - Table view delegate methods

extension PosterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let label = UILabel()
        label.text = mediaTypes[section + 2].rawValue
        label.sizeToFit()
        return label.frame.height + 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.25
    }
}

//MARK: - Setup views and constraints

private extension PosterViewController {
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bigView)
        bigView.addSubview(movieSearchBar)
        bigView.addSubview(mediaTypeCollectionView)
        bigView.addSubview(trendingCollectionView)
        bigView.addSubview(movieTableView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view)
        }
        bigView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(15)
        }
        movieSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        mediaTypeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieSearchBar.snp.bottom)
            make.height.equalTo(view.frame.size.height * 0.06)
        }
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mediaTypeCollectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.size.height * 0.175)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.size.height)
            make.bottom.equalToSuperview()
        }
    }
}
