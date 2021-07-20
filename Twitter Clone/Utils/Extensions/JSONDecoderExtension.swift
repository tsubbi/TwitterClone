//
//  JSONDecoderExtension.swift
//  Twitter Clone
//
//  Created by Jamie Chen on 2021-07-23.
//

import Foundation

extension JSONDecoder {
    // handles decoding function and handles error along the way
    func decodeAndHandlesError<T: Decodable>(_ type: T.Type,
                                             from data: Data,
                                             dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("could not find key \(key) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.valueNotFound(let type, let context) {
            print("could not find type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.typeMismatch(let type, let context) {
            print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.dataCorrupted(let context) {
            print("data found to be corrupted in JSON: \(context.debugDescription)")
            return nil
        } catch {
            print("unable to decode please check the data")
            return nil
        }
    }
}
