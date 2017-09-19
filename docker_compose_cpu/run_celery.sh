#!/bin/bash
cd /home/dev/tensormsa
celery -A hoyai worker -l info
