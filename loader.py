#!/usr/bin/python3

import os

dom = "https://t4.bcbits"
dom_len = 0x11
cnt = 0

url = input()
os.system("wget '" + url + "' -O loaderoutput")

offs_read = 0
#offs_read = 2**10

f = open("loaderoutput","r")
l = f.readlines()[offs_read:]
f.close()

for lines in l:
    for bpos, b in enumerate(lines):
        if cnt == dom_len-1:
            print(lines[bpos-dom_len+1:bpos+200])
            cnt = 0
        if b == dom[cnt]:
            cnt += 1
        else:
            cnt = 0
