//
//  DetailsListViewModel.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import UIKit
class DetailsListViewModel: NSObject {
    var resultsDataArr = [ArrayResultsObj]()
    // fetching orders list
    func fetchDetailsList(vc: UIViewController,isSuccess _success: @escaping(Bool) -> Void){
        if Reachability.isConnectedToNetwork(){ // Checking network
            SpinnerView.shared.showOverlay(view: vc.view)
            guard let urlString = URL(string: Api.detailsList) else { return }
            var request = URLRequest(url: urlString)
            request.httpMethod = "GET" // Using GET method
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, _, _) in
                SpinnerView.shared.hideOverlayView()
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do{
                    //JSONSerialization
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
                    
                   // Converting data to Json models
                    let response = try decoder.decode([ArrayResultsObj].self, from: data)
                    guard let dataObj =  response as [ArrayResultsObj]? else { return }
                    self.resultsDataArr = dataObj
                    print(self.resultsDataArr[0].id ?? "")
                    _success(true)
                }catch{
                    print("ERROR = \(error.localizedDescription)") // Printing error
                    DispatchQueue.main.async {
                        vc.presentAlertWithTitle(title: "Error", message: AlertMessages.somethingErrorMessage, vc: vc)
                      _success(false)
                    }
                }
            }
            task.resume()
        }else{
            // If notwork not available, giving pop-up alert for user understanding
            DispatchQueue.main.async {
                vc.presentAlertWithTitle(title: AlertMessages.networkErrorMessage, message: AlertMessages.networkFailedMessage, vc: vc)
            }
            

        }
        
    }

}
