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
    
    func updateNode(main node: FirStorageNode, in name: String, with data: Data, completeion block: @escaping (StorageMetadata?, Error?) -> Void) {
        self.reference.child(node.rawValue).child(name).putData(data, metadata: nil, completion: block)
    }
    /// get reference to avoid spelling error
    func getReference(of node: FirStorageNode, with child: String) -> StorageReference {
        return self.reference.child(node.rawValue).child(child)
    }
}

enum FirStorageNode: String {
    case profileImages = "profile_images"
}
