//
//  GHSearchDetailViewController.swift
//  GitHubSearch
//
//  Created by apple on 7/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SDWebImage

class GHSearchDetailViewController: UIViewController {
    var strUserName:String?
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblRepos: UILabel!
    @IBOutlet weak var lblGist: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    var modelDetails: GHSearchDetailModel?{
        didSet{
            if let model = modelDetails {
                self.configView(withModel: model)
            }
        }
    }
    
    func configView(withModel: GHSearchDetailModel)  {
        lblUserName.text = "@\(withModel.login ?? "")"
        imgUser.sd_setImage(with: URL(string: "\(withModel.avatarURL ?? "")"), placeholderImage: UIImage(named: "placeHolderSmall"))
        imgUser.layer.cornerRadius = 62.5
        imgUser.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        imgUser.layer.borderWidth = 1
        imgUser.layer.masksToBounds = true

        lblName.text = "Name:\(withModel.name ?? "")"
        lblLocation.text = "Location: \(withModel.location ?? "")"
        lblBlog.text = "Blog: \(withModel.blog ?? "")"
        lblCompanyName.text = "Company: \(withModel.company ?? "")"
//
        lblFollowers.text = "\(withModel.followers ?? "0")"
        lblFollowing.text = "\(withModel.following ?? "0")"
        lblGist.text = "\(withModel.publicGists ?? "0")"
        lblRepos.text = "\(withModel.publicRepos ?? "0")"

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserDetails()
    }
    
    // MARK: - API
    
    func getUserDetails() {
        SVProgressHUD.show()
        let url = "https://api.github.com/users/\(self.strUserName ?? "")"
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let parameters: Parameters? = nil
        Alamofire.request("\(escapedAddress ?? "")", method:.get, parameters: parameters)
            .responseJSON {
                response in
                debugPrint(response)
                if let responseDict = response.result.value as? [String: Any] {
                    self.modelDetails = GHSearchDetailModel.getSearchUserDetails(withDictionay: responseDict)
                }
                SVProgressHUD.dismiss()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
