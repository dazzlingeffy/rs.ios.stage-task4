import Foundation

public extension Int {
    
    var roman: String? {
        if (self < 1 || self > 3999) {
            return nil
        }
        var res = ""
        var n = self
        if (n >= 1000) {
            for _ in 0..<(n / 1000) {
                res += "M"
            }
            n %= 1000
        }
        
        if (n > 99 && n < 400) {
            for _ in 0..<(n / 100) {
                res += "C"
            }
            n %= 100
        } else if (n > 399 && n < 500) {
            res += "CD"
            n %= 100
        } else if (n > 499 && n < 900) {
            res += "D"
            if (n > 599) {
                for _ in 0..<(n / 100 - 5) {
                    res += "C"
                }
            }
            n %= 100
        } else if (n > 899) {
            res += "CM"
            n %= 100
        }
        
        if (n > 9 && n < 40) {
            for _ in 0..<(n / 10) {
                res += "X"
            }
            n %= 10
        } else if (n > 39 && n < 50) {
            res += "XL"
            n %= 10
        } else if (n > 49 && n < 90) {
            res += "L"
            if (n > 59) {
                for _ in 0..<(n / 10 - 5) {
                    res += "X"
                }
            }
            n %= 10
        } else if (n > 89) {
            res += "XC"
            n %= 10
        }
        
        if (n > 0 && n < 4) {
            for _ in 0..<n {
                res += "I"
            }
        } else if n == 4 {
            res += "IV"
        } else if n > 4 && n < 9 {
            res += "V"
            if n > 5 {
                for _ in 0..<(n - 5) {
                    res += "I"
                }
            }
        } else if n == 9 {
            res += "IX"
        }
        return res
    }
}
