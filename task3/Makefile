SRC_DIR := src
REPORT_DIR := report

SRC := $(SRC_DIR)/main
REPORT := $(REPORT_DIR)/report.pdf

DN := dune exec
PDFLTX := pdflatex

OUTPUT := --output-directory

.PHONY: all

all: run-src run-report clean-aux

run-src: $(SRC)
	@echo "Running main.."
	cd $<
	$(DN) main
	cd ../../

run-report: $(REPORT)
	@echo "Running report.."
	@zathura $<

$(REPORT): $(REPORT_DIR)/*.tex
	@echo "Building pdf.."
	$(PDFLTX) $(OUTPUT)=$(REPORT_DIR) $<
	$(PDFLTX) $(OUTPUT)=$(REPORT_DIR) $<

clean-aux:
	@echo "Cleaning up auxiliary files.."
	@find $(REPORT_DIR) -type f ! -name '*.pdf' ! -name '*.tex' -delete
