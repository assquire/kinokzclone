//
//  PosterViewController.swift
//  kinokzclone
//
//  Created by Askar on 17.01.2023.
//

import UIKit

final class PosterViewController: UIViewController {
    
    var apiCaller = APICaller()
    var movieList: [MovieModel] = []

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        apiCaller.delegate = self
        
        apiCaller.fetchRequest()
        
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

extension PosterViewController: APICallerDelegate {
    func didUpdateMovieList(with movieList: [MovieModel]) {
        DispatchQueue.main.async {
            self.movieList.append(contentsOf: movieList)
            self.trendingCollectionView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - Collection view data source methods

extension PosterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mediaTypeCollectionView {
            return mediaTypes.count - 1
        }
        else {
            return movieList.count
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
            cell.configure(with: movieList[indexPath.item])
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
        contentView.addSubview(movieSearchBar)
        contentView.addSubview(mediaTypeCollectionView)
        contentView.addSubview(trendingCollectionView)
        contentView.addSubview(movieTableView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(15)
        }
        movieSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.05)
        }
        movieSearchBar.searchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mediaTypeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieSearchBar.snp.bottom).offset(10)
            make.height.equalTo(view).multipliedBy(0.06)
        }
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mediaTypeCollectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.175)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view)
        }
    }
}
