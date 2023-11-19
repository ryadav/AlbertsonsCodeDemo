//
//  AbbreviationTableViewCell.swift
//  AlbertsonCodeDemo
//
//  Created by Apple  on 17/11/23.
//

import UIKit

class AcronymsTableViewCell: UITableViewCell {

    @IBOutlet weak var sfLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!

    // MARK: - Custom method
    func setUpDataOnCell(data: LongFormModel) {
       sfLabel.text = "\(AppConstants.longForm) - \(data.lf ?? "")"
       freqLabel.text = "\(AppConstants.frequency) - \(data.freq ?? 0)"
    }
}
