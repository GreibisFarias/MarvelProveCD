//
//  MarvelTableViewCell.swift
//  MarvelProveCD
//
//  Created by Greibis Farias on 8/2/25.
//

import UIKit

class MarvelTableViewCell: UITableViewCell {

    @IBOutlet weak var idTxt: UILabel!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
