import Foundation

// demo at the bottom ⬇️⬇️⬇️

extension String {
    
    // search for consecutive characters as cohesive string
    func chars (string: String) -> NotRegex? {
        var ints:[Int] = []
        let array = self.componentsSeparatedByString(string)
        var pointer = 0
        for item in array {
            ints.append(item.characters.count + pointer)
            pointer += item.characters.count + string.characters.count
        }
        let arr = Array(ints[0..<ints.count - 1])
        return arr.count > 0 ? NotRegex(indexes: arr, string: self, parts: array) : nil
    }
    
    // search for discrete characters individually
    func chars (characters: [Character]) -> NotRegex? {
        var ints:[[Int]] = []
        var charsThusFar:[Character] = []
        for char in characters {
            if !charsThusFar.contains(char) {
                charsThusFar.append(char)
                if let charInts = chars(char) {
                    ints.append(charInts.indexes)
                }
            }
        }
        return ints.count > 0 ? NotRegex(indexes: ints.flatMap {$0}.sort(), string: self, parts: nil) : nil
    }
    
    // search for individual characters
    func chars (character: Character) -> NotRegex? {
        var ints:[Int] = []
        for (index, element) in self.characters.enumerate() {
            if element == character {
                ints.append(index)
            }
        }
        return ints.count > 0 ? NotRegex(indexes: ints, string: self, parts: nil) : nil
    }
    
}

public struct NotRegex {
    let indexes: [Int]
    let string: String
    let parts: [String]?
}

extension NotRegex {
    
    func replaceWith (replaceWith: String) -> String {
        if let parts = self.parts {
            return parts.joinWithSeparator(replaceWith)
        }
        return self.string
    }

    func replaceWith (replaceWith: Character) -> String {
        var chars = Array(self.string.characters)
        for index in self.indexes {
            chars[index] = replaceWith
        }
        return String(chars)
    }
    
    func chars (string: String) -> NotRegex? {
        return self.string.chars(string)
    }
    
    func chars (characters: [Character]) -> NotRegex? {
        return self.string.chars(characters)
    }
    
    func chars (character: Character) -> NotRegex? {
        return self.string.chars(character)
    }
}



"f̤̬͕̳͇̰̗̿͑̏̇̕̕͟͝ą͚͓͇̥̂́̽̍̕͢ņ͙͉̣̪̞͙͎͌́̄͂͐̕͟t̸̻̭̝̣̳̯̙͍̥̿̍̐͂̀̈́̓̀̚͜͠ą̸̣̥̫̠̤̝̓̇͊̒̊̂̉͜͟s̸̛̳̮̪͍̗̈̄̐̈͂̏̈͐ț̵͓̤̯͇̩̩͖̀͆̽̕͘͝ǐ̸̡̨̨̫̖̒̆̑̑̅͐̚ć̸̬͈̫͚̮͂̈̀́̍̏͑̈́͘ͅ-̴̼̪͙̮̗̀̓͗͐͗́̄͘͢ç̶̠̦̝̝̼̻̈̔̑͊̑̾͘̕ḥ̶̡̢̜͚͉̘̖̥͙̏̏͒̈̃͑͊̚͞â̴̯̱̳̼̲̭̐̄͛͌͟͠͡͠ỉ̷̢͚̰͇̗̲͇̅͛̀̀̾͢ͅn͇̣͓͍̑̇̔̀̇̽͊̈͐͜͢͠s̡̛̜͖͔͉̬͂̑̈̐͂̓͢á̵̛̛̺̹̘̤͈̮͇̫̈́͐͐͋͘͟͠w̦̗͇̱̥͓̖͉̯̥̉̔̾̽̽͋̋͛̚".chars("ç̶̠̦̝̝̼̻̈̔̑͊̑̾͘̕")?.indexes // => [10]



"🍣sashimi!!!🍣".chars("🍣")?.indexes // => [0,11]
"this is a sample".chars(" ")?.indexes // => [4,7,9]
"this is a sample".chars("is")?.indexes // => [2,5]
"this is a sample".chars(Array("is".characters))?.indexes // => [2,3,5,6,10]
"nomatchexists".chars(" ")?.indexes // => nil
"🍣sashimi!!!🍣".chars("🍣")?.replaceWith("🍺").chars("sashimi!!!")?.replaceWith("beer!!!!") // => ["🍺beer!!!!🍺"]


