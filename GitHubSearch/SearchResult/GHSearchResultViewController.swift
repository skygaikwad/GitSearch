//
//  GHSearchResultViewController.swift
//  GitHubSearch
//
//  Created by apple on 7/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class GHSearchResultViewController: UIViewController {
    var arrayResult: [GHSearchResultModel]?
    var pageNo = 1
    var isAPILoading = false
    var finishedLoadingInitialTableCells = false
    var strSearch : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.black

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func pushToResultVC(withSearch: String) {
        let mainIntroTutorial = UIStoryboard(name: "Main", bundle: nil)
        let vcView = mainIntroTutorial.instantiateViewController(withIdentifier: "GHSearchDetailViewController") as? GHSearchDetailViewController
        vcView?.strUserName = withSearch
        DispatchQueue.main.async(execute: {
            if let aView = vcView {
                self.navigationController?.pushViewController(aView, animated: true)
            }
        })
    }
    // MARK: - API

    func searchForUser() {
        SVProgressHUD.show()
        self.isAPILoading = true
        let url = "https://api.github.com/search/users?q=\(self.strSearch ?? "")&page=\(pageNo)"
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let parameters: Parameters? = nil
        Alamofire.request("\(escapedAddress ?? "")", method:.get, parameters: parameters)
            .responseJSON {
                response in
                debugPrint(response)
                if let responseDict = response.result.value as? [String: Any] {
                    if let arrayUser = responseDict["items"] as? [[String: Any]] {
                        let modelUserArray = GHSearchResultModel.getSearchUserArray(withArray: arrayUser)
                        self.arrayResult?.append(contentsOf: modelUserArray)
                        self.isAPILoading = false
                        self.pageNo = self.pageNo+1
                    }else{
                        self.isAPILoading = true
                        
                    }
                    
                }
                SVProgressHUD.dismiss()
        }
    }
}
// MARK: - TableView

extension GHSearchResultViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GHSearchResultTableViewCell", for: indexPath) as? GHSearchResultTableViewCell else {return UITableViewCell()}
        if let model = self.arrayResult?[indexPath.row] {
            cell.modelSearch = model
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let arrayScreen = arrayResult  {
            var lastInitialDisplayableCell = false
            //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
            if arrayScreen.count > 0 && !finishedLoadingInitialTableCells {
                if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                    let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                    lastInitialDisplayableCell = true
                }
            }
            if !finishedLoadingInitialTableCells {
                
                if lastInitialDisplayableCell {
                    finishedLoadingInitialTableCells = true
                }
                
                //animates the cell as it is being displayed for the first time
                cell.transform = CGAffineTransform(translationX: 0, y: 25)
                cell.alpha = 0
                
                UIView.animate(withDuration: 0.3, delay: 0.03*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
                }, completion: nil)
            }
            
            if indexPath.row == arrayScreen.count-1 && isAPILoading == false {
                self.searchForUser()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.arrayResult?[indexPath.row] {
            self.pushToResultVC(withSearch: "\(model.login ?? "")")
        }

    }
}
