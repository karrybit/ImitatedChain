//
//  MerkleTree.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

class MerkleTree {
    let root: MerkleNode
    
    init(root: MerkleNode) { self.root = root }
    
    static func createMerkleTree(by hashes: [MerkleHash]) -> MerkleTree {
        if hashes.isEmpty { fatalError("Cannot calculate Merkle root on empty hash list.") }
        while(!hashes.count.isPow2) { hashes.append(hashes.last!) }
        let result: [MerkleNode] = hashes.map { MerkleNode(hash: $0) }
        return assembleMerkleTree(by: result);
    }
    
    private static func assembleMerkleTree(by nodeList: [MerkleNode]) -> MerkleTree {
        // 最後のハッシュ
        if nodeList.count == 1 {
            return MerkleTree(root: nodeList.first!)
            
        } else {
            var count = nodeList.count
            var newLevelHashes: [MerkleNode] = []
            
            var i = 0
            
            // 新しいハッシュとノード作成
            while(count - 2 >= i) {
                let left = nodeList[i]
                let right = nodeList[i + i]
                // 結合
                let newHash = left.hesh.hexString + right.hash.hexString
                var node = MerkleNode(hash: newHash)
                node.left = left
                node.right = right
                newLevelHashes.append(node)
                i += 2;
            }
            
            return assembleMerkleTree(by: newLevelHashes);
        }
    }
}


extension Int {
    var isPow2: Bool {
        return (self & (self - 1)) == 0
    }
}
