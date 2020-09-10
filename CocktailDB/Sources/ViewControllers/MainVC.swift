//
//  ViewController.swift
//  Cocktail DB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit




class MainVC: UIViewController {

    // MARK: @IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    // MARK: Variables
    var filters: [Filter] = []
    var drinks: [[Drink]] = []
    var iterator = 0
    
    // MARK: Servises
    let alamofireServise = AlamofireServise.shared
    var downloader: Downloader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupTableView()
        setupFirstPage()
        setupSpiner()
    }
    
    // MARK: Setup Methods
    
    private func setupFirstPage() {
        filterButton.isEnabled = false
        alamofireServise.getListCategory { [weak self] filters in
            self?.filters = filters
            let categories = filters.map { $0.name }
            self?.downloader = Downloader(namePages: categories)
            self?.downloader.loadNextPage { [weak self] drinks in
                self?.drinks.append(drinks)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.filterButton.isEnabled = true
                }
            }
            
        }
    }
    
    private func setupSpiner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        spinner.startAnimating()
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Drinks"
        titleLabel.font = UIFont(name: "Roboto", size: 24)
        titleLabel.sizeToFit()
    }
    
    private func setupTableView() {
        tableView.register(type: CoctailTableViewCell.self)
    }
    
    // MARK: @IBActions
        
    @IBAction func filerButtonTapped() {
        let vc: FilterVC = .instantiate(from: .main)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        vc.filters = filters
        present(vc, animated: true)
    }
}


// MARK: UITableViewDataSource
extension MainVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = drinks[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(with: CoctailTableViewCell.self, for: indexPath)
        cell.coctailNameLabel.text = item.name
        cell.coctailImageView.image = item.image
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if downloader.isDownloaded {
            self.tableView.tableFooterView?.isHidden = true
            self.tableView.tableFooterView = nil
            filterButton.isEnabled = true
            return
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            filterButton.isEnabled = false
            downloader.loadNextPage { [weak self] drinks in
                self?.drinks.append(drinks)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.filterButton.isEnabled = true
                }
            }
            
        }
    }
    
    
}

// MARK: UITableViewDelegate

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = downloader.namePages[section]
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 20, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = item
        label.font = UIFont(name: "Roboto", size: 14)
        label.textColor = #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: ButtonDelegate

extension MainVC: ButtonDelegate {
    
    func applyButtonTapped(filters: [Filter]) {
        self.filters = filters
        self.drinks = []
        filterButton.isEnabled = false
        tableView.reloadData()
        downloader.namePages = filters.filter { $0.isActive }.map { $0.name}
        setupSpiner()
        downloader.loadNextPage { [weak self] drinks in
            self?.drinks.append(drinks)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.filterButton.isEnabled = true
            }
        }
    }
    
}

