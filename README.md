# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>1.Install Xming </b> </br>
   - download Xming : https://sourceforge.net/projects/xming/
   - install 

   ```python
       bash /home/user/Downloads/Anaconda2-4.1.1-Linux-x86_64.sh
   ```
   ```python
       vi ~/.bashrc
       export PATH="$HOME/anaconda2/bin;$PATH"
   ```

<b>2.Install Putty</b> </br>
   - install putty :  http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html? </br>

   ```python
       conda create -n tensorflow python=2.7
       source activate tensorflow
       conda install -c conda-forge tensorflow
   ```

<b>3.Install Django</b> </br>
   - install Django, Django Rest Framework and Postgresql plugin</br>

   ```python
       [Django]
       conda install -c anaconda django=1.9.5
       [Django Rest Frame Work]
       conda install -c ioos djangorestframework=3.3.3
       [postgress plugin]
       conda install -c anaconda psycopg2=2.6.1
       [pygments]
       conda install -c anaconda pygments=2.1.3
   ```

<b>4.Install Postgresql</b> </br>

   - install</br>
   ```python
       yum install postgresql-server
   ```

   - check account and set pass</br>
   ```python
       cat /etc/passwd | grep postgres
       sudo passwd postgres
   ```

   - check PGDATA</br>
   ```python
       cat /var/lib/pgsql/.bash_profile
       env | grep PGDATA
   ```

   - init and run</br>
   ```python
       sudo -i -u postgres
       initdb
       pg_ctl start
       ps -ef | grep postgress
   ```

   - connect and create database</br>
   ```python
      # psql
       postgres=# create database tensormsa  ;
       postgres=# select *   from pg_database  ;
   ```

   - create user for TesorMsA</br>
   ```python
       postgres=#CREATE USER tfmsauser WITH PASSWORD '1234';
       postgres=#ALTER ROLE tfmsauser SET client_encoding TO 'utf8';
       postgres=#ALTER ROLE tfmsauser SET default_transaction_isolation TO 'read committed';
       postgres=#ALTER ROLE testuser SET  imezone TO 'UTC';
       postgres=#GRANT ALL PRIVILEGES ON DATABASE tensormsa TO tfmsauser;
   ```

<b>5.get TensorMSA form git</b> </br>
   ```python
       git clone https://github.com/TensorMSA/TensorMSA.git
   ```

<b>5.migrate database</b> </br>
   - get to project folder where you can see 'manage.py'</br>

   ```python
       python manage.py makemigrations
       python manage.py migrate
   ```

<b>6.run server</b> </br>
   - run server with bellow command</br>

   ```python
       ip addr | grep "inet "
       python manage.py runserver localhost:8989
   ```

# REST API / JAVA API Documents </br>
   - we are still on research process
   - will be prepared on 2017

# Contributions *[(Desigin Link)](https://docs.google.com/presentation/d/105lw-nC9a37qJvKXsyBh045pGaBa7lqbCUI4V2mfjKc/pub?start=false&loop=false&delayms=3000)*
 <p align="center">
  <img src="https://github.com/TensorMSA/TensorMSA/blob/master/HOYA%20F_W%20Design%20Document.jpg?raw=true" width="750"/>
 </p>

 <b>1. Data Base</b> </br>
   - Train history data
   - Work Flow data
   - Data Preprocess with spark & UI
   - GPU Cluster server info
   - SSO & Authority (manager, servers, mobile users)
   - Neural Network UI/UX config data
   - odit columns
   - schedule job info
   - plugin info
   - convert vchar field to json (case use json)
   - store file type data on postgresql
   - store raw text data
   - store dictionary (for RNN)
   - store video, audio
   - Code based Custom Neural Net info store
  


 <b>2. View</b>     
   - Intro Page : notice pops up and etc
   - Top Menu : server management, user management, workflow, batch jobs, neural nets, plugins, etc
   - NeuralNet Menu : steps we have now, but will be related on workflow nodes
   - WorkFlow Menu : define extract data(ETL), preprocess, neuralnet, etc
   - Batch jobs : time or event based Workflow waker
   - Server Management : manage Hadoop, Hbase, Spark, Database, etc server ip & port



 <b>3. Neural Net</b>        
   - basic : linear regression, logistic regression, clustering     
   - more nets : rnn, residual, lrcn, auto encoder
