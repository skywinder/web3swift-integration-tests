//
//  ViewController.swift
//  swift-package-ios
//
//  Created by Petr Korolev on 23.09.2020.
//

import UIKit

import web3swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let web3 = Web3.InfuraRinkebyWeb3() // Rinkeby Infura Endpoint Provider
        let value: String = "1.0" // In Tokens
        let walletAddress = EthereumAddress("0xe22b8979739d724343bd002f9f432f5990879901")! // Your wallet address
        let toAddress = EthereumAddress("0x6A3738c6299f45c31697aceA647D49EdCC9C28A4")!
        let erc20ContractAddress = EthereumAddress("token.address")!
        let contract = web3.contract(Web3.Utils.erc20ABI, at: erc20ContractAddress, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        var options = TransactionOptions.defaultOptions
        options.value = amount
        options.from = walletAddress
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let method = "transfer"
        let tx = contract.write(
            method,
            parameters: [toAddress, amount] as [AnyObject],
            extraData: Data(),
            transactionOptions: options)!
    }


}

