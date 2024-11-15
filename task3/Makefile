ANNUITET_DIR := annuitet

ANNUITET := $(ANNUITET_DIR)/annuitet.pdf

PDFLTX := pdflatex

OUTPUT := --output-directory

.PHONY: all

all: run-annuitet clean-aux

run-annuitet: $(ANNUITET)
	@echo "Running report.."
	@zathura $<

$(ANNUITET): $(ANNUITET_DIR)/*.tex
	@echo "Building pdf.."
	$(PDFLTX) $(OUTPUT)=$(ANNUITET_DIR) $<
	$(PDFLTX) $(OUTPUT)=$(ANNUITET_DIR) $<

clean-aux:
	@echo "Cleaning up auxiliary files.."
	@find $(ANNUITET_DIR) -type f ! -name '*.pdf' ! -name '*.tex' -delete
