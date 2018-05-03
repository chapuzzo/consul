#!/bin/bash


docker-compose -f docker-compose-ondara.yml exec --user=1000:1000 web sh
