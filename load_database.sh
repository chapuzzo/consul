#!/bin/bash

docker-compose -f docker-compose-ondara.yml up -d db
docker-compose -f docker-compose-ondara.yml run --rm web rake db:create
docker-compose -f docker-compose-ondara.yml run --rm web rake db:migrate
docker-compose -f docker-compose-ondara.yml run --rm web rake db:seed
docker-compose -f docker-compose-ondara.yml run --rm web rake db:dev_seed
