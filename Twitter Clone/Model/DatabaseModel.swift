//
//  DatabaseModel.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-08-24.
//

import Foundation

class DatabaseModel<T: Decodable> where T: NSObject {
    let id: String
    let modelData: T
    
    init(id: String, snapshotData: Any) {
        self.id = id
        #warning("need to refactor!!!")
        // refactor sample is: https://stackoverflow.com/a/53565810/14939990
        // ===============================================================
        // transform sanpshot to object
        // https://stackoverflow.com/a/58510766/14939990
        guard let data = try? JSONSerialization.data(withJSONObject: snapshotData, options: []) else {
            self.modelData = T()
            return
        }
        self.modelData = JSONDecoder().decodeAndHandlesError(T.self, from: data) ?? T()
    }
}
