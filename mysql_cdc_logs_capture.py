import json
import boto3

from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
  DeleteRowsEvent,
  UpdateRowsEvent,
  WriteRowsEvent,
)

def main():
  kinesis = boto3.client("kinesis",region_name='us-east-1')
  stream = BinLogStreamReader(
    connection_settings= {
      "host": "database.cvg9y6fohfqa.us-east-1.rds.amazonaws.com",
      "port":3306 ,
      "user": "admin",
      "passwd": "mysql123"},
    server_id=100,
    blocking=True,
    resume_stream=True,
    only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])
  for binlogevent in stream:
    for row in binlogevent.rows:
      event = {"schema": binlogevent.schema,
      "table": binlogevent.table,
      "type": type(binlogevent).__name__,
      "row": row
      }
      kinesis.put_record(StreamName="mysql-cdc-logs-stream", Data=json.dumps(event), PartitionKey="table")
      print(json.dumps(event))
      
main()