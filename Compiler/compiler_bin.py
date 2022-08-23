compDict = {
    "loadac"    : 4,
    "movacr"    : 8,
    "movacr1"   : 9,
    "movacr2"   : 10,
    "movacr3"   : 11,
    "movacr4"   : 12,
    "movacr5"   : 13,
    "movacdar"  : 14,
    "movrac"    : 15,
    "movr1ac"   : 16,
    "movr2ac"   : 17,
    "movr3ac"   : 18,
    "movr4ac"   : 19,
    "movr5ac"   : 20,
    "movdarac"  : 21,
    "stac"      : 22,
    "add"       : 25,
    "sub"       : 27,
    "lshift"    : 29,
    "rshift"    : 31,
    "incac"     : 33,
    "incdar"    : 34,
    "incr1"     : 35,
    "incr2"     : 36,
    "incr3"     : 37,
    "loadim"    : 38,
    "jumpz"     : 41,
    "jumpnz"    : 48,
    "jump"      : 49,
    "nop"       : 50,
    "endop"     : 51
}

instructionArray = open("Assembly.txt").read().splitlines()
outputFile = open("output_bin.txt", "w")
lines = []
comment = "//"

for i, instruction in enumerate(instructionArray):

    if comment in instruction:
        if comment in instruction[:3]:
            continue
        else:
            instruction = instruction.split(comment)[0]

    instruction = instruction.strip();

    if instruction in compDict:
        binaryValue = bin(compDict[instruction])[2:]
        length = 8
    else:
        val = instruction.split("'d")
        binaryValue = bin(int(val[1]))[2:]
        length = int(val[0])

    writeValue = (length-len(binaryValue))*'0'+binaryValue
    lines.append(writeValue)

outputFile.writelines("\n".join(lines))
outputFile.close()
