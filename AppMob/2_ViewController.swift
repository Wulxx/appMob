//
//  2_ViewController.swift
//  AppMob
//
//  Created by Yoan Delvaux on 25/11/2019.
//  Copyright © 2019 Yoan Delvaux. All rights reserved.
//

import UIKit

class __ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBAction func tappedNewQuoteButton(_ sender: Any) {
     QuoteService.getQuote { (success, quote) in
                if success, let quote = quote {
                    self.update(quote: quote)
                } else {
                    self.presentAlert()
                }
            }
        }

        private func update(quote: Quote) {
            quoteLabel.text = quote.text
            authorLabel.text = quote.author
            imageView.image = UIImage(data: quote.imageData)
        }

        private func presentAlert() {
            let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
}
