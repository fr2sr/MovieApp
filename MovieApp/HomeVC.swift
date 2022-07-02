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
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor.hexStringToUIColor(hex: "#F0F0F5")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: MovieDetailsCell.identifire)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
                
        setupConstraints()
//        getCompanies()
        
        print("Hey SOhan")
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(searchField)
        view.addSubview(movieTableView)
        view.addSubview(refreshView)
        refreshView.addSubview(activityIndicatorView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: self.getStatusBarHeight() + 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            //Search Field
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.identifire)
        tableView.rowHeight = 120
        return cell!
    }
}
