import json
import sys
from pprint import pprint
jdata = sys.stdin.read()
data = json.loads(jdata)
print(data["Subnets"][0]["SubnetId"])