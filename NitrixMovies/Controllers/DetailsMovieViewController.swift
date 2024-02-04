//
//  DetailsMovieViewController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import UIKit
import SDWebImage

class DetailsMovieViewController: UIViewController {
    
    var viewModel: DetailsMovieViewModel
    
    init(viewModel: DetailsMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dateLabel)
        
        self.title = viewModel.movieTitle
        titleLabel.text = viewModel.movieTitle
        descriptionLabel.text = viewModel.movieDescription
        dateLabel.text = "🗓️\(String(describing: viewModel.movieDate.formatted()))"
        movieImageView.sd_setImage(with: viewModel.movieImage)
    }

}

extension DetailsMovieViewController {
    func setConstraints() {
        [movieImageView, titleLabel, descriptionLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
        movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
        movieImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
        movieImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 0.65),
        
        titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
//        titleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
//        titleLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
        descriptionLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}
