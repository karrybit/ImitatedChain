import Foundation

let merkleRoot: String = "0x0"
BlockChain.shared.createGenesisBlock(by: merkleRoot)

for _ in 0..<10 {
    let PoW = ProofOfWork(merkleRoot: merkleRoot);
    let block = Block(preHash: BlockChain.shared.latestBlock.header.hash!, merkleRoot: merkleRoot)
    let acceptedBlock = PoW.exec(for: block)
    BlockChain.shared.append(acceptedBlock)
}

for i in 0...10 {
    print("*** Block \(i) ***")
    print("TimeStamp: \(BlockChain.shared.blocks[i].header.timeStamp!)")
    print("Hash: \(BlockChain.shared.blocks[i].header.hash!)")
    print("Previous Hash: \(BlockChain.shared.blocks[i].header.preHash)")
    print("Nonce: \(BlockChain.shared.blocks[i].header.nonce!)")
}
