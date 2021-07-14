//
//  EmojiStructure.swift
//  Overseas
//
//  Created by Beatrix lee on 13/07/21.
//

import Foundation
import UIKit
import SwiftUI


class UIEmojiTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                
                var isEmoji = false
                var previous = ""
                
                if(textField.text != nil){
                    previous = String(textField.text!.prefix(1))
                    textField.text = String(textField.text!.suffix(1))
                    
                    
                    for scalar in textField.text!.unicodeScalars {
                        isEmoji = scalar.properties.isEmoji
                        
                        if isEmoji {
                            break
                        }
                        print(isEmoji)
                    }
                    
                }
                
                if(isEmoji){
                    self?.parent.text = textField.text ?? ""
                }else{
                    textField.text = previous
                    self?.parent.text = textField.text ?? ""
                }
            }
        }
    }
}
