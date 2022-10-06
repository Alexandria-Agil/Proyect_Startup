docker tag proyect_startup-db $1/proyect_startup-db
docker push $1/proyect_startup-db

docker tag nuxt_dev $1/nuxt_dev
docker push $1/nuxt_dev

docker tag nuxt_dev2 $1/nuxt_dev2
docker push $1/nuxt_dev2

docker tag proyect_startup-api $1/proyect_startup-api
docker push $1/proyect_startup-api

docker tag proyect_startup-nginx $1/proyect_startup-nginx
docker push $1/proyect_startup-nginx