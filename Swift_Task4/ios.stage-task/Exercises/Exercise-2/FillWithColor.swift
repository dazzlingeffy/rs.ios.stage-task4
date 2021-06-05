import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        var image = image
        var rrow = row
        var ccolumn = column
        
        if rrow < image.count && ccolumn < image[rrow].count {
            let oldColor = image[rrow][ccolumn]
            while image[rrow][ccolumn] == oldColor {
                image[rrow][ccolumn] = newColor
                if ccolumn == 0 && rrow != 0 {
                    rrow -= 1
                    ccolumn = image[rrow].count - 1
                } else if ccolumn != 0 {
                    ccolumn -= 1
                }
            }
            if column + 1 == image[row].count - 1 && row < image.count - 1 {
                rrow = row + 1
                ccolumn = 0
            } else if column + 1 < image[row].count {
                rrow = row
                ccolumn = column + 1
            }
            while image[rrow][ccolumn] == oldColor {
                image[rrow][ccolumn] = newColor
                if ccolumn == image[rrow].count - 1 && rrow < image.count - 1 {
                    rrow += 1
                    ccolumn = 0
                } else if ccolumn + 1 < image[rrow].count {
                    ccolumn += 1
                }
            }
        }
        return image
    }
}
