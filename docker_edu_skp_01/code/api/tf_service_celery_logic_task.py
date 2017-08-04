from __future__ import absolute_import, unicode_literals
from celery import shared_task
from .tf_service_logic import TfExamBackendService as tebs

@shared_task  
def train(num):
    print("train delay started")
    try:
        tf_class = tebs()
        #tf_result = tf_class.tf_logic_train(num)
        tf_result = tf_class.tf_logic_train_reduce_sum(num)
    except Exception as e:
        print(str(e))
        tf_result = str(e)
    return tf_result
    
    #return fib(num)
    #return 1

def fib(n):
    if n < 0:
        raise ValueError("Fibonacci Numbers >0")
    return _fib(n)

def _fib(n):
    if n == 0 or n == 1:
        print("n==0 or n==1 -> {0}".format(n))
        return n
    else:
        print("else -> {0}".format(n))
        return _fib(n - 1) + _fib(n - 2)

