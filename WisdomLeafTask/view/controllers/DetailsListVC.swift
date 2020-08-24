//
//  DetailsListVC.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit

class DetailsListVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var tblVw: UITableView!
    
    // Controller Objects
    var detailsVm = DetailsListViewModel()
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        callingServiceForDetails()
    }
        
    // MARK:- Refresh Controll Initialization
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .none
        refreshControl.addTarget(self, action: #selector(refreshBtnClicked(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: AlertMessages.refreshMessgae, attributes: nil)
        if #available(iOS 10.0, *) {
            tblVw.refreshControl = refreshControl
        } else {
            tblVw.addSubview(refreshControl)
        }
    }
    
    //MARK:- Refresh button action method
    @IBAction func refreshBtnClicked(_ sender: Any) {
        tblVw.setContentOffset(CGPoint.zero, animated: true) // making tableview content offset zero. using this one to starting cells from zero
        callingServiceForDetails()
    }


    // MARK:- Calling service from fetching details
    func callingServiceForDetails() {
        detailsVm.fetchDetailsList(vc: self) { (success) in
            if success {
                DispatchQueue.main.async {
                    imageCache.removeAllObjects()  // Remove image data from cache when refresh
                    self.refreshControl.endRefreshing()
                    self.tblVw.reloadData()
                }
            }
        }
    }
}

//MARK:- UITableview Delegate And Date Source

extension DetailsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsVm.resultsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let detailsCell = tableView.dequeueReusableCell(withIdentifier: detailsListCell.identifier, for: indexPath) as? detailsListCell{
            detailsCell.configure(with: detailsVm.resultsDataArr[indexPath.row])
            cell = detailsCell
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let description = detailsVm.resultsDataArr[indexPath.row].author
        DispatchQueue.main.async {
            self.presentAlertWithTitle(title: "Description", message: description ?? "", vc: self)
        }
    }
}
