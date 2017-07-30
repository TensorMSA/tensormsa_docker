import tensorflow as tf
import logging
class TfExamBackendService():
    def tf_logic(self, a, b):
        print(tf.__version__)

        a = tf.constant(a)
        b = tf.constant(b)
        c = tf.add(a,b)

        sess = tf.Session()
        result = sess.run(c)
        sess.close()
        print(result)
        return result
    def tf_logic_train(count):
        print("tf_logic_train started")
        a = tf.Variable(0, name='counter')
        with tf.Session() as sess:
             sess.run(tf.global_variables_initializer())
             for i in range(count+1):
                 c = tf.assign_add(a, i, name='increment')
                 oper = sess.run(c)
                 logging.info("tensorflow runnung -> {0}".format(oper))
             result = oper
        print("tensorflow end -> {0}".format(result))
        return result 

if __name__ == "__main__":
    tf_b_serv = TfExamBackendService()
    tf_b_serv.tf_logic_train(100)

