//
//  MovieDetailsCell.swift
//  MovieApp
//
//  Created by Sohanur Rahman on 2/7/22.
//

import UIKit

class MovieDetailsCell: UITableViewCell {
    
    static let identifire = "MovieDetailsCell"
    
    lazy var movieImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "image_empty")
        img.backgroundColor = UIColor.hexStringToUIColor(hex: "#F0F0F5")
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        return img
    }()
    
    lazy var labelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Details"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        contentView.addSubview(labelView)
        labelView.addSubview(titleLabel)
        labelView.addSubview(detailsLabel)
        contentView.addSubview(movieImage)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            
            // Movie Image
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            movieImage.widthAnchor.constraint(equalToConstant: 70),
            movieImage.heightAnchor.constraint(equalToConstant: 100),
            
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 0),
//            titleLabel.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: 0),
            
            //Details Label
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            detailsLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 00),
            detailsLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 0),
//            detailsLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -10),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setMovieDataToCell(data: MovieDataResponseModel){
        titleLabel.text = data.original_title
        detailsLabel.text = data.overview
        
        movieImage.downloaded(from: "https://image.tmdb.org/t/p/w500/" + (data.poster_path ?? ""))
    }
}



