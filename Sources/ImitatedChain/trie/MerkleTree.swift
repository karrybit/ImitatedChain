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
        return assembleMerkleTree(by: result)
    }
    
    private static func buildMerkleTree(by nodeList: [MerkleNode]) -> MerkleTree {
        if nodeList.count == 1 {
            return MerkleTree(root: nodeList.first!)
            
        } else {
            func loop(list: inout [MerkleNode]) -> MerkleNode {
                if list.count == 1 { return list[0] }
                
                var higherLevelNodes: [MerkleNode] = []
                for i in stride(from: 0, to: list.count, by: 2) {
                    let left = list[i]
                    let right = list[i + i]
                    let node = MerkleNode(hash: MerkleHash(dataString: left.hash.hexString + right.hash.hexString))
                    node.left = left
                    node.right = right
                    
                    higherLevelNodes.append(node)
                }
                
                return loop(list: &higherLevelNodes)
            }
            
            var argList = nodeList
            return MerkleTree(root: loop(list: &argList))
        }
    }
}


extension Int {
    var isPow2: Bool {
        return (self & (self - 1)) == 0
    }
}
