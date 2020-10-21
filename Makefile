
.PHONY: help
help:
	-@echo "====================== crypt Make file! ======================"
	-@echo "Commands:"
	-@echo "        make help                    (print this help message)"
	-@echo "        make install                   (compile and install to"
	-@echo "                                           ~/.local/{bin,lib})"
	-@echo "        make uninstall                 (remove installed files"
	-@echo "                                              from those dirs)"


.PHONY: install
install:
	bash ./make.sh install
.PHONY: install
uninstall:
	bash ./make.sh uninstall
