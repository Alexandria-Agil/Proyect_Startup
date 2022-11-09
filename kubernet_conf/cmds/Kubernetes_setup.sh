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


##REPOSITORY rafaruizc
docker tag proyect_startup_db rafaruizc/proyect_startup_db && docker tag proyect_startup_api rafaruizc/proyect_startup_api && docker tag nuxt_dev rafaruizc/nuxt_dev && docker tag nuxt_dev2 rafaruizc/nuxt_dev2 && docker tag proyect_startup_nginx rafaruizc/proyect_startup_nginx && docker tag proyect_startup_fastapi rafaruizc/proyect_startup_fastapi
docker push rafaruizc/proyect_startup_db && docker push rafaruizc/proyect_startup_api && docker push rafaruizc/nuxt_dev && docker push rafaruizc/nuxt_dev2 && docker push rafaruizc/proyect_startup_nginx && docker push rafaruizc/proyect_startup_fastapi