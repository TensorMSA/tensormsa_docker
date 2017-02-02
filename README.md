# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>1.Install Xming </b> </br>
   - download Xming : https://sourceforge.net/projects/xming/ </br>
   - install 

<b>2.Install Putty</b> </br>
   - install putty :  http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html? 

<b>3.Connect AWS EC2 Instance</b> </br>
   - .....</br>

<b>4.Git clone</b> </br>

<b>5.Docker build</b> </br>
   ```bash
     docker build --rm -t hoyai/client:v0.1 .
   ```
   - You can change name and version [hoyai/client:v0.1] </br>
   
<b>6.Docker run</b> </br>
   ```bash
     docker run -itd --name hoyai_dev -p 2266:2266 -p 5432:5432 -p 8000:8000 --volume /root/data/:/root/lib/ hoyai/client:v0.1
   ```
<b>7.Connect hoyai_dev directly and Change root password</b> </br>
   - docker exec -it hoyai_dev bash
   ```bash
       passwd root
   ```
 
 <b>8.Connect hoyai_dev by ssh </b> </br>
   - putty -> connection -> ssh -> X11 -> Enable X11 forwarding check
   - Connect AWS, Port : 2266 

 <b>9.Run pycharm </b> </br>
   - putty -> connection -> ssh -> X11 -> Enable X11 forwarding check
   - Connect AWS, Port : 2266 
   
   - You can change name and version [hoyai/client:v0.1] </br>   
   ```bash 
       cd /dev/home/pyc/bin
       ./pycharm.sh &
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
