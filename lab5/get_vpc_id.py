import json
import sys
from pprint import pprint
jdata = sys.stdin.read()
data = json.loads(jdata)
print(data["Vpcs"][0]["VpcId"])