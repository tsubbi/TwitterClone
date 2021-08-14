//
//  FirebaseStorage.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-05.
//

import Firebase

/// Firebase Storage
class FirStorage {
    static let shared = FirStorage()
    private let reference: StorageReference
    
    init() {
        self.reference = Storage.storage().reference()
    }
//    StorageMetadata?, Error?
    func updateNode(main node: FirStorageNode, in name: String, with data: Data, completeion block: @escaping (Result<StorageMetadata, Error>) -> Void) {
        self.reference.child(node.rawValue).child(name).putData(data, metadata: nil) { (meta, error) in
            if let error = error {
                block(.failure(error))
                return
            }
            
            if meta == nil {
                block(.failure(FirStorageError.noData))
            }
            
            block(.success(meta!))
        }
    }
    /// get reference to avoid spelling error
    func getReference(of node: FirStorageNode, with child: String) -> StorageReference {
        return self.reference.child(node.rawValue).child(child)
    }
}

enum FirStorageNode: String {
    case profileImages = "profile_images"
}

enum FirStorageError: Error {
    case noData
    
    var message: String {
        switch self {
        case .noData:
            return "Unable to fetch data from storage"
        }
    }
}
