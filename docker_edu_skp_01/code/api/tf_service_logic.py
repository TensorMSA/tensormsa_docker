import tensorflow as tf
import logging
import numpy as np
class TfExamBackendService():
    def tf_logic(self, a, b):
        print("#### tf_logic_add a+b start ####")

        a = tf.constant(a)
        b = tf.constant(b)
        c = tf.add(a,b)

        sess = tf.Session()
        result = sess.run(c)
        sess.close()
        print(result)
        return result
    def tf_logic_train(self, count):
        print("#### tf_logic_train start ####")
        a = tf.Variable(0, name='counter')
        c = tf.assign_add(a, 1, name='increment')
            
        with tf.Session() as sess:
             sess.run(tf.global_variables_initializer())
             for i in range(count):
                 oper = sess.run(c)
             result = oper
        print("tf_logic_train result --> {0}".format(result))
        return result 
    def tf_logic_train_reduce_sum(self, count):
        print("#### tf_logic_train reduce_sum start ####")
        x = np.array([i for i in range(count)])
        c = tf.reduce_sum(x)    
        with tf.Session() as sess:
             sess.run(tf.global_variables_initializer())
             result = sess.run(c)
        print("tf_logic_train_reduce_sum result -> {0}".format(result))
        return result 


if __name__ == "__main__":
    tf_b_serv = TfExamBackendService()
    tf_b_serv.tf_logic(3,6)
    tf_b_serv.tf_logic_train_reduce_sum(10000)

