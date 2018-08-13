//
//  MerkleNode.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

class MerkleNode {
    let hash: MerkleHash
    var left: MerkleNode?
    var right: MerkleNode?
    
    init(hash: MerkleHash) { self.hash = hash }
}
