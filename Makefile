push:
	git push

generate:
	ls -lha /var/blog
	du -hs *
	hugo
	du -hs *

preview:
	hugo server --bind 0.0.0.0

TS := $(date)
public:
	git clone -b master git@github.com:Gonzih/gonzih.github.com.git public

deploy: public
	cd public \
	&& git add  . \
	&& (git commit -a -m "Blog updated at $(shell date)"  || echo "Nothing to commit") \
	&& git push \
	&& cd ..

USER=$(shell whoami)
UID=$(shell id -u $(USER))
docker-image:
	docker build --build-arg GNZHUID=$(UID) -t blog-builder .

docker-rm:
	docker kill blog-builder || echo "Not found"
	docker rm blog-builder || echo "Not found"

generate-using-docker: docker-image docker-rm public
	docker run --rm -t -v $(shell pwd):/var/blog --name blog-builder blog-builder make generate

deploy-using-docker: public
	make generate-using-docker
	make deploy
	make push

preview-using-docker: docker-image docker-rm public
	docker run --rm -t -v $(shell pwd):/var/blog -p 1313:1313 --name blog-builder blog-builder make preview

debug-using-docker: docker-image docker-rm public
	docker run --rm -ti -v $(shell pwd):/var/blog -p 1313:1313 --name blog-builder blog-builder bash
