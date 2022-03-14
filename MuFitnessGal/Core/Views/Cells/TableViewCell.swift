//
//  TableViewCell.swift
//  Muney
//
//  Created by Mu Yu on 6/8/21.
//

import UIKit

protocol TableViewCellProtocol: AnyObject {
    static var reuseID: String { get }
}

typealias TableViewCell = UITableViewCell & TableViewCellProtocol

