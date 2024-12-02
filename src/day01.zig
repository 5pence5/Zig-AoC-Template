const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

pub fn main() !void {
    var lines = tokenizeSeq(u8, data, "\n");

    // Create ArrayLists to store the columns
    var left_column = List(i64).init(gpa);
    defer left_column.deinit();
    var right_column = List(i64).init(gpa);
    defer right_column.deinit();

    // Process each line
    while (lines.next()) |line| {
        // Tokenize each line by spaces
        var parts = tokenizeSca(u8, line, ' ');
        if (parts.next()) |left| {
            if (parts.next()) |right| {
                // Add the left and right columns to the ArrayLists
                const left_num = try parseInt(i64, left, 10);
                const right_num = try parseInt(i64, right, 10);

                try left_column.append(left_num);
                try right_column.append(right_num);
            }
        }
    }
    // Sort the columns in ascending order
    sort(i64, left_column.items, {}, asc(i64));
    sort(i64, right_column.items, {}, asc(i64));

    print("\n=== First 5 entries from each column ===\n\n", .{});
    const items_to_print = @min(left_column.items.len, 5);
    print("Left Column    Right Column\n", .{});
    print("-----------    ------------\n", .{});
    var i: usize = 0;
    while (i < items_to_print) : (i += 1) {
        print("{:10}    {:10}\n", .{
            left_column.items[i],
            right_column.items[i],
        });
    }
}

// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
