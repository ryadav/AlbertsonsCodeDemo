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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Custom method
    func setUpDataOnCell(data: LongFormModel) {
       sfLabel.text = "\(AppConstants.longForm) - \(data.lf ?? "")"
       freqLabel.text = "\(AppConstants.frequency) - \(data.freq ?? 0)"
    }
}

