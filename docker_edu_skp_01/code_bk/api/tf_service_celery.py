import tensorflow as tf
from rest_framework.response import Response
from rest_framework.views import APIView
import json
from api.tf_service_celery_logic_task import train
import logging

class TfServiceCelry(APIView):
    def post(self, request,values):
        try : 
            logging.info("celery test start")
            result = train.delay(int(values))
            result_data = {"status": "200", "result": str(result)}
            return Response(json.dumps(result_data))
        except Exception as e:
            logging.error(str(e))
            raise
    def put(self, request,values):
        result_data = {"status": "200", "result": "put"}
        return Response(json.dumps(result))
    def delete(self, request,values):
        result_data = {"status": "200", "result": "delete"}
        return Response(json.dumps(result))
    def get(self, request,values):
        result_data = {"status": "200", "result": "get"}
        return Response(json.dumps(result))
