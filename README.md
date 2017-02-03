# TensorMSA : Tensorflow Micro Service Architecture


# Install

<b>History</b> </br>
 - 16.2.3             Initial</br>
 - 16.2.4             Firefox Fix, Chrome Installed, Korean Font Installed/br>

<b>Summeries</b> </br>
 - python 3.5
 - conda
 - Tensorflow r0.12
 - Django
 - postgres 9.6
 - Pycharm Comunity 
 - Chrome
 - python packages for hoyai
 

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
   ```bash
      docker exec -it hoyai_dev bash
   ```
   ```bash
       passwd root
   ```
 
<b>8.Connect hoyai_dev by SSH </b> </br>
   - putty -> connection -> ssh -> X11 -> Enable X11 forwarding check
   - Connect AWS, Port : 2266 

<b>9.Run Pycharm </b> </br>
   ```bash
       /home/dev/pyc/bin/pycharm.sh &
   ```
   
 <b>10.Run Chrome </b> </br>
   ```bash
       /usr/bin/google-chrome --no-sandbox
   ```
