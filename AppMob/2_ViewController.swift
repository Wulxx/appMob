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
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func tappedNewQuoteButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
            QuoteService.shared.getQuote { (success, quote) in
                self.toggleActivityIndicator(shown: false)

                if success, let quote = quote {
                    self.update(quote: quote)
                } else {
                    self.presentAlert()
                }
            }
        }

        private func toggleActivityIndicator(shown: Bool) {
            activityIndicator.isHidden = !shown
        }
   
        private func update(quote: Quote) {
            quoteTextView.alpha = 0
            imageView.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.alpha = 1
                self.quoteTextView.alpha = 1
            }) { (true) in
            }
            
            quoteTextView.text = quote.text
            authorLabel.text = quote.author
            imageView.image = UIImage(data: quote.imageData)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTextView.isEditable = false
    }

        private func presentAlert() {
            let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
}
