//
//  IntentHandler.swift
//  MakePayment
//
//  Created by Van Euclid Dy on 10/7/20.
//  Copyright © 2020 Euclidean Software LLC. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is INSendPaymentIntent {
            return SendMoneyIntent()
        }
        return self
    }
}

class SendMoneyIntent: NSObject, INSendPaymentIntentHandling {
    
    func handle(intent: INSendPaymentIntent, completion: @escaping (INSendPaymentIntentResponse) -> Void) {
        if let person = intent.payee, let amount = intent.currencyAmount {
            print("person \(person.displayName) - amount \(String(describing: amount.amount))")
            completion(INSendPaymentIntentResponse(code: .success, userActivity: nil))
        } else {
            completion(INSendPaymentIntentResponse(code: .failure, userActivity: nil))
        }
    }
    
    func resolvePayee(for intent: INSendPaymentIntent, with completion: @escaping (INSendPaymentPayeeResolutionResult) -> Void) {
        if let payee = intent.payee {
            let contacts:[RestaurantContact] = RestaurantContact.allContacts()
            var result: INPersonResolutionResult?
            var matchedContacts:[RestaurantContact] = []
            for contact in contacts {
                print("checking existing: \(contact.name) - \(payee.displayName)")
                if contact.name == payee.displayName {
                    matchedContacts.append(contact)
                }
                switch matchedContacts.count {
                case 0:
                    print("no matches")
                    result = .unsupported()
                case 1:
                    print("best matched")
                    let person = matchedContacts[0].inPerson()
                    result = INPersonResolutionResult.success(with: person)
                default:
                    print("more then one match")
                    let person:[INPerson] = matchedContacts.map {
                        contact in return contact.inPerson()
                    }
                    result = INPersonResolutionResult.disambiguation(with: person)
                }
            }
            completion(result! as! INSendPaymentPayeeResolutionResult)
        } else {
            completion(INPersonResolutionResult.needsValue() as! INSendPaymentPayeeResolutionResult)
        }
    }
}
