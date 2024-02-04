//
//  MovieListCell.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import UIKit
import SDWebImage

final class MovieListCell: UITableViewCell {

    static var cellIdentifier: String {
        return String(describing: MovieListCell.self)
    }
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(ratingLabel)
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewModel: MovieListCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.dateLabel.text = "\(viewModel.date.formatted())"
        self.ratingLabel.text = viewModel.rating
        self.posterImageView.sd_setImage(with: viewModel.imageURL)
    }
}

extension MovieListCell {
    
    func setConstraints() {
        
        [posterImageView, titleLabel, dateLabel, ratingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -45),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
        ])
    }
}
