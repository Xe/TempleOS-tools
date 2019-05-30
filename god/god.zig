const mem = @import("std").mem;
const copy = mem.copy;
const Allocator = mem.Allocator;
const Stack = @import("std").atomic.Stack;
var alloc = @import("std").heap.wasm_allocator;
const fmt = @import("std").fmt;

const olin = @import("./olin/olin.zig");
const Resource = olin.resource.Resource;
const words = @embedFile("./Vocab.DD");
const numWordsInFile = 7570;

export fn cwa_main() i32 {
    main() catch unreachable;

    return 0;
}

fn main() !void {
    var god = try God.init();
    var written: usize = 0;
    const stdout = try Resource.stdout();
    const space = " ";
    const nl = "\n";

    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());
    god.add_bits(32, olin.random.int32());

    var i: usize = 0;
    while (i < 15) : (i += 1) {
        const w = god.get_word();
        written += (w.len + 1);
        const ignored = stdout.write(w.ptr, w.len);
        const ignored_also = stdout.write(&space, space.len);

        if (written >= 70) {
            const ignored_again = stdout.write(&nl, nl.len);
            written = 0;
        }
    }
    const ignored_again = stdout.write(&nl, nl.len);
}

fn putInt(val: usize) !void {
    var thing: []u8 = try alloc.alloc(u8, 16);
    const leng = fmt.formatIntBuf(thing, val, 10, false, 0);
    olin.log.info(thing[0..leng]);
}

const God = struct {
    words: [][]const u8,
    bits: *Stack(u8),

    fn init() !*God {
        var result: *God = undefined;

        var stack = Stack(u8).init();
        result = try alloc.create(God);
        result.words = try splitWords(words[0..words.len], numWordsInFile);
        result.bits = &stack;

        return result;
    }

    fn add_bits(self: *God, num_bits: i64, n: i64) void {
        var i: i64 = 0;
        var nn = n;
        while (i < num_bits) : (i += 1) {
            var node = alloc.create(Stack(u8).Node) catch unreachable;
            node.* = Stack(u8).Node {
                .next = undefined,
                .data = @intCast(u8, nn & 1),
            };
            self.bits.push(node);
            nn = nn >> 1;
        }
    }

    fn get_word(self: *God) []const u8 {
        const gotten = @mod(self.get_bits(14), numWordsInFile);
        const word = self.words[@intCast(usize, gotten)];
        return word;
    }

    fn get_bits(self: *God, num_bits: i64) i64 {
        var i: i64 = 0;
        var result: i64 = 0;
        while (i < num_bits) : (i += 1) {
            const n = self.bits.pop();

            if (n) |nn| {
                result = result + @intCast(i64, nn.data);
                result = result << 1;
            } else {
                break;
            }
        }

        return result;
    }
};

fn splitWords(data: []const u8, numWords: u32) ![][]const u8 {
    var result: [][]const u8 = try alloc.alloc([]const u8, numWords);
    var ctr: usize = 0;

    var itr = mem.separate(data, "\n");
    var done = false;
    while (!done) {
        var val = itr.next();
        if (val) |str| {
            if (str.len == 0) {
                done = true;
                continue;
            }
            result[ctr] = str;
            ctr += 1;
        } else {
            done = true;
            break;
        }
    }

    return result;
}
