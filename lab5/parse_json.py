import json
import sys
from pprint import pprint
jdata = sys.stdin.read()
data = json.loads(jdata)


def parse_json(json_dict,*argv):
    ret = None
    for level in argv:
        if ret:
            if isinstance(ret,list):
                ret = ret[int(level)]
            else:
                ret = ret[level]
        else:
            ret = json_dict[level]

    print(ret)

arguments = sys.argv[1:]

parse_json(data,*arguments)