generate: public
	hugo

preview: public
	hugo preview

public:
	git clone git@github.com:goconca/homepage.git public

.PHONY: preview generate
