//
//  FilterVC.swift
//  CoctailDB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {

    // MARK: @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Variables
    var filters: [Filter] = []
    var delegate: ButtonDelegate!
    var alamofireService = AlamofireServise.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupTableView()
    }
    
    // MARK: Setup Methods
    private func setupTitleLabel() {
        titleLabel.text = "Filters"
        titleLabel.font = UIFont(name: "Roboto", size: 24)
        titleLabel.sizeToFit()
    }
    
    private func setupTableView() {
        tableView.register(type: FilterTableViewCell.self)
    }
    
    // MARK: @IBActions
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func applyButtonTapped() {
        delegate.applyButtonTapped(filters: filters)
        dismiss(animated: true)
    }

}

// MARK: UITableViewDataSource
extension FilterVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filters[indexPath.row]
        let cell = tableView.dequeueReusableCell(with: FilterTableViewCell.self, for: indexPath)
        cell.typeNameLabel.text = item.name
        cell.checkImageView?.isHidden = !(item.isActive)
        return cell
    }
    
    
}

// MARK: UITableViewDelegate
extension FilterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filters[indexPath.row].isActive.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
