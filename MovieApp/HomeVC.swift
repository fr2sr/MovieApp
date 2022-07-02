//
//  HomeVC.swift
//  MovieApp
//
//  Created by Sohanur Rahman on 2/7/22.
//

import UIKit

class HomeVC: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie List"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search Movie Here"
        textField.text = "Marvel"
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .black
        textField.layer.borderColor = UIColor.hexStringToUIColor(hex: "#F0F0F5").cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor.hexStringToUIColor(hex: "#F0F0F5")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: MovieDetailsCell.identifire)
        tableView.register(MovieEmptyCell.self, forCellReuseIdentifier: MovieEmptyCell.identifire)
        return tableView
    }()
    
    lazy var refreshView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.tintColor = .white
        activityView.style = .white
        return activityView
    }()
    
    var movieResponseModel: MovieResponseModel!
    var movieDataResponseModel = [MovieDataResponseModel]()
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        setupConstraints()
        searchButton.addTarget(self, action: #selector(searchMovie),for: .touchUpInside)
        
        getMovieData(query: "Marvel")
    }
    
    @objc func searchMovie(sender: UIButton) {
        print("click")
        movieDataResponseModel.removeAll()
        movieTableView.reloadData()
        getMovieData(query: searchField.text!)
    }
    
    func getMovieData(query: String){
        
        let url = ("https://api.themoviedb.org/3/search/movie?api_key=3c78016499e73f3df0a20dc886b450e0&query=" + query + "&page=" + "\(page)")
        
        guard let apiURL = URL(string: url) else { return print("Error") }
              
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard let obtainedData = data else { return print("No data")}
            do {
                let movieApiData = try JSONDecoder().decode( MovieResponseModel.self, from: obtainedData)
                self.onSuccessGetData(movieData: movieApiData)
                print("Hey Sohan We Found Movie List Of: \(movieApiData)")
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func onSuccessGetData(movieData: MovieResponseModel){
        movieResponseModel = movieData
        let emptyCellData = [MovieDataResponseModel]()
        movieDataResponseModel.append(contentsOf: movieResponseModel.results ?? emptyCellData)
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
    
    func onFailed(){
        
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(movieTableView)
        view.addSubview(refreshView)
        refreshView.addSubview(activityIndicatorView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: self.getStatusBarHeight() + 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            //Search Button
            searchButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 80),
            
            //Search Field
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: 0),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            //Movie Collection View
            movieTableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            
            // Refresh View
            refreshView.topAnchor.constraint(equalTo: view.topAnchor),
            refreshView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            refreshView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            refreshView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Activity View
            activityIndicatorView.centerXAnchor.constraint(equalTo: refreshView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: refreshView.centerYAnchor)
        ])
    }
}



extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataResponseModel.count == 0 ? 1 : movieDataResponseModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if movieDataResponseModel.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieEmptyCell.identifire) as! MovieEmptyCell
            tableView.rowHeight = movieTableView.bounds.height
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.identifire) as! MovieDetailsCell
            tableView.rowHeight = 120
            cell.setMovieDataToCell(data: movieDataResponseModel[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == movieDataResponseModel.count - 4 {
            if page < movieResponseModel.total_pages ?? 0{
                page += 1
                getMovieData(query: searchField.text!)
            }
        }
    }
}
