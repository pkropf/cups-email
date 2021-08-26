CUPS_PPD_DIR?=/usr/share/cups/model
CUPS_BACKEND_DIR?=/usr/lib/cups/backend
PS2PDF?=/usr/bin/epstopdf
MAILX?=/usr/bin/mailx
TMPDIR?=/tmp

Q?=@

install:
	$(Q)echo "Installing to $(DESTDIR)/"
	$(Q)install -D -m644 emailx.ppd $(DESTDIR)/$(CUPS_PPD_DIR)/emailx.ppd
	$(Q)install -D -m755 emailx $(DESTDIR)/$(CUPS_BACKEND_DIR)/emailx
	$(Q)sed -i "s,/usr/bin/epstopdf,$(PS2PDF),g" $(DESTDIR)/$(CUPS_PPD_DIR)/emailx.ppd
	$(Q)sed -i "s,/usr/bin/mailx,$(MAILX),g" $(DESTDIR)/$(CUPS_PPD_DIR)/emailx.ppd
	$(Q)sed -i "s,/tmp,$(TMPDIR),g" $(DESTDIR)/$(CUPS_PPD_DIR)/emailx.ppd

check:
	$(Q)test -x $(PS2PDF)||echo "epstopdf in $(PS2PDF) is not executable"
	$(Q)test -x $(MAILX)||echo "mailx in $(MAILX) is not executable"

inst_check: check
	$(Q)lpinfo -m | grep -q emailx.ppd || echo "emailx.ppd not available in lpinfo listing"
