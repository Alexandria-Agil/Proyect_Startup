docker tag proyect_startup-db $1/proyect_startup-db
docker push $1/proyect_startup-db

docker tag nuxt_dev $1/nuxt_dev
docker push $1/nuxt_dev

docker tag proyect_startup-api $1/proyect_startup-api
docker push $1/proyect_startup-api