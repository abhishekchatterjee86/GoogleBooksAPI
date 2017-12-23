//
//  Either.swift
//  ListGoogleBooks
//
//  Created by Abhishek Chatterjee on 23/12/17.
//  Copyright © 2017 Abhishek Chatterjee. All rights reserved.
//

import Foundation

enum Either<L, R> {

    case left(L)
    case right(R)

}
