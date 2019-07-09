//
//  ViewController.swift
//  GitHubSearch
//
//  Created by apple on 7/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


class GHSearchViewController: UIViewController {

    @IBOutlet weak var viewBackGroundTxt: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    var pageNO = 0
    var strSearchTxt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnSearch(_ sender: Any) {
        if let strSearch = self.txtSearch.text {
            self.searchForUser(withtext: strSearch)
        }
    }
    func searchForUser(withtext: String) {
        SVProgressHUD.show()
        let url = "https://api.github.com/search/users?q=\(txtSearch.text ?? "")&page=\(pageNO)"
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let parameters: Parameters? = nil
        Alamofire.request("\(escapedAddress ?? "")", method:.get, parameters: parameters)
            .responseJSON {
                response in
                debugPrint(response)
                if let responseDict = response.result.value as? [String: Any] {
                    if let arrayUser = responseDict["items"] as? [[String: Any]] {
                        let modelUserArray = GHSearchResultModel.getSearchUserArray(withArray: arrayUser)
                        self.pushToResultVC(withArray: modelUserArray)
                    }
                    
                }
                SVProgressHUD.dismiss()
        }
    }
    func pushToResultVC(withArray:[GHSearchResultModel]) {
        let mainIntroTutorial = UIStoryboard(name: "Main", bundle: nil)
        let vcView = mainIntroTutorial.instantiateViewController(withIdentifier: "GHSearchResultViewController") as? GHSearchResultViewController
        vcView?.arrayResult = withArray
        DispatchQueue.main.async(execute: {
            if let aView = vcView {
                self.navigationController?.pushViewController(aView, animated: true)
            }
        })
    }
}
extension GHSearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
