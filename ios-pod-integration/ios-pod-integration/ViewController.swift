//
//  ViewController.swift
//  ios-pod-integration
//
//  Created by Petr Korolev on 19.01.2020.
//  Copyright © 2020 Petr Korolev. All rights reserved.
//

import UIKit
import web3swift

struct Wallet {
    let address: String
    let data: Data
    let name: String
    let isHD: Bool
}

struct HDKey {
    let name: String?
    let address: String
}

class ViewController: UIViewController {
    @IBOutlet weak var seed_tv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gen_key(self)
        // Do any additional setup after loading the view.
        
    }
    @IBOutlet weak var pub_label: UILabel!
    
    @IBAction func gen_key(_ sender: Any) {
        let password = "web3swift"
        let bitsOfEntropy: Int = 128 // Entropy is a measure of password strength. Usually used 128 or 256 bits.
        let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy)!
        let keystore = try! BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            mnemonicsPassword: "",
            language: .english)!
        let name = "New HD Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: true)
        pub_label.text = address
        pub_label.adjustsFontSizeToFitWidth = true
        seed_tv.text = mnemonics
        
    }
    
}

