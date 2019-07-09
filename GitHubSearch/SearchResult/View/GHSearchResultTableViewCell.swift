//
//  GHSearchResultTableViewCell.swift
//  GitHubSearch
//
//  Created by apple on 7/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SDWebImage

class GHSearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    var modelSearch : GHSearchResultModel? {
        didSet{
            if let model = modelSearch {
                lblUser.text = "@\(model.login ?? "")"
                imgUser.sd_setImage(with: URL(string: "\(model.avatarURL ?? "")"), placeholderImage: UIImage(named: "placeHolderSmall"))
                imgUser.layer.cornerRadius = 20
                imgUser.layer.borderColor = UIColor.groupTableViewBackground.cgColor
                imgUser.layer.borderWidth = 1
                imgUser.layer.masksToBounds = true
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
