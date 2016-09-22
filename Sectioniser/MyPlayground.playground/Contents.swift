//: Playground - noun: a place where people can play

import UIKit

let ds = 9
let i = 4

var sections: Int = ds / 4 + 1

func ips(s: Int) -> Int {
    if (s + 1) * i > ds {
        return ds % i
    }
    return i
}

ips(0)
ips(1)
ips(2)