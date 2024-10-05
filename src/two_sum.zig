const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const a = [10]i32{ 10, 22, 5, 75, 65, 80, 30, 90, 50, 3 };
    const target = 85;
    try two_sum(&a, target);
}

fn two_sum(arr: []const i32, target: i32) error{OutOfMemory}!void {
    var map = std.AutoHashMap(i32, usize).init(allocator);
    defer map.deinit();

    // put the items and indicies into the map
    for (arr, 0..) |item, index| {
        try map.put(item, index);
    }

    for (arr, 0..) |item, index| {
        const other = map.get(target - item);
        if (other) |v| {
            if (v != index) {
                std.debug.print("{d}, {d}\n", .{ index, v });
                break;
            }
        }
    }
}
