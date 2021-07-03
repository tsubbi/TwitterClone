//
//  FirebaseDatabase.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-05.
//

import Firebase

/// Firebase database
class FirDatabase {
    static let shared = FirDatabase()
    private let reference: DatabaseReference
    
    init() {
        self.reference = Database.database().reference()
    }
    
    func updateNode(main node: FirDatabaseNode, in subNode: String, with values: [String: Any], completeion block: @escaping (Error?, DatabaseReference) -> Void) {
        self.reference.child(node.rawValue).child(subNode).updateChildValues(values, withCompletionBlock: block)
    }
    /// get reference to avoid spelling error
    func getReference(of node: FirDatabaseNode, with child: String) -> DatabaseReference {
        return self.reference.child(node.rawValue).child(child)
    }
}

enum FirDatabaseNode: String {
    case users
}
