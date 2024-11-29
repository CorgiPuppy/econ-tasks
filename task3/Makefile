SRC_DIR := src/main/bin
REPORT_DIR := report
TARGET_DIR := target

EXE := $(TARGET_DIR)/main
SRC := $(wildcard $(SRC_DIR)/*.ml)
REPORT := $(REPORT_DIR)/report.pdf

CMLC := ocamlc
PDFLTX := pdflatex

OUTPUT := --output-directory

.PHONY: all

all: clean-report run-src clean run-report clean-aux

run-src: $(EXE)
	@echo "Running exe.."
	./$< 

$(EXE): $(SRC) | $(TARGET_DIR)
	@echo "Building binaries.."
	$(CMLC) $^ -o $@

$(TARGET_DIR):
	@echo "Create a target dir.."
	@mkdir -p $@

clean:
	@echo "Cleaning up.."
	@$(RM) -rv $(TARGET_DIR) $(SRC_DIR)/main.cmi $(SRC_DIR)/main.cmo

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

clean-report:
	@echo "Cleaning up a report.."
	@$(RM) $(REPORT)
