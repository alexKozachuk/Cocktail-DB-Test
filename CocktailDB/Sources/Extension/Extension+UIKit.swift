//
//  Extension+Core.swift
//  Cocktail DB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit

// MARK: - View
extension UIView {
    static var name: String {
        return String(describing: self)
    }
    
    class func loadFromNib<T: UIView>(name nibName: String? = nil, bundle : Bundle? = nil) -> T {
        let nibName = nibName ?? name
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! T
    }
}

// MARK: - UITableView
extension UITableView {
    func register(type: UITableViewCell.Type) {
        let typeName = type.name
        let nib = UINib(nibName: typeName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: typeName)
    }
    
    func register(type: UITableViewHeaderFooterView.Type) {
        let typeName = type.name
        let nib = UINib(nibName: typeName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: typeName)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.name, for: indexPath) as! T
    }

    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.name) as! T
    }
    
    func scrollToBottom(animated: Bool) {
        let lastSection = numberOfSections-1
        let lastRow = numberOfRows(inSection: lastSection)-1
        guard lastSection >= 0, lastRow >= 0 else { return }
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
        scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
    }
}
