default: render

date := `date '+%Y%m%d-%H%M'`

test:
	quarto --version

preview:
	quarto preview --port 3685

render:
	quarto render
	chmod -R 755 ./docs/site_libs/

fix:
	sqlfluff fix .

lint:
	sqlfluff lint .