modules:
	@$(MAKE) -C reverse/ build
	@$(MAKE) -C derivative/ build

clean:
	@rm -rf **/.cm
	@rm -rf bin/