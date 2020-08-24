//
//  DetailsDataResponse.swift
//  WisdomLeafTask
//
//  Created by Venkatesh on 24/08/20.
//  Copyright © 2020 Venkatesh. All rights reserved.
//

import Foundation

//struct DetailsListResponceModel: Decodable {
//    let array: [ArrayResultsObj]?
//}

struct ArrayResultsObj: Decodable {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var download_url: String?
}
