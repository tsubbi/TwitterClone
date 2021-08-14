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
    
    
    /// Update data in Firebase database through nodes
    /// - Parameters:
    ///   - node: the node that required to update
    ///   - subNode: second layer inside of the main node
    ///   - values: the values that need to be updated
    ///   - block: action after complete the update
    func updateNode(main node: FirDatabaseNode, in subNode: String, with values: [String: Any], completeion block: @escaping (Result<DatabaseReference, Error>) -> Void) {

        self.reference.child(node.rawValue).child(subNode).updateChildValues(values) { (error, ref) in
            if let error = error {
                block(.failure(error))
            }
            block(.success(ref))
        }
    }
    /// get reference to avoid spelling error
    func getReference(of node: FirDatabaseNode, with child: String) -> DatabaseReference {
        return self.reference.child(node.rawValue).child(child)
    }
    
    func postTweet(main node: FirDatabaseNode, with values: [String: Any], completion block: @escaping (Result<DatabaseReference, Error>) -> Void) {
        self.reference.child(node.rawValue).childByAutoId().updateChildValues(values) { (err, ref) in
            if let error = err {
                block(.failure(error))
            }
            block(.success(ref))
        }
    }
    
    func fetchTweet(of node: FirDatabaseNode, completion block: @escaping (DataSnapshot) -> Void) {
        self.reference.child(node.rawValue).observe(.childAdded) {
            block($0)
        }
    }
}

enum FirDatabaseNode: String {
    case users
    case tweets
}
