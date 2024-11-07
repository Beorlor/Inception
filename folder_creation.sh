if [ -d "/home/jedurand/data/wordpress" ]; then \
	echo "/home/jedurand/data/wordpress already exists"; else \
	sudo mkdir -p /home/jedurand/data/wordpress; \
fi

if [ -d "/home/jedurand/data/maria" ]; then \
	echo "/home/jedurand/data/maria already exists"; else \
	sudo mkdir -p /home/jedurand/data/maria; \
fi
