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
        
        /// hashesの要素数とその数以上の最小の2のべき乗の値との差を求める
        var offset = 0
        while(!(hashes.count + offset).isPow2) { offset += 1 }
        
        /// hashesの要素数が2のべき乗になるように、最後の要素をappendする
        var list: [MerkleHash] = []
        let last = hashes.last!
        (0...offset).forEach { _ in list.append(last) }
        
        /// 2のべき乗数分になったhashでnodeを作成する
        let result: [MerkleNode] = (hashes + list).map { MerkleNode(hash: $0) }
        return assembleMerkleTree(by: result);
    }
    
    private static func assembleMerkleTree(by nodeList: [MerkleNode]) -> MerkleTree {
        // 最後のハッシュ
        if nodeList.count == 1 {
            return MerkleTree(root: nodeList.first!)
            
        } else {
            let count = nodeList.count
            var newLevelHashes: [MerkleNode] = []
            
            var i = 0
            
            // 新しいハッシュとノード作成
            while(count - 2 >= i) {
                let left = nodeList[i]
                let right = nodeList[i + i]
                // 結合
                let newHash = left.hash.hexString + right.hash.hexString
                let node = MerkleNode(hash: MerkleHash(dataString: newHash))
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
