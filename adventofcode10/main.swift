//
//  main.swift
//  adventofcode10
//
//  Created by Cruse, Si on 12/10/18.
//  Copyright © 2018 Cruse, Si. All rights reserved.
//

import Foundation

//    --- Day 10: The Stars Align ---
//    It's no use; your navigation system simply isn't capable of providing walking directions in the arctic circle, and certainly not in 1018.
//
//    The Elves suggest an alternative. In times like these, North Pole rescue operations will arrange points of light in the sky to guide missing Elves back to base. Unfortunately, the message is easy to miss: the points move slowly enough that it takes hours to align them, but have so much momentum that they only stay aligned for a second. If you blink at the wrong time, it might be hours before another message appears.
//
//    You can see these points of light floating in the distance, and record their position in the sky and their velocity, the relative change in position per second (your puzzle input). The coordinates are all given from your perspective; given enough time, those positions and velocities will move the points into a cohesive message!
//
//    Rather than wait, you decide to fast-forward the process and calculate what the points will eventually spell.
//
//    For example, suppose you note the following points:
//
//    position=< 9,  1> velocity=< 0,  2>
//    position=< 7,  0> velocity=<-1,  0>
//    position=< 3, -2> velocity=<-1,  1>
//    position=< 6, 10> velocity=<-2, -1>
//    position=< 2, -4> velocity=< 2,  2>
//    position=<-6, 10> velocity=< 2, -2>
//    position=< 1,  8> velocity=< 1, -1>
//    position=< 1,  7> velocity=< 1,  0>
//    position=<-3, 11> velocity=< 1, -2>
//    position=< 7,  6> velocity=<-1, -1>
//    position=<-2,  3> velocity=< 1,  0>
//    position=<-4,  3> velocity=< 2,  0>
//    position=<10, -3> velocity=<-1,  1>
//    position=< 5, 11> velocity=< 1, -2>
//    position=< 4,  7> velocity=< 0, -1>
//    position=< 8, -2> velocity=< 0,  1>
//    position=<15,  0> velocity=<-2,  0>
//    position=< 1,  6> velocity=< 1,  0>
//    position=< 8,  9> velocity=< 0, -1>
//    position=< 3,  3> velocity=<-1,  1>
//    position=< 0,  5> velocity=< 0, -1>
//    position=<-2,  2> velocity=< 2,  0>
//    position=< 5, -2> velocity=< 1,  2>
//    position=< 1,  4> velocity=< 2,  1>
//    position=<-2,  7> velocity=< 2, -2>
//    position=< 3,  6> velocity=<-1, -1>
//    position=< 5,  0> velocity=< 1,  0>
//    position=<-6,  0> velocity=< 2,  0>
//    position=< 5,  9> velocity=< 1, -2>
//    position=<14,  7> velocity=<-2,  0>
//    position=<-3,  6> velocity=< 2, -1>
//    Each line represents one point. Positions are given as <X, Y> pairs: X represents how far left (negative) or right (positive) the point appears, while Y represents how far up (negative) or down (positive) the point appears.
//
//    At 0 seconds, each point has the position given. Each second, each point's velocity is added to its position. So, a point with velocity <1, -2> is moving to the right, but is moving upward twice as quickly. If this point's initial position were <3, 9>, after 3 seconds, its position would become <6, 3>.
//
//    Over time, the points listed above would move like this:
//
//    Initially:
//    ........#.............
//    ................#.....
//    .........#.#..#.......
//    ......................
//    #..........#.#.......#
//    ...............#......
//    ....#.................
//    ..#.#....#............
//    .......#..............
//    ......#...............
//    ...#...#.#...#........
//    ....#..#..#.........#.
//    .......#..............
//    ...........#..#.......
//    #...........#.........
//    ...#.......#..........
//
//    After 1 second:
//    ......................
//    ......................
//    ..........#....#......
//    ........#.....#.......
//    ..#.........#......#..
//    ......................
//    ......#...............
//    ....##.........#......
//    ......#.#.............
//    .....##.##..#.........
//    ........#.#...........
//    ........#...#.....#...
//    ..#...........#.......
//    ....#.....#.#.........
//    ......................
//    ......................
//
//    After 2 seconds:
//    ......................
//    ......................
//    ......................
//    ..............#.......
//    ....#..#...####..#....
//    ......................
//    ........#....#........
//    ......#.#.............
//    .......#...#..........
//    .......#..#..#.#......
//    ....#....#.#..........
//    .....#...#...##.#.....
//    ........#.............
//    ......................
//    ......................
//    ......................
//
//    After 3 seconds:
//    ......................
//    ......................
//    ......................
//    ......................
//    ......#...#..###......
//    ......#...#...#.......
//    ......#...#...#.......
//    ......#####...#.......
//    ......#...#...#.......
//    ......#...#...#.......
//    ......#...#...#.......
//    ......#...#..###......
//    ......................
//    ......................
//    ......................
//    ......................
//
//    After 4 seconds:
//    ......................
//    ......................
//    ......................
//    ............#.........
//    ........##...#.#......
//    ......#.....#..#......
//    .....#..##.##.#.......
//    .......##.#....#......
//    ...........#....#.....
//    ..............#.......
//    ....#......#...#......
//    .....#.....##.........
//    ...............#......
//    ...............#......
//    ......................
//    ......................
//    After 3 seconds, the message appeared briefly: HI. Of course, your message will be much longer and will take many more seconds to appear.
//
//    What message will eventually appear in the sky?

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T]
    init(rows: Int, columns: Int,defaultValue: T) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: defaultValue, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    var row_range: ClosedRange<Int> { return 0...self.rows - 1 }
    var column_range: ClosedRange<Int> { return 0...self.columns - 1 }
}

class Point: Hashable, CustomDebugStringConvertible {
    var locus: (x: Int, y: Int)
    var velocity: (x: Int, y: Int)
    
    init(locus: (x: Int, y: Int), velocity: (x: Int, y: Int)) {
        self.locus = locus
        self.velocity = velocity
    }

    convenience init(point: (locus: (x: Int, y: Int), velocity: (x: Int, y: Int))) {
        self.init(locus: point.locus, velocity: point.velocity)
    }
    
    func move(_ direction: Int = 1) {
        locus.x += velocity.x * direction
        locus.y += velocity.y * direction
    }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.locus == rhs.locus && lhs.velocity == rhs.velocity
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(locus.x)
        hasher.combine(locus.y)
        hasher.combine(velocity.x)
        hasher.combine(velocity.y)
    }
    
    var debugDescription: String {
        return "locus \(locus), velocity \(velocity)"
    }
}

class Points: CustomDebugStringConvertible {
    private var _points: [Point]
    
    init(points: [(locus: (x: Int, y: Int), velocity: (x: Int, y: Int))]) {
        self._points = points.map{ Point(point: $0) }
    }
    
    convenience init(input: [String]) {
        self.init(points: Points.hydrate(input: input))
    }
    
    convenience init(contentsOf: URL) {
        do {
            let data = try String(contentsOf: contentsOf)
            let strings = data.components(separatedBy: .newlines)
            self.init(input: strings.filter({ $0.count > 0 }))
        } catch {
            print(error)
            self.init(input: [])
        }
    }
    
    func animate(_ direction: Int = 1) {
        for p in _points { p.move(direction) }
    }
    
    func calculatealignment() -> (canvas: (width: Int, height: Int), centre: (x: Int, y: Int)) {
        let origin = (
            x: _points.min(by: { $0.locus.x < $1.locus.x })!.locus.x,
            y: _points.min(by: { $0.locus.y < $1.locus.y })!.locus.y
        )
        let canvas = (
            width: _points.max(by: { $0.locus.x < $1.locus.x })!.locus.x - origin.x + 1,
            height: _points.max(by: { $0.locus.y < $1.locus.y })!.locus.y - origin.y + 1
        )
        let centre = (
            x: origin.x,
            y: origin.y
        )
        return (canvas, centre)
    }
    
    private func calculatemap() -> Matrix<Character?> {
        let (canvas, centre) = calculatealignment()
        var map = Matrix<Character?>(rows: canvas.height, columns: canvas.width, defaultValue: ".")
        for p in _points {
            let x = p.locus.x - centre.x, y = p.locus.y - centre.y
            if x >= 0 && x < canvas.width && y >= 0 && y < canvas.height {
                map[y,x] = "#"
            }
        }
        
        return map
    }
    
    // Load data
    private static func hydrate(input: [String]) -> [(locus: (x: Int, y: Int), velocity: (x: Int, y: Int))] {
        return input.map { (line) -> (locus: (x: Int, y: Int), velocity: (x: Int, y: Int)) in
            let elements = line.split(separator: "<")
            let locxy = elements[1].split(separator: ">")[0].split(separator: ",")
            let velxy = elements.last!.split(separator: ">")[0].split(separator: ",")
            let locus: (x: Int, y: Int) = (Int(String(locxy[0]).trim())!, Int(String(locxy[1]).trim())!)
            let velocity: (x: Int, y: Int) = (Int(String(velxy[0]).trim())!, Int(String(velxy[1]).trim())!)
            return (locus, velocity)
        }
    }
    
    var debugDescription: String {
        var result = ""
        let map = calculatemap()
        for row in map.row_range {
            var line = ""
            for column in map.column_range {
                line += String(map[row, column]!)
            }
            result += line + "\n"
        }
        return result
    }
}

let challenge_test_1 = [
    "position=< 9,  1> velocity=< 0,  2>",
    "position=< 7,  0> velocity=<-1,  0>",
    "position=< 3, -2> velocity=<-1,  1>",
    "position=< 6, 10> velocity=<-2, -1>",
    "position=< 2, -4> velocity=< 2,  2>",
    "position=<-6, 10> velocity=< 2, -2>",
    "position=< 1,  8> velocity=< 1, -1>",
    "position=< 1,  7> velocity=< 1,  0>",
    "position=<-3, 11> velocity=< 1, -2>",
    "position=< 7,  6> velocity=<-1, -1>",
    "position=<-2,  3> velocity=< 1,  0>",
    "position=<-4,  3> velocity=< 2,  0>",
    "position=<10, -3> velocity=<-1,  1>",
    "position=< 5, 11> velocity=< 1, -2>",
    "position=< 4,  7> velocity=< 0, -1>",
    "position=< 8, -2> velocity=< 0,  1>",
    "position=<15,  0> velocity=<-2,  0>",
    "position=< 1,  6> velocity=< 1,  0>",
    "position=< 8,  9> velocity=< 0, -1>",
    "position=< 3,  3> velocity=<-1,  1>",
    "position=< 0,  5> velocity=< 0, -1>",
    "position=<-2,  2> velocity=< 2,  0>",
    "position=< 5, -2> velocity=< 1,  2>",
    "position=< 1,  4> velocity=< 2,  1>",
    "position=<-2,  7> velocity=< 2, -2>",
    "position=< 3,  6> velocity=<-1, -1>",
    "position=< 5,  0> velocity=< 1,  0>",
    "position=<-6,  0> velocity=< 2,  0>",
    "position=< 5,  9> velocity=< 1, -2>",
    "position=<14,  7> velocity=<-2,  0>",
    "position=<-3,  6> velocity=< 2, -1>"
]

// Path to the problem input data
let path = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("input.txt")

let testpoints = Points(input: Array(challenge_test_1))

let points = Points(contentsOf: path)

var done = false
var lastheight: Int? = nil
repeat {
    testpoints.animate()
    let (canvas, _ ) = testpoints.calculatealignment()
    if canvas.height > lastheight ?? canvas.height + 1 {
        testpoints.animate(-1)
        print("The TEST answer is \n\n\(testpoints)\n")
        done = true
    } else { lastheight = canvas.height }
} while !done

done = false
lastheight = nil
var secs = 0
repeat {
    points.animate()
    secs += 1
    let (canvas, _ ) = points.calculatealignment()
    if canvas.height > lastheight ?? canvas.height + 1 {
        points.animate(-1)
        print("The FIRST CHALLENGE answer is \n\n\(points)\n")
        print("The SECOND CHALLENGE answer is \(secs) seconds\n")
        done = true
    } else { lastheight = canvas.height }
} while !done
