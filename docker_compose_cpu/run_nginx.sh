#!/bin/bash
cd /home/dev/tensormsa
gunicorn hoyai.wsgi -b 0.0.0.0:8000 &
