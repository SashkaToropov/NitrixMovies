//
//  DetailsFavoriteViewController.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 05.02.2024.
//

import UIKit

class DetailsFavoriteViewController: UIViewController {
    
    var viewModel: DetailsFavoriteViewModel
    
    init(viewModel: DetailsFavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(genresLabel)
        view.addSubview(dateLabel)
        
        self.title = viewModel.title
        titleLabel.text = "🍿Title: \(viewModel.title)"
        genresLabel.text = "🎞️Genre: \(viewModel.genres)"
        dateLabel.text = "🗓️Date: \(viewModel.date.formatted())"
    }
}

extension DetailsFavoriteViewController {
    func setConstraints() {
        
        [titleLabel, genresLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
