#!/usr/bin/env python3

import sys
import fileinput


def ascii_to_num_array(s):
    new = "{ "
    for c in s:
        new += "{:d}, ".format(ord(c) - 0x41)
    new += "}"
    return new


def main():
    with open("in") as f:
        secret = f.readline().strip()
    replacer = ascii_to_num_array(secret)
    print("replacer: ", replacer)

    fin = open("template_reader.c", "r")
    fout = open("reader.c", "w")
    for line in fin.readlines():
        new = line.replace("__TEMPLATE__", replacer)
        fout.write(new)
    fin.close()
    fout.close()


if __name__ == "__main__":
    sys.exit(main())
