import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS
import json
import subprocess

bucket = "<my-bucket>"
org = "<my-org>"
token = "<my-token>"
url="<my-url>"

client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)

if __name__ == "__main__":
  try:
    proc = subprocess.Popen(['./bsec_bme68x'], stdout=subprocess.PIPE)

    lineDict = {}

    # now read the input
    for line in iter(proc.stdout.readline, ''):
      try:
        lineJSON = json.loads(line.decode("utf-8")) 
        lineDict = dict(lineJSON)
      except Exception as e:
        print(f"Can't parse {line}, error: {e}")
        continue

      print(lineDict)

      # listTemperature.append(float(lineDict['Temperature']))
      # listHumidity.append(float(lineDict['Humidity']))
      # listGas.append(int(lineDict['Gas']))
      # listPressure.append(float(lineDict['Pressure']))
      # listIAQ_Accuracy.append(int(lineDict['IAQ_Accuracy']))
      # listIAQ.append(float(lineDict['IAQ']))
      # listStatic_IAQ.append(float(lineDict['Static_IAQ']))
      # listeCO2.append(float(lineDict['eCO2']))
      # listbVOCe.append(float(lineDict['bVOCe']))
      # listStatus.append(int(lineDict['Status']))

  except Exception as e:
    print(e)

